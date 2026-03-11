package controller;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = { "/change-password" })
public class ChangePasswordServlet extends HttpServlet {

    private IUserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("USER_ID");

        // Kiểm tra xem đã đăng nhập chưa (Security Filter phụ)
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String oldPass = req.getParameter("oldPassword");
        String newPass = req.getParameter("newPassword");
        String confirmPass = req.getParameter("confirmPassword");

        // 1. Validate Form cơ bản
        if (!newPass.equals(confirmPass)) {
            session.setAttribute("toastMsg", "Mật khẩu xác nhận không khớp!");
            session.setAttribute("toastType", "danger");
            resp.sendRedirect(req.getHeader("Referer")); // Trả về đúng trang hiện tại
            return;
        }

        // 2. Hash cả 2 password bằng thuật toán SHA-256
        String hashedOld = SecurityUtil.hashSHA256(oldPass);
        String hashedNew = SecurityUtil.hashSHA256(newPass);

        // 3. Thực thi update xuống DB
        boolean success = userDAO.changePassword(userId, hashedOld, hashedNew);

        if (success) {
            session.setAttribute("toastMsg", "Đổi mật khẩu thành công!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMsg", "Mật khẩu cũ không chính xác!");
            session.setAttribute("toastType", "danger");
        }

        // Trả người dùng về đúng trang họ vừa đứng (ví dụ đang ở Hóa đơn thì ở lại Hóa
        // đơn)
        resp.sendRedirect(req.getHeader("Referer"));
    }
}