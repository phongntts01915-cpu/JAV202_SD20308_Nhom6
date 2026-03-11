// src/main/java/dao/impl/UserDAOImpl.java
package dao.impl;

import dao.IUserDAO;
import entity.User;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAOImpl implements IUserDAO {
    @Override
    public User checkLogin(String username, String hashedPassword) {
        // Chỉ lấy user có status = 1 (đang hoạt động)
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ? AND status = 1";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, hashedPassword);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Map data sang Entity
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("fullname"),
                            rs.getString("role"),
                            rs.getBoolean("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Sai tài khoản hoặc mật khẩu
    }
    // Thêm các hàm này vào bên dưới hàm checkLogin trong UserDAOImpl.java

    // Lấy danh sách tất cả người dùng
    public java.util.List<User> findAll() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(rs.getInt("id"), rs.getString("username"),
                        rs.getString("password"), rs.getString("fullname"),
                        rs.getString("role"), rs.getBoolean("status")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Kiểm tra username đã tồn tại chưa
    public boolean checkUsernameExist(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm người dùng mới
    public boolean insert(User u) {
        String sql = "INSERT INTO Users (username, password, fullname, role, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword()); // Pass này ĐÃ ĐƯỢC BĂM từ Servlet
            ps.setString(3, u.getFullname());
            ps.setString(4, u.getRole());
            ps.setBoolean(5, u.isStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa người dùng
    public boolean delete(int id) {
        String sql = "DELETE FROM Users WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ==========================================
    // TÍNH NĂNG ĐỔI MẬT KHẨU (Bảo mật 2 lớp)
    // ==========================================
    public boolean changePassword(int userId, String oldHashedPass, String newHashedPass) {
        // Lệnh UPDATE có kèm điều kiện kiểm tra mật khẩu cũ ngay trong SQL (Performance
        // tối ưu nhất)
        // 👉 GHI CHÚ CHỈNH SỬA: Nếu bạn đổi tên cột trong Database, hãy sửa lại ở đây.
        String sql = "UPDATE Users SET password = ? WHERE id = ? AND password = ?";
        try (Connection conn = util.DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newHashedPass);
            ps.setInt(2, userId);
            ps.setString(3, oldHashedPass);

            // Nếu executeUpdate() trả về > 0 nghĩa là ID và Mật khẩu cũ khớp -> Update
            // thành công
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}