package dao.impl;

import entity.Customer;
import util.DBConnect;
import java.sql.*;

public class CustomerDAOImpl {

    // Kiểm tra xem Username hoặc Email đã bị người khác đăng ký chưa
    public boolean checkExist(String username, String email) {
        String sql = "SELECT id FROM Customers WHERE username = ? OR email = ?";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có kết quả nghĩa là đã tồn tại
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm khách hàng mới vào Database
    public boolean register(Customer c) {
        String sql = "INSERT INTO Customers (fullname, email, phone, address, username, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getFullname());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getPhone()); // Bạn có thể đổi dữ liệu test tại đây
            ps.setString(4, c.getAddress());
            ps.setString(5, c.getUsername());
            ps.setString(6, c.getPassword());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}