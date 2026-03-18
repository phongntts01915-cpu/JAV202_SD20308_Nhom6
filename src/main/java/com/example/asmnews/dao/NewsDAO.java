package com.example.asmnews.dao;

import com.example.asmnews.entity.News;
import com.example.asmnews.utils.DatabaseUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class cho News
 * Thực hiện các thao tác CRUD với bảng News
 */
public class NewsDAO {

    /**
     * Lấy tất cả tin tức với thông tin category và author
     * 
     * @return List<News>
     */
    public List<News> findAll() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "ORDER BY n.PostedDate DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách tin tức: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Lấy tin tức hiển thị trên trang chủ
     * 
     * @return List<News>
     */
    public List<News> findHomeNews() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "WHERE n.Home = 1 " +
                "ORDER BY n.PostedDate DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tin tức trang chủ: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Lấy top 5 tin tức được xem nhiều nhất
     * 
     * @return List<News>
     */
    public List<News> findTop5MostViewed() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP 5 n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "ORDER BY n.ViewCount DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy top 5 tin được xem nhiều: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Lấy 5 tin tức mới nhất
     * 
     * @return List<News>
     */
    public List<News> findTop5Latest() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT TOP 5 n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "ORDER BY n.PostedDate DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy 5 tin mới nhất: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Tìm tin tức theo category
     * 
     * @param categoryId ID của category
     * @return List<News>
     */
    public List<News> findByCategory(String categoryId) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "WHERE n.CategoryId = ? " +
                "ORDER BY n.PostedDate DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm tin theo category: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Tìm tin tức theo author
     * 
     * @param authorId ID của author
     * @return List<News>
     */
    public List<News> findByAuthor(String authorId) {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "WHERE n.Author = ? " +
                "ORDER BY n.PostedDate DESC";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, authorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                News news = mapResultSetToNews(rs);
                newsList.add(news);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm tin theo author: " + e.getMessage());
        }

        return newsList;
    }

    /**
     * Tìm tin tức theo ID
     * 
     * @param id ID của tin tức
     * @return News hoặc null nếu không tìm thấy
     */
    public News findById(String id) {
        String sql = "SELECT n.Id, n.Title, n.Content, n.Image, n.PostedDate, n.Author, " +
                "n.ViewCount, n.CategoryId, n.Home, c.Name as CategoryName, u.Fullname as AuthorName " +
                "FROM News n " +
                "LEFT JOIN Categories c ON n.CategoryId = c.Id " +
                "LEFT JOIN Users u ON n.Author = u.Id " +
                "WHERE n.Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToNews(rs);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm tin theo ID: " + e.getMessage());
        }

        return null;
    }

    /**
     * Thêm tin tức mới
     * 
     * @param news News cần thêm
     * @return true nếu thành công
     */
    public boolean insert(News news) {
        String sql = "INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, news.getId());
            ps.setString(2, news.getTitle());
            ps.setString(3, news.getContent());
            ps.setString(4, news.getImage());
            ps.setDate(5, new java.sql.Date(news.getPostedDate().getTime()));
            ps.setString(6, news.getAuthor());
            ps.setInt(7, news.getViewCount());
            ps.setString(8, news.getCategoryId());
            ps.setBoolean(9, news.getHome());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm tin tức: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cập nhật tin tức
     * 
     * @param news News cần cập nhật
     * @return true nếu thành công
     */
    public boolean update(News news) {
        String sql = "UPDATE News SET Title = ?, Content = ?, Image = ?, PostedDate = ?, " +
                "Author = ?, ViewCount = ?, CategoryId = ?, Home = ? WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getImage());
            ps.setDate(4, new java.sql.Date(news.getPostedDate().getTime()));
            ps.setString(5, news.getAuthor());
            ps.setInt(6, news.getViewCount());
            ps.setString(7, news.getCategoryId());
            ps.setBoolean(8, news.getHome());
            ps.setString(9, news.getId());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật tin tức: " + e.getMessage());
            return false;
        }
    }

    /**
     * Cập nhật lượt xem
     * 
     * @param id ID của tin tức
     * @return true nếu thành công
     */
    public boolean updateViewCount(String id) {
        String sql = "UPDATE News SET ViewCount = ViewCount + 1 WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật lượt xem: " + e.getMessage());
            return false;
        }
    }

    /**
     * Xóa tin tức
     * 
     * @param id ID của tin tức cần xóa
     * @return true nếu thành công
     */
    public boolean delete(String id) {
        String sql = "DELETE FROM News WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            int result = ps.executeUpdate();
            return result > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa tin tức: " + e.getMessage());
            return false;
        }
    }

    /**
     * Kiểm tra tin tức có tồn tại không
     * 
     * @param id ID cần kiểm tra
     * @return true nếu tồn tại
     */
    public boolean exists(String id) {
        String sql = "SELECT COUNT(*) FROM News WHERE Id = ?";

        try (Connection conn = DatabaseUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra tin tức tồn tại: " + e.getMessage());
        }

        return false;
    }

    /**
     * Map ResultSet thành News object
     * 
     * @param rs ResultSet
     * @return News
     * @throws SQLException
     */
    private News mapResultSetToNews(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getString("Id"));
        news.setTitle(rs.getString("Title"));
        news.setContent(rs.getString("Content"));
        news.setImage(rs.getString("Image"));
        news.setPostedDate(rs.getDate("PostedDate"));
        news.setAuthor(rs.getString("Author"));
        news.setViewCount(rs.getInt("ViewCount"));
        news.setCategoryId(rs.getString("CategoryId"));
        news.setHome(rs.getBoolean("Home"));

        // Thông tin join
        news.setCategoryName(rs.getString("CategoryName"));
        news.setAuthorName(rs.getString("AuthorName"));

        return news;
    }
}
