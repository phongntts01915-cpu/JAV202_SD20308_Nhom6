package com.example.asmnews.dao;

import com.example.asmnews.entity.User;
import com.example.asmnews.utils.DatabaseUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho User
 * Thực hiện các thao tác CRUD với bảng Users
 */
public class UserDAO {

    /**
     * Lấy tất cả users
     * 
     * @return List<User>
     */
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        // Thêm IsActive vào câu SELECT
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role, IsActive " +
                "FROM Users ORDER BY Fullname";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách users: " + e.getMessage());
        }
        return users;
    }

    /**
     * Tìm user theo ID
     * 
     * @param id ID của user
     * @return User hoặc null nếu không tìm thấy
     */
    public User findById(String id) {
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role " +
                "FROM Users WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm user theo ID: " + e.getMessage());
        }

        return null;
    }

    /**
     * Tìm user theo email
     * 
     * @param email Email của user
     * @return User hoặc null nếu không tìm thấy
     */
    public User findByEmail(String email) {
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role " +
                "FROM Users WHERE Email = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm user theo email: " + e.getMessage());
        }

        return null;
    }

    /**
     * Đăng nhập user
     * 
     * @param id       ID đăng nhập
     * @param password Mật khẩu
     * @return User nếu đăng nhập thành công, null nếu thất bại
     */
    public User login(String id, String password) {
        // Thêm IsActive vào câu SELECT
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role, IsActive " +
                "FROM Users WHERE Id = ? AND Password = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đăng nhập: " + e.getMessage());
        }
        return null;
    }

    /**
     * Lấy danh sách phóng viên
     * 
     * @return List<User> chỉ chứa phóng viên
     */
    public List<User> findReporters() {
        List<User> reporters = new ArrayList<>();
        String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role " +
                "FROM Users WHERE Role = 0 ORDER BY Fullname";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                reporters.add(user);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách phóng viên: " + e.getMessage());
        }

        return reporters;
    }

    /**
     * Thêm user mới
     * 
     * @param user User cần thêm
     * @return true nếu thành công
     */
    public boolean insert(User user) {
        String sql = "INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setDate(4, user.getBirthday() != null ? new java.sql.Date(user.getBirthday().getTime()) : null);
            ps.setObject(5, user.getGender());
            ps.setString(6, user.getMobile());
            ps.setString(7, user.getEmail());
            ps.setInt(8, user.getRole());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cập nhật user
     * 
     * @param user User cần cập nhật
     * @return true nếu thành công
     */
    public boolean update(User user) {
        String sql = "UPDATE Users SET Password = ?, Fullname = ?, Birthday = ?, Gender = ?, " +
                "Mobile = ?, Email = ?, Role = ? WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getPassword());
            ps.setString(2, user.getFullname());
            ps.setDate(3, user.getBirthday() != null ? new java.sql.Date(user.getBirthday().getTime()) : null);
            ps.setObject(4, user.getGender());
            ps.setString(5, user.getMobile());
            ps.setString(6, user.getEmail());
            ps.setInt(7, user.getRole());
            ps.setString(8, user.getId());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Xóa user
     * 
     * @param id ID của user cần xóa
     * @return true nếu thành công
     */
    public boolean delete(String id) {
        String sql = "DELETE FROM Users WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa user: " + e.getMessage());
            return false;
        }
    }

    /**
     * Kiểm tra user có tồn tại không
     * 
     * @param id ID cần kiểm tra
     * @return true nếu tồn tại
     */
    public boolean exists(String id) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra user tồn tại: " + e.getMessage());
        }

        return false;
    }

    /**
     * Kiểm tra email có tồn tại không
     * 
     * @param email Email cần kiểm tra
     * @return true nếu tồn tại
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra email tồn tại: " + e.getMessage());
        }

        return false;
    }

    /**
     * Map ResultSet thành User object
     * 
     * @param rs ResultSet
     * @return User
     * @throws SQLException
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getString("Id"));
        user.setPassword(rs.getString("Password"));
        user.setFullname(rs.getString("Fullname"));
        user.setBirthday(rs.getDate("Birthday"));

        Object gender = rs.getObject("Gender");
        user.setGender(gender != null ? (Boolean) gender : null);

        user.setMobile(rs.getString("Mobile"));
        user.setEmail(rs.getString("Email"));
        user.setRole(rs.getInt("Role"));

        // [THÊM DÒNG NÀY]: Đọc trạng thái khóa từ Database
        user.setActive(rs.getBoolean("IsActive"));

        return user;
    }

    /**
     * Đổi mật khẩu (Dành cho người dùng đã đăng nhập)
     */
    public boolean changePassword(String userId, String oldPassword, String newPassword) {
        String checkSql = "SELECT Id FROM Users WHERE Id = ? AND Password = ?";
        String updateSql = "UPDATE Users SET Password = ? WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection()) {
            // 1. Kiểm tra mật khẩu cũ có đúng không
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, userId);
                checkStmt.setString(2, oldPassword);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next())
                        return false; // Sai pass cũ
                }
            }
            // 2. Cập nhật pass mới
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, userId);
                return updateStmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Quên mật khẩu: Kiểm tra đúng Username + Email thì cập nhật pass mới
     * (Security Note: Thực tế sẽ gửi link qua Email, ở đây ta làm Reset trực tiếp)
     */
    public boolean resetPassword(String userId, String email, String newPassword) {
        String checkSql = "SELECT Id FROM Users WHERE Id = ? AND Email = ?";
        String updateSql = "UPDATE Users SET Password = ? WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection()) {
            // 1. Kiểm tra ID và Email có khớp không
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, userId);
                checkStmt.setString(2, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next())
                        return false; // Không tồn tại user hoặc sai email
                }
            }
            // 2. Cập nhật pass mới
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, userId);
                return updateStmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật trạng thái Khóa/Mở khóa tài khoản
     */
    public boolean toggleStatus(String userId, boolean isActive) {
        String sql = "UPDATE Users SET IsActive = ? WHERE Id = ?";
        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isActive);
            stmt.setString(2, userId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi đổi trạng thái User: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
