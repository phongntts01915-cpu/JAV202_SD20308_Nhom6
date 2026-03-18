package com.example.asmnews.servlet;

import com.example.asmnews.dao.CategoryDAO;
import com.example.asmnews.dao.NewsDAO;
import com.example.asmnews.entity.Category;
import com.example.asmnews.entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.asmnews.dao.commentDAO;
import com.example.asmnews.entity.Comment;
// VỊ TRÍ 1: Import ReactionDAO
import com.example.asmnews.dao.ReactionDAO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý hiển thị tin tức
 */
@WebServlet("/news")
public class NewsServlet extends BaseServlet {

    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private commentDAO commentDAO = new commentDAO();
    // VỊ TRÍ 2: Khởi tạo ReactionDAO
    private ReactionDAO reactionDAO = new ReactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = getParameter(request, "action", "list");

        try {
            // Lấy danh sách categories cho menu
            List<Category> categories = categoryDAO.findAll();
            request.setAttribute("categories", categories);

            switch (action) {
                case "detail":
                    showNewsDetail(request, response);
                    break;
                case "category":
                    showNewsByCategory(request, response);
                    break;
                case "list":
                default:
                    showAllNews(request, response);
                    break;
            }

        } catch (Exception e) {
            System.err.println("Lỗi trong NewsServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Có lỗi xảy ra khi tải tin tức");
        }
    }

    /**
     * Hiển thị tất cả tin tức
     */
    private void showAllNews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<News> newsList = newsDAO.findAll();
        request.setAttribute("newsList", newsList);
        request.setAttribute("pageTitle", "Tất cả tin tức");

        forward(request, response, "/WEB-INF/views/public/news-list.jsp");
    }

    /**
     * Hiển thị tin tức theo category
     */
    private void showNewsByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryId = getParameter(request, "id", "");

        if (categoryId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin loại tin");
            return;
        }

        // Lấy thông tin category
        Category category = categoryDAO.findById(categoryId);
        if (category == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy loại tin");
            return;
        }

        // Lấy tin tức theo category
        List<News> newsList = newsDAO.findByCategory(categoryId);

        request.setAttribute("newsList", newsList);
        request.setAttribute("category", category);
        request.setAttribute("pageTitle", "Tin tức " + category.getName());

        forward(request, response, "/WEB-INF/views/public/news-list.jsp");
    }

    /**
     * Hiển thị chi tiết tin tức
     */
    private void showNewsDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newsId = getParameter(request, "id", "");

        if (newsId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin tin tức");
            return;
        }

        // Lấy thông tin tin tức
        News news = newsDAO.findById(newsId);
        if (news == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy tin tức");
            return;
        }

        // Tăng lượt xem
        newsDAO.updateViewCount(newsId);
        news.increaseViewCount();

        // Lấy danh sách bình luận từ DB
        List<Comment> comments = commentDAO.findByNewsId(newsId);
        news.setCommentCount(comments.size()); // Gán số đếm bình luận vào bài báo
        request.setAttribute("commentsList", comments); // Đẩy danh sách bình luận ra giao diện JSP

        // VỊ TRÍ 3: Lấy số đếm Thích và Không thích từ DB gán vào bài báo
        news.setLikeCount(reactionDAO.countReactions(newsId, 1));
        news.setDislikeCount(reactionDAO.countReactions(newsId, 0));

        // Lấy tin tức cùng loại (không bao gồm tin hiện tại)
        List<News> relatedNews = newsDAO.findByCategory(news.getCategoryId());
        relatedNews.removeIf(n -> n.getId().equals(newsId));
        if (relatedNews.size() > 5) {
            relatedNews = relatedNews.subList(0, 5);
        }

        request.setAttribute("news", news);
        request.setAttribute("relatedNews", relatedNews);
        request.setAttribute("pageTitle", news.getTitle());

        forward(request, response, "/WEB-INF/views/public/news-detail.jsp");
    }
}