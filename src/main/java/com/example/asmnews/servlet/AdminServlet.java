package com.example.asmnews.servlet;

import com.example.asmnews.dao.CategoryDAO;
import com.example.asmnews.dao.NewsDAO;
import com.example.asmnews.dao.NewsletterDAO;
import com.example.asmnews.dao.UserDAO;
import com.example.asmnews.entity.Category;
import com.example.asmnews.entity.News;
import com.example.asmnews.entity.Newsletter;
import com.example.asmnews.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet xử lý trang admin
 */
@WebServlet("/admin/*")
public class AdminServlet extends BaseServlet {

    private NewsDAO newsDAO = new NewsDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private UserDAO userDAO = new UserDAO();
    private NewsletterDAO newsletterDAO = new NewsletterDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền truy cập
        if (!checkAccess(request, response)) {
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null)
            pathInfo = "/";

        try {
            switch (pathInfo) {
                case "/":
                case "/dashboard":
                    showDashboard(request, response);
                    break;
                case "/news":
                    showNewsManagement(request, response);
                    break;
                case "/news/add":
                    showAddNews(request, response);
                    break;
                case "/news/edit":
                    showEditNews(request, response);
                    break;
                case "/categories":
                    showCategoryManagement(request, response);
                    break;
                case "/users":
                    showUserManagement(request, response);
                    break;
                case "/newsletters":
                    showNewsletterManagement(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Lỗi trong AdminServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Có lỗi xảy ra khi xử lý yêu cầu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền truy cập
        if (!checkAccess(request, response)) {
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null)
            pathInfo = "/";

        try {
            switch (pathInfo) {
                case "/news/save":
                    saveNews(request, response);
                    break;
                case "/news/delete":
                    deleteNews(request, response);
                    break;
                case "/categories/save":
                    saveCategory(request, response);
                    break;
                case "/categories/delete":
                    deleteCategory(request, response);
                    break;
                case "/users/save":
                    saveUser(request, response);
                    break;

                case "/users/toggle-status":
                    toggleUserStatus(request, response);
                    break;
                case "/newsletters/delete":
                    deleteNewsletter(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Lỗi trong AdminServlet POST: " + e.getMessage());
            e.printStackTrace();
            setErrorMessage(request, "Có lỗi xảy ra khi xử lý yêu cầu");
            redirect(response, request.getContextPath() + "/admin");
        }
    }

    /**
     * Hiển thị dashboard
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thống kê cơ bản
        List<News> allNews = newsDAO.findAll();
        List<Category> allCategories = categoryDAO.findAll();
        List<User> allUsers = userDAO.findAll();

        request.setAttribute("totalNews", allNews.size());
        request.setAttribute("totalCategories", allCategories.size());
        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("totalNewsletters", newsletterDAO.countActive());

        // Tin tức mới nhất
        List<News> latestNews = newsDAO.findTop5Latest();
        request.setAttribute("latestNews", latestNews);

        forward(request, response, "/WEB-INF/views/admin/dashboard.jsp");
    }

    /**
     * Hiển thị quản lý tin tức
     */
    private void showNewsManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = getCurrentUser(request);
        List<News> newsList;

        if (isAdmin(request)) {
            // Admin xem tất cả tin tức
            newsList = newsDAO.findAll();
        } else {
            // Phóng viên chỉ xem tin tức của mình
            newsList = newsDAO.findByAuthor(currentUser.getId());
        }

        request.setAttribute("newsList", newsList);
        forward(request, response, "/WEB-INF/views/admin/news-management.jsp");
    }

    /**
     * Hiển thị form thêm tin tức
     */
    private void showAddNews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);

        forward(request, response, "/WEB-INF/views/admin/news-form.jsp");
    }

    /**
     * Hiển thị form sửa tin tức
     */
    private void showEditNews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String newsId = getParameter(request, "id", "");
        if (newsId.isEmpty()) {
            setErrorMessage(request, "Thiếu thông tin tin tức");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        News news = newsDAO.findById(newsId);
        if (news == null) {
            setErrorMessage(request, "Không tìm thấy tin tức");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        // Kiểm tra quyền sửa (admin hoặc tác giả)
        User currentUser = getCurrentUser(request);
        if (!isAdmin(request) && !news.getAuthor().equals(currentUser.getId())) {
            setErrorMessage(request, "Bạn không có quyền sửa tin tức này");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.setAttribute("news", news);

        forward(request, response, "/WEB-INF/views/admin/news-form.jsp");
    }

    /**
     * Lưu tin tức
     */
    private void saveNews(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String newsId = getParameter(request, "id", "");
        String title = getParameter(request, "title", "");
        String content = getParameter(request, "content", "");
        String image = getParameter(request, "image", "");
        String categoryId = getParameter(request, "categoryId", "");
        boolean home = getBooleanParameter(request, "home");

        // Handle empty image - set to null if empty
        if (image != null && image.trim().isEmpty()) {
            image = null;
        }

        // Validate
        if (title.isEmpty() || content.isEmpty() || categoryId.isEmpty()) {
            setErrorMessage(request, "Vui lòng nhập đầy đủ thông tin bắt buộc");
            redirect(response, request.getContextPath() + "/admin/news/add");
            return;
        }

        User currentUser = getCurrentUser(request);
        boolean isEdit = !newsId.isEmpty();
        News news;

        if (isEdit) {
            // Sửa tin tức
            news = newsDAO.findById(newsId);
            if (news == null) {
                setErrorMessage(request, "Không tìm thấy tin tức");
                redirect(response, request.getContextPath() + "/admin/news");
                return;
            }

            // Kiểm tra quyền sửa
            if (!isAdmin(request) && !news.getAuthor().equals(currentUser.getId())) {
                setErrorMessage(request, "Bạn không có quyền sửa tin tức này");
                redirect(response, request.getContextPath() + "/admin/news");
                return;
            }

            news.setTitle(title);
            news.setContent(content);
            news.setImage(image);
            news.setCategoryId(categoryId);
            news.setHome(home);

        } else {
            // Thêm tin tức mới
            news = new News();
            news.setId("NEWS" + System.currentTimeMillis());
            news.setTitle(title);
            news.setContent(content);
            news.setImage(image);
            news.setCategoryId(categoryId);
            news.setAuthor(currentUser.getId());
            news.setPostedDate(new Date());
            news.setViewCount(0);
            news.setHome(home);
        }

        boolean success = isEdit ? newsDAO.update(news) : newsDAO.insert(news);

        if (success) {
            setSuccessMessage(request, isEdit ? "Cập nhật tin tức thành công!" : "Thêm tin tức thành công!");
        } else {
            setErrorMessage(request, isEdit ? "Có lỗi khi cập nhật tin tức" : "Có lỗi khi thêm tin tức");
        }

        redirect(response, request.getContextPath() + "/admin/news");
    }

    /**
     * Xóa tin tức
     */
    private void deleteNews(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String newsId = getParameter(request, "id", "");
        if (newsId.isEmpty()) {
            setErrorMessage(request, "Thiếu thông tin tin tức");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        News news = newsDAO.findById(newsId);
        if (news == null) {
            setErrorMessage(request, "Không tìm thấy tin tức");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        // Kiểm tra quyền xóa (admin hoặc tác giả)
        User currentUser = getCurrentUser(request);
        if (!isAdmin(request) && !news.getAuthor().equals(currentUser.getId())) {
            setErrorMessage(request, "Bạn không có quyền xóa tin tức này");
            redirect(response, request.getContextPath() + "/admin/news");
            return;
        }

        if (newsDAO.delete(newsId)) {
            setSuccessMessage(request, "Xóa tin tức thành công!");
        } else {
            setErrorMessage(request, "Có lỗi khi xóa tin tức");
        }

        redirect(response, request.getContextPath() + "/admin/news");
    }

    /**
     * Hiển thị quản lý categories (chỉ admin)
     */
    private void showCategoryManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);

        forward(request, response, "/WEB-INF/views/admin/category-management.jsp");
    }

    /**
     * Lưu category (chỉ admin)
     */
    private void saveCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        String categoryId = getParameter(request, "id", "");
        String categoryName = getParameter(request, "name", "");

        if (categoryName.isEmpty()) {
            setErrorMessage(request, "Vui lòng nhập tên loại tin");
            redirect(response, request.getContextPath() + "/admin/categories");
            return;
        }

        boolean isEdit = !categoryId.isEmpty();
        Category category;

        if (isEdit) {
            category = categoryDAO.findById(categoryId);
            if (category == null) {
                setErrorMessage(request, "Không tìm thấy loại tin");
                redirect(response, request.getContextPath() + "/admin/categories");
                return;
            }
            category.setName(categoryName);
        } else {
            category = new Category();
            category.setId(categoryName.toUpperCase().replaceAll("\\s+", "_"));
            category.setName(categoryName);
        }

        boolean success = isEdit ? categoryDAO.update(category) : categoryDAO.insert(category);

        if (success) {
            setSuccessMessage(request, isEdit ? "Cập nhật loại tin thành công!" : "Thêm loại tin thành công!");
        } else {
            setErrorMessage(request, isEdit ? "Có lỗi khi cập nhật loại tin" : "Có lỗi khi thêm loại tin");
        }

        redirect(response, request.getContextPath() + "/admin/categories");
    }

    /**
     * Xóa category (chỉ admin)
     */
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        String categoryId = getParameter(request, "id", "");
        if (categoryId.isEmpty()) {
            setErrorMessage(request, "Thiếu thông tin loại tin");
            redirect(response, request.getContextPath() + "/admin/categories");
            return;
        }

        if (categoryDAO.delete(categoryId)) {
            setSuccessMessage(request, "Xóa loại tin thành công!");
        } else {
            setErrorMessage(request, "Có lỗi khi xóa loại tin (có thể đang được sử dụng)");
        }

        redirect(response, request.getContextPath() + "/admin/categories");
    }

    /**
     * Hiển thị quản lý users (chỉ admin)
     */
    private void showUserManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        List<User> users = userDAO.findAll();
        request.setAttribute("users", users);

        forward(request, response, "/WEB-INF/views/admin/user-management.jsp");
    }

    /**
     * Lưu user (chỉ admin)
     */
    private void saveUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        String userId = getParameter(request, "id", "");
        String password = getParameter(request, "password", "");
        String fullname = getParameter(request, "fullname", "");
        String birthdayStr = getParameter(request, "birthday", "");
        String genderStr = getParameter(request, "gender", "");
        String mobile = getParameter(request, "mobile", "");
        String email = getParameter(request, "email", "");

        // --- [SỬA TỪ ĐÂY]: Đọc role dưới dạng Integer, có bắt lỗi an toàn ---
        int role = User.ROLE_READER; // Mặc định là Độc giả (Nguyên tắc đặc quyền tối thiểu)
        try {
            String roleStr = getParameter(request, "role", "");
            if (!roleStr.isEmpty()) {
                role = Integer.parseInt(roleStr);
            }
        } catch (NumberFormatException e) {
            System.err.println("Lỗi parse role: " + e.getMessage());
        }
        // --- [KẾT THÚC SỬA] ---

        // Validate
        if (fullname.isEmpty() || email.isEmpty()) {
            setErrorMessage(request, "Vui lòng nhập đầy đủ thông tin bắt buộc");
            redirect(response, request.getContextPath() + "/admin/users");
            return;
        }

        // ❗❗❗ SỬA Ở ĐÂY – XÁC ĐỊNH ĐÚNG LÀ THÊM HAY SỬA
        boolean isEdit = userDAO.findById(userId) != null;

        User user;

        if (isEdit) {
            user = userDAO.findById(userId);
            if (user == null) {
                setErrorMessage(request, "Không tìm thấy người dùng");
                redirect(response, request.getContextPath() + "/admin/users");
                return;
            }

            if (!password.isEmpty()) {
                user.setPassword(password);
            }
        } else {
            if (userId.isEmpty() || password.isEmpty()) {
                setErrorMessage(request, "Vui lòng nhập ID và mật khẩu cho người dùng mới");
                redirect(response, request.getContextPath() + "/admin/users");
                return;
            }

            user = new User();
            user.setId(userId);
            user.setPassword(password);
        }

        user.setFullname(fullname);
        user.setMobile(mobile);
        user.setEmail(email);
        user.setRole(role);

        // Parse birthday
        if (!birthdayStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                user.setBirthday(sdf.parse(birthdayStr));
            } catch (ParseException e) {
                // Ignore invalid date
            }
        }

        // Parse gender
        if (!genderStr.isEmpty()) {
            user.setGender("true".equals(genderStr) || "1".equals(genderStr));
        }

        boolean success = isEdit ? userDAO.update(user) : userDAO.insert(user);

        if (success) {
            setSuccessMessage(request, isEdit ? "Cập nhật người dùng thành công!" : "Thêm người dùng thành công!");
        } else {
            setErrorMessage(request, isEdit ? "Có lỗi khi cập nhật người dùng" : "Có lỗi khi thêm người dùng");
        }

        redirect(response, request.getContextPath() + "/admin/users");
    }

    /**
     * Xóa user (chỉ admin)
     */
    /**
     * Khóa / Mở khóa user (thay thế cho chức năng Xóa)
     */
    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminAccess(request, response))
            return;

        String userId = getParameter(request, "id", "");
        boolean isActive = Boolean.parseBoolean(getParameter(request, "isActive", "true"));

        if (userId.isEmpty()) {
            setErrorMessage(request, "Thiếu thông tin người dùng");
            redirect(response, request.getContextPath() + "/admin/users");
            return;
        }

        // Không cho phép khóa chính mình
        User currentUser = getCurrentUser(request);
        if (userId.equals(currentUser.getId())) {
            setErrorMessage(request, "Không thể khóa tài khoản của chính mình");
            redirect(response, request.getContextPath() + "/admin/users");
            return;
        }

        if (userDAO.toggleStatus(userId, isActive)) {
            setSuccessMessage(request, isActive ? "Đã mở khóa tài khoản thành công!" : "Đã khóa tài khoản thành công!");
        } else {
            setErrorMessage(request, "Có lỗi khi cập nhật trạng thái");
        }

        redirect(response, request.getContextPath() + "/admin/users");
    }

    /**
     * Hiển thị quản lý newsletters (chỉ admin)
     */
    private void showNewsletterManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        List<Newsletter> newsletters = newsletterDAO.findAll();
        request.setAttribute("newsletters", newsletters);

        forward(request, response, "/WEB-INF/views/admin/newsletter-management.jsp");
    }

    /**
     * Xóa newsletter (chỉ admin)
     */
    private void deleteNewsletter(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        if (!checkAdminAccess(request, response)) {
            return;
        }

        String email = getParameter(request, "email", "");
        if (email.isEmpty()) {
            setErrorMessage(request, "Thiếu thông tin email");
            redirect(response, request.getContextPath() + "/admin/newsletters");
            return;
        }

        if (newsletterDAO.delete(email)) {
            setSuccessMessage(request, "Xóa đăng ký newsletter thành công!");
        } else {
            setErrorMessage(request, "Có lỗi khi xóa đăng ký newsletter");
        }

        redirect(response, request.getContextPath() + "/admin/newsletters");
    }
}
