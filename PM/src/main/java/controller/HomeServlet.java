package controller;

import dao.IProductDAO;
import dao.impl.ProductDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = { "/home", "" })
public class HomeServlet extends HttpServlet {
    private IProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách sản phẩm để hiện ở trang chủ
        req.setAttribute("productList", productDAO.findAll());
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}