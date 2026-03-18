// src/main/java/controller/LoginServlet.java
package controller;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {

    private IUserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Xóa session cũ nếu người dùng cố tình vào lại trang login
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // 1. Server-side Validation
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tài khoản và mật khẩu!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // 2. Băm mật khẩu người dùng nhập vào
        String hashedPass = SecurityUtil.hashSHA256(pass);

        // 3. Kiểm tra với Database
        User loggedInUser = userDAO.checkLogin(user, hashedPass);

        if (loggedInUser != null) {
            // Đăng nhập thành công -> Tạo Session
            HttpSession session = req.getSession(true);
            session.setAttribute("USER_ID", loggedInUser.getId());
            session.setAttribute("USER_FULLNAME", loggedInUser.getFullname());

            // 👉 GHI CHÚ CHỈNH SỬA: Phân quyền nằm ở biến này (ADMIN hoặc STAFF)
            session.setAttribute("USER_ROLE", loggedInUser.getRole());

            // Điều hướng vào trang quản trị
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            // Đăng nhập thất bại
            req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}