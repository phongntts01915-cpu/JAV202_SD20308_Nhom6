package controller;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = { "/admin/users" })
public class UserServlet extends HttpServlet {

    private IUserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "delete":
                    int id = Integer.parseInt(req.getParameter("id"));

                    // 👉 LOGIC BẢO VỆ: Không cho tự xóa chính mình
                    HttpSession session = req.getSession();
                    int currentUserId = (Integer) session.getAttribute("USER_ID");
                    if (id == currentUserId) {
                        req.setAttribute("error", "Hành động bị từ chối: Không thể tự xóa tài khoản đang đăng nhập!");
                        listUsers(req, resp);
                        return;
                    }

                    userDAO.delete(id);
                    resp.sendRedirect(req.getContextPath() + "/admin/users");
                    break;
                case "list":
                default:
                    listUsers(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            listUsers(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {

            // ==========================================
            // 1. LẤY DỮ LIỆU TỪ FORM THÊM MỚI (SỬA DỮ LIỆU TẠI ĐÂY)
            // ==========================================
            String username = req.getParameter("username");
            String fullname = req.getParameter("fullname");
            String password = req.getParameter("password");
            String role = req.getParameter("role"); // Sẽ là ADMIN hoặc STAFF

            // Server-side Validation
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                req.setAttribute("error", "Tên đăng nhập và mật khẩu không được để trống!");
                listUsers(req, resp);
                return;
            }

            // Kiểm tra trùng lặp Username
            if (userDAO.checkUsernameExist(username)) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại trong hệ thống!");
                listUsers(req, resp);
                return;
            }

            // ==========================================
            // 2. MÃ HÓA MẬT KHẨU TRƯỚC KHI LƯU
            // ==========================================
            String hashedPass = SecurityUtil.hashSHA256(password);

            // Khởi tạo Entity (Mặc định status = true)
            User newUser = new User(0, username, hashedPass, fullname, role, true);

            // Lưu vào DB
            userDAO.insert(newUser);
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("users", userDAO.findAll());
        req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
    }
}