package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// 👉 GHI CHÚ: Dòng này khai báo Filter sẽ chạy trên TẤT CẢ các URL bắt đầu bằng /admin/
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/admin/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false); // false: Không tự tạo session mới

        // Kiểm tra xem session có tồn tại và có chứa USER_ROLE (chứng tỏ đã login) hay
        // không
        boolean isLoggedIn = (session != null && session.getAttribute("USER_ROLE") != null);

        if (isLoggedIn) {
            // Cho phép đi tiếp vào Servlet/JSP tương ứng
            chain.doFilter(request, response);
        } else {
            // Chưa đăng nhập -> Chuyển hướng về trang login kèm thông báo
            res.sendRedirect(req.getContextPath() + "/login?msg=auth_required");
        }
    }
}