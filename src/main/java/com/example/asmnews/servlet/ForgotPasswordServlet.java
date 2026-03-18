package com.example.asmnews.servlet;

import com.example.asmnews.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends BaseServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        forward(request, response, "/WEB-INF/views/auth/forgot-password.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        // Hardcode mật khẩu mới cho dự án học tập. (Thực tế sẽ tạo mã Random)
        String newDefaultPassword = "123";

        if (userDAO.resetPassword(username, email, newDefaultPassword)) {
            setSuccessMessage(request, "Khôi phục thành công! Mật khẩu mới của bạn là: " + newDefaultPassword);
            redirect(response, request.getContextPath() + "/login");
        } else {
            setErrorMessage(request, "Tên đăng nhập hoặc Email không tồn tại!");
            redirect(response, request.getContextPath() + "/forgot-password");
        }
    }
}