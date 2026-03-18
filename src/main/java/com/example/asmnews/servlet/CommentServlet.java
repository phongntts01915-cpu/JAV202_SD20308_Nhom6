package com.example.asmnews.servlet;

import com.example.asmnews.dao.commentDAO;
import com.example.asmnews.entity.Comment;
import com.example.asmnews.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebServlet("/comment/action")
public class CommentServlet extends BaseServlet {

    private commentDAO commentDAO = new commentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Cấu hình trả về JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Vui lòng đăng nhập!\"}");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String content = request.getParameter("content");
                // Kiểm tra rỗng CHỈ áp dụng cho chức năng Thêm
                if (content == null || content.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Nội dung trống!\"}");
                    return;
                }

                String newsId = request.getParameter("newsId");
                Comment comment = new Comment();
                comment.setNewsId(newsId);
                comment.setUserId(currentUser.getId());
                comment.setContent(content.trim());
                comment.setCreatedDate(new Date());

                if (commentDAO.insert(comment)) {
                    String jsonResponse = String.format(
                            "{\"status\":\"success\", \"fullname\":\"%s\", \"content\":\"%s\"}",
                            currentUser.getFullname().replace("\"", "\\\""),
                            content.replace("\"", "\\\"").replace("\n", "\\n"));
                    response.getWriter().write(jsonResponse);
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }

            } else if ("edit".equals(action)) {
                String content = request.getParameter("content");
                // Kiểm tra rỗng CHỈ áp dụng cho chức năng Sửa
                if (content == null || content.trim().isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Nội dung trống!\"}");
                    return;
                }

                int commentId = Integer.parseInt(request.getParameter("commentId"));

                if (commentDAO.update(commentId, currentUser.getId(), content.trim())) {
                    response.getWriter().write("{\"status\":\"success\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Không có quyền sửa!\"}");
                }

            } else if ("report".equals(action)) {
                // Chức năng Báo cáo KHÔNG CẦN kiểm tra nội dung
                int commentId = Integer.parseInt(request.getParameter("commentId"));

                if (commentDAO.reportComment(commentId)) {
                    response.getWriter().write("{\"status\":\"success\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}