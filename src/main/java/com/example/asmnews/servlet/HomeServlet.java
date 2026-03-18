package com.example.asmnews.servlet;

import com.example.asmnews.dao.CategoryDAO;
import com.example.asmnews.dao.NewsDAO;
import com.example.asmnews.entity.Category;
import com.example.asmnews.entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý trang chủ
 */
@WebServlet(urlPatterns = { "/", "/home" })
public class HomeServlet extends BaseServlet {

    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy danh sách categories cho menu
            List<Category> categories = categoryDAO.findAll();
            request.setAttribute("categories", categories);

            // Lấy tin tức hiển thị trên trang chủ
            List<News> homeNews = newsDAO.findHomeNews();
            request.setAttribute("homeNews", homeNews);

            // Lấy 5 tin được xem nhiều nhất
            List<News> mostViewedNews = newsDAO.findTop5MostViewed();
            request.setAttribute("mostViewedNews", mostViewedNews);

            // Lấy 5 tin mới nhất
            List<News> latestNews = newsDAO.findTop5Latest();
            request.setAttribute("latestNews", latestNews);

            // Forward đến trang chủ
            forward(request, response, "/WEB-INF/views/public/index.jsp");

        } catch (Exception e) {
            System.err.println("Lỗi trong HomeServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Có lỗi xảy ra khi tải trang chủ");
        }
    }
}
