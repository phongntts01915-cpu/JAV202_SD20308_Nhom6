package com.example.asmnews.entity;

import java.util.Date;

/**
 * Entity class cho bảng Comments
 */
public class Comment {
    private int id;
    private String content;
    private Date createdDate;

    // [NOTE_CHO_BẠN]: Lưu ID của User và News để mapping với Database.
    // Tối ưu hơn: Có thể tạo thêm trường `private String userFullName` để hiển thị
    // tên người bình luận ra UI cho nhanh mà không cần JOIN bảng phức tạp.
    private String userId;
    private String newsId;

    private int reportCount; // Đếm số lượt bị báo cáo
    private String newsTitle; // Tên bài báo (để admin biết bình luận này nằm ở bài nào)

    // Thuộc tính phụ trợ hiển thị UI (không lưu vào DB bảng Comments)
    private String userFullName;

    public Comment() {
    }

    public Comment(int id, String content, Date createdDate, String userId, String newsId, int reportCount,
            String newsTitle) {
        this.id = id;
        this.content = content;
        this.createdDate = createdDate;
        this.userId = userId;
        this.newsId = newsId;
        this.reportCount = reportCount;
        this.newsTitle = newsTitle;
    }

    // --- Getters / Setters ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    // [SECURITY BEST PRACTICE]: Tiền xử lý chống XSS cơ bản bằng cách loại bỏ thẻ
    // script rác (nếu cần)
    public void setContent(String content) {
        this.content = content != null ? content.trim() : "";
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNewsId() {
        return newsId;
    }

    public void setNewsId(String newsId) {
        this.newsId = newsId;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    // ==========================================
    // CÁC PHƯƠNG THỨC ĐƯỢC THÊM MỚI TẠI ĐÂY
    // ==========================================

    public int getReportCount() {
        return reportCount;
    }

    public void setReportCount(int reportCount) {
        // [NOTE_DỄ_DÀNG_THAY_ĐỔI]: Đảm bảo số lượt báo cáo không bị âm.
        // Nếu nghiệp vụ cho phép reset về 1 giá trị mặc định khác, sửa số 0 ở đây.
        this.reportCount = Math.max(0, reportCount);
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        // [NOTE_DỄ_DÀNG_THAY_ĐỔI]: Xử lý null an toàn.
        // Nếu cần trả về "Unknown" khi null thay vì chuỗi rỗng, hãy thay đổi "" thành
        // "Unknown".
        this.newsTitle = newsTitle != null ? newsTitle.trim() : "";
    }
}