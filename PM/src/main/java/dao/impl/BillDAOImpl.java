package dao.impl;

import entity.CartItem;
import util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class BillDAOImpl {

    /**
     * Lấy danh sách hóa đơn kèm chi tiết tên khách và tên nhân viên
     * Dùng cho trang Quản lý hóa đơn (Staff/Admin)
     */
    public List<Map<String, Object>> findAllWithDetails() {
        List<Map<String, Object>> list = new ArrayList<>();

        // 👉 GHI CHÚ CHỈNH SỬA: Câu lệnh SQL JOIN 3 bảng
        String sql = "SELECT b.*, c.fullname as customerName, u.fullname as staffName " +
                "FROM Bills b " +
                "LEFT JOIN Customers c ON b.customerId = c.id " +
                "LEFT JOIN Users u ON b.staffId = u.id " +
                "ORDER BY b.createDate DESC";

        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("date", rs.getTimestamp("createDate"));
                map.put("amount", rs.getBigDecimal("totalAmount"));
                map.put("status", rs.getInt("status"));
                map.put("customerName", rs.getString("customerName"));
                map.put("staffName", rs.getString("staffName"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Tạo hóa đơn mới (Bao gồm Bill và BillDetails)
     * Sử dụng Transaction để đảm bảo tính toàn vẹn dữ liệu
     */
    public boolean createOrder(int customerId, int staffId, double total, Map<Integer, CartItem> cart) {
        Connection conn = null;
        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false); // BẮT ĐẦU TRANSACTION

            // 1. Chèn vào bảng Bills
            String sqlBill = "INSERT INTO Bills (customerId, staffId, totalAmount, status) VALUES (?, ?, ?, 0)";
            PreparedStatement psBill = conn.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS);
            psBill.setInt(1, customerId);
            psBill.setInt(2, staffId);
            psBill.setDouble(3, total);
            psBill.executeUpdate();

            // Lấy ID tự tăng vừa được sinh ra
            ResultSet rs = psBill.getGeneratedKeys();
            int billId = 0;
            if (rs.next())
                billId = rs.getInt(1);

            // 2. Chèn hàng loạt vào bảng BillDetails
            String sqlDetail = "INSERT INTO BillDetails (billId, productId, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);

            for (CartItem item : cart.values()) {
                psDetail.setInt(1, billId);
                psDetail.setInt(2, item.getProductId());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getPrice());
                psDetail.addBatch(); // Gom lệnh để tối ưu hiệu suất
            }
            psDetail.executeBatch();

            conn.commit(); // XÁC NHẬN HOÀN TẤT
            return true;
        } catch (Exception e) {
            try {
                if (conn != null)
                    conn.rollback(); // LỖI THÌ QUAY LẠI TRẠNG THÁI CŨ
            } catch (SQLException se) {
                se.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // ============================================================
    // 3. THỐNG KÊ DOANH THU THEO THÁNG (Dành cho Quản lý)
    // ============================================================
    public double[] getRevenueByMonth(int year) {
        double[] revenue = new double[12]; // Mảng 12 tháng
        String sql = "SELECT MONTH(createDate) as month, SUM(totalAmount) as total " +
                "FROM Bills WHERE YEAR(createDate) = ? AND status = 1 " + // Chỉ tính hóa đơn đã thanh toán
                "GROUP BY MONTH(createDate)";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int month = rs.getInt("month");
                    revenue[month - 1] = rs.getDouble("total"); // Gán vào mảng (tháng 1 là index 0)
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenue;
    }

    // ============================================================
    // 4. THỐNG KÊ TOP 5 SẢN PHẨM BÁN CHẠY NHẤT
    // ============================================================
    public Map<String, Integer> getTopSellingProducts() {
        Map<String, Integer> map = new LinkedHashMap<>(); // Giữ nguyên thứ tự sắp xếp
        String sql = "SELECT TOP 5 p.name, SUM(bd.quantity) as totalQty " +
                "FROM BillDetails bd " +
                "JOIN Products p ON bd.productId = p.id " +
                "JOIN Bills b ON bd.billId = b.id " +
                "WHERE b.status = 1 " +
                "GROUP BY p.name " +
                "ORDER BY totalQty DESC";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("name"), rs.getInt("totalQty"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    // ============================================================
    // DÀNH CHO NHÂN VIÊN: Chỉ lấy danh sách hóa đơn DO CHÍNH HỌ TẠO
    // ============================================================
    public List<Map<String, Object>> findByStaffIdWithDetails(int staffId) {
        List<Map<String, Object>> list = new ArrayList<>();
        // Câu lệnh SQL thêm điều kiện WHERE b.staffId = ?
        String sql = "SELECT b.*, c.fullname as customerName, u.fullname as staffName " +
                "FROM Bills b " +
                "LEFT JOIN Customers c ON b.customerId = c.id " +
                "LEFT JOIN Users u ON b.staffId = u.id " +
                "WHERE b.staffId = ? " +
                "ORDER BY b.createDate DESC";

        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId); // Truyền ID của nhân viên đang đăng nhập vào
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("date", rs.getTimestamp("createDate"));
                    map.put("amount", rs.getBigDecimal("totalAmount"));
                    map.put("status", rs.getInt("status"));
                    map.put("customerName", rs.getString("customerName"));
                    map.put("staffName", rs.getString("staffName"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ============================================================
    // CẬP NHẬT TRẠNG THÁI HÓA ĐƠN (Từ "Chưa thanh toán" -> "Đã thanh toán")
    // ============================================================
    public boolean updateBillStatus(int billId, int newStatus) {
        String sql = "UPDATE Bills SET status = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, billId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}