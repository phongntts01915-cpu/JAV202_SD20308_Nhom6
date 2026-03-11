package controller;

import dao.impl.BillDAOImpl;
import entity.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = { "/checkout" })
public class CheckoutServlet extends HttpServlet {
    private BillDAOImpl billDAO = new BillDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 1. Tính tổng tiền
        double total = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();

        // 2. Lấy thông tin User (Tạm thời lấy StaffId = 1 nếu là khách tự đặt)
        int staffId = (session.getAttribute("USER_ID") != null) ? (int) session.getAttribute("USER_ID") : 1;
        // customerId mặc định 1 cho khách vãng lai
        int customerId = 1;

        // 3. Thực hiện lưu vào DB
        boolean success = billDAO.createOrder(customerId, staffId, total, cart);

        if (success) {
            session.removeAttribute("cart"); // 🚀 "Một nốt nhạc" - Xóa giỏ hàng
            resp.sendRedirect(req.getContextPath() + "/home?msg=order_success");
        } else {
            req.setAttribute("error", "Thanh toán thất bại, vui lòng thử lại!");
            req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
        }
    }
}