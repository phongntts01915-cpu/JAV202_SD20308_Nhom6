package controller;

import dao.IProductDAO;
import dao.impl.ProductDAOImpl;
import entity.CartItem;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CartServlet", urlPatterns = { "/cart" })
public class CartServlet extends HttpServlet {

    private IProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("view".equals(action)) {
            req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addToCart(req, resp);
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        HttpSession session = req.getSession();

        // Lấy giỏ hàng từ session (nếu chưa có thì tạo mới)
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        if (cart.containsKey(id)) {
            // Món đã có -> Tăng số lượng
            CartItem item = cart.get(id);
            item.setQuantity(item.getQuantity() + 1);
        } else {
            // Món mới -> Lấy thông tin từ DB và bỏ vào giỏ
            Product p = productDAO.findById(id);
            if (p != null) {
                cart.put(id, new CartItem(p.getId(), p.getName(), p.getPrice(), 1));
            }
        }

        session.setAttribute("cart", cart);

        // Trả về JSON để JavaScript phía Client nhận được
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"success\", \"totalItems\":" + cart.size() + "}");
    }
}