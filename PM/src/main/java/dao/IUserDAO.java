package dao;

import entity.User;
import java.util.List; // Nhớ import thư viện List

public interface IUserDAO {

    // 1. Dùng cho luồng Đăng nhập (LoginServlet)
    // Trả về User nếu đăng nhập thành công, trả về null nếu thất bại
    User checkLogin(String username, String hashedPassword);

    // ==========================================
    // CÁC HÀM DÙNG CHO LUỒNG QUẢN LÝ (UserServlet)
    // ==========================================

    // 2. Lấy danh sách tất cả người dùng
    List<User> findAll();

    // 3. Kiểm tra xem username đã tồn tại trong database chưa (chống trùng lặp)
    boolean checkUsernameExist(String username);

    // 4. Thêm người dùng mới vào hệ thống
    boolean insert(User u);

    // 5. Xóa người dùng theo ID
    boolean delete(int id);

    boolean changePassword(int userId, String oldHashedPass, String newHashedPass);

}