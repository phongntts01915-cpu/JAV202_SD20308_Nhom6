package controller;

import dao.impl.CustomerDAOImpl;
import entity.Customer;
import util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = { "/register" })
public class RegisterServlet extends HttpServlet {

    private CustomerDAOImpl customerDAO = new CustomerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String username = req.getParameter("username");
        String pass = req.getParameter("password");
        String confirmPass = req.getParameter("confirmPassword");

        // 1. Validation cơ bản
        if (!pass.equals(confirmPass)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra trùng lặp
        if (customerDAO.checkExist(username, email)) {
            req.setAttribute("error", "Tên đăng nhập hoặc Email đã được sử dụng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // 3. Mã hóa mật khẩu (Security Best Practice)
        String hashedPass = SecurityUtil.hashSHA256(pass);

        // 4. Đóng gói và Lưu
        Customer newCustomer = new Customer(0, fullname, email, "", "", username, hashedPass);
        boolean success = customerDAO.register(newCustomer);

        if (success) {
            // Đăng ký thành công -> Chuyển về trang đăng nhập kèm thông báo
            resp.sendRedirect(req.getContextPath() + "/login?msg=register_success");
        } else {
            req.setAttribute("error", "Hệ thống đang bận, vui lòng thử lại sau!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}