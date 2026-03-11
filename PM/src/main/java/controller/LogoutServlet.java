package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = { "/logout" })
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy session hiện tại (false = không tạo mới nếu chưa có)
        HttpSession session = req.getSession(false);

        if (session != null) {
            // Hủy toàn bộ dữ liệu trong Session (USER_ID, USER_ROLE,...)
            session.invalidate();
        }

        // Điều hướng về trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}