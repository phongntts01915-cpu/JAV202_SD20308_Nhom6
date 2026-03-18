<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý tin tức - XYZ Admin Premium</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
                
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
/* ===========================
   CUSTOM VARIABLES (Đồng bộ với Dashboard)
=========================== */
:root {
    --primary-navy: #0f172a; /* Navy đậm sang trọng cho Sidebar/Header chính */
    --secondary-navy: #1e293b; /* Navy nhạt hơn cho Card Header */
    --accent-blue: #3b82f6; /* Xanh điểm nhấn */
    --light-bg: #f1f5f9; /* Nền xám xanh nhẹ */
    --text-dark: #334155;
    --text-light: #94a3b8;
    --white: #ffffff;
    --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

/* ===========================
   RESET & TYPOGRAPHY
=========================== */
* {
    font-family: 'Be Vietnam Pro', sans-serif;
    transition: all 0.3s ease;
}

body {
    background-color: var(--light-bg);
    color: var(--text-dark);
    overflow-x: hidden;
}

/* ===========================
   SIDEBAR (Đồng bộ hoàn toàn)
=========================== */
/* Sử dụng cấu trúc Grid và position-fixed ở HTML */
.sidebar {
    height: 100vh;
    background: var(--primary-navy); 
    box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1); 
    z-index: 1000;
}

.sidebar h5 {
    font-weight: 700;
    letter-spacing: 0.5px;
    color: var(--white);
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 20px;
    text-align: center;
}

.sidebar .nav-link {
    color: #cbd5e1;
    padding: 14px 20px;
    margin-bottom: 8px;
    border-radius: 12px;
    font-size: 0.95rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.sidebar .nav-link i {
    width: 24px;
    text-align: center;
    font-size: 1.1rem;
}

.sidebar .nav-link:hover {
    background: rgba(255, 255, 255, 0.1);
    color: var(--white);
    transform: translateX(5px);
}

.sidebar .nav-link.active {
    background: linear-gradient(90deg, var(--accent-blue), #2563eb);
    color: var(--white) !important;
    font-weight: 600;
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
    transform: none;
}

.sidebar hr {
    background-color: rgba(255, 255, 255, 0.2);
    opacity: 1;
}

/* ===========================
   MAIN CONTENT & NAVBAR
=========================== */
.main-content {
    background-color: var(--light-bg);
    padding-left: 0;
    padding-top: 0;
}

.navbar-admin {
    /* Sử dụng lại style của Newsletter/Categories/Add-Edit-News */
    background: var(--white);
    padding: 1rem 2rem;
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    border-radius: 0 0 20px 20px; 
    border-bottom: none;
    z-index: 900;
    display: flex;
    align-items: center;
}

.navbar-admin h4 {
    color: var(--primary-navy);
    font-weight: 700;
    font-size: 1.5rem;
}

.navbar-text {
    background: var(--light-bg);
    padding: 8px 16px;
    border-radius: 50px;
    display: flex;
    align-items: center;
    gap: 10px;
    color: var(--primary-navy);
    font-weight: 600;
    border: 1px solid #e2e8f0;
}
.navbar-text i {
    color: var(--accent-blue);
    font-size: 1.2rem;
}

/* ===========================
   PAGE TITLE
=========================== */
.page-title {
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 12px;
    position: relative;
    padding-bottom: 12px;
    color: var(--primary-navy);
}

.page-title::after {
    content: "";
    position: absolute;
    bottom: 0;
    left: 0;
    width: 160px;
    height: 3px;
    background: var(--accent-blue);
    border-radius: 2px;
}

/* ===========================
   CARDS & TABLE (Đồng bộ)
=========================== */
.card {
    border: none;
    border-radius: 20px;
    background: var(--white);
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    overflow: hidden;
}

.card-header {
    background: var(--secondary-navy);
    color: var(--white);
    font-weight: 700;
    font-size: 1.1rem;
    padding: 1.2rem 1.5rem;
    border-bottom: none;
    border-radius: 20px 20px 0 0 !important;
    display: flex;
    align-items: center;
    gap: 10px;
}
.card-header i {
    color: var(--white);
}

.table {
    margin-bottom: 0;
    vertical-align: middle;
}

.table thead th {
    background: #f8fafc;
    color: #64748b;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.75rem;
    letter-spacing: 0.5px;
    border-bottom: 2px solid #e2e8f0;
    padding: 1rem;
}

.table tbody td {
    padding: 1rem;
    color: var(--text-dark);
    border-bottom: 1px solid #f1f5f9;
    font-size: 0.95rem;
}

.table tbody tr:hover {
    background-color: #f8fafc;
}

.table tbody tr:last-child td {
    border-bottom: none;
}

/* Image Preview */
.news-image-preview {
    width: 80px;
    height: 60px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    border: 1px solid #e2e8f0;
}
.bg-light { /* Placeholder no image */
    width: 80px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px dashed #cfd7e3;
    background: #f8fafc !important;
}
.bg-light i {
    font-size: 1.2rem;
}


/* Badges */
.badge {
    padding: 0.5em 0.8em;
    font-weight: 600;
    border-radius: 6px;
}

/* Đã chỉnh màu Badge */
.badge.bg-secondary { background-color: #64748b !important; } /* Chuyên mục */
.badge.bg-warning { background-color: #f59e0b !important; color: var(--white); } /* Trang chủ */
.badge.bg-info { background-color: #3b82f6 !important; color: var(--white); } /* Thường */


/* Buttons */
.btn {
    border-radius: 10px !important;
    font-weight: 600;
    padding: 10px 18px;
    transition: all 0.3s ease;
}

.btn-primary {
    background-color: var(--accent-blue) !important;
    border-color: var(--accent-blue) !important;
}

.btn-primary:hover {
    background-color: #2563eb !important;
    border-color: #2563eb !important;
    box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
}

.btn-group .btn-sm {
    border-radius: 6px !important;
    font-weight: 500;
    padding: 6px 10px;
}

.btn-outline-info {
    color: #3b82f6;
    border-color: #3b82f6;
}
.btn-outline-info:hover {
    background: #3b82f6;
    color: white;
}

.btn-outline-primary {
    color: #1e293b;
    border-color: #1e293b;
}
.btn-outline-primary:hover {
    background: #1e293b;
    color: white;
}

.btn-outline-danger {
    color: #ef4444;
    border-color: #ef4444;
}
.btn-outline-danger:hover {
    background: #ef4444;
    color: white;
}

/* Modal */
.modal-header {
    background: var(--primary-navy); 
    color: var(--white);
    font-weight: 600;
    border-radius: 20px 20px 0 0 !important;
}
.modal-content {
    border-radius: 20px !important;
}
.modal-footer {
    border-radius: 0 0 20px 20px !important;
    background: #f8fafc;
}

/* Alerts */
.alert {
    border-radius: 12px;
    border: none;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    font-weight: 500;
}
.alert-success { background: #10b981; color: var(--white); }
.alert-danger { background: #d32f2f; color: var(--white); }
.alert .btn-close { filter: invert(1); opacity: 0.8; }

                </style>
            </head>

            <body>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-3 col-lg-2 px-0 sidebar position-fixed">
                            <div class="p-3">
                                <h5 class="text-white text-center mt-2">
                                    <i class="fas fa-layer-group me-2"></i> XYZ ADMIN
                                </h5>

                                <nav class="nav flex-column mt-4">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                        <i class="fas fa-chart-pie"></i> Dashboard
                                    </a>
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/news">
                                        <i class="fas fa-file-alt"></i> Quản lý tin tức
                                    </a>
                                    <c:if test="${sessionScope.currentUser.admin}">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                            <i class="fas fa-folder-open"></i> Quản lý chuyên mục
                                        </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                            <i class="fas fa-users-cog"></i> Quản lý người dùng
                                        </a>
                                                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments"></i> Quản lý bình luận
                            </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                            <i class="fas fa-envelope-open-text"></i> Newsletter
                                        </a>
                                    </c:if>
                                    <hr class="text-white-50">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                                        <i class="fas fa-external-link-alt"></i> Xem trang chủ
                                    </a>
                                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                    </a>
                                </nav>
                            </div>
                        </div>

                        <div class="col-md-9 col-lg-10 ms-auto main-content">
                            <nav class="navbar navbar-expand-lg navbar-admin sticky-top">
                                <div class="container-fluid">
                                    <h4 class="mb-0">Quản lý tin tức</h4>
                                    <div class="navbar-nav ms-auto">
                                        <span class="navbar-text">
                                            <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.currentUser.fullname}
                                        </span>
                                    </div>
                                </div>
                            </nav>

                            <div class="container-fluid px-4">
                                <h2 class="page-title">Danh sách tin tức</h2>

                                <c:if test="${sessionScope.successMessage != null}">
                                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                                        <i class="fas fa-check-circle me-2 fs-5"></i> ${sessionScope.successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                    <c:remove var="successMessage" scope="session" />
                                </c:if>

                                <c:if test="${sessionScope.errorMessage != null}">
                                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                                        <i class="fas fa-exclamation-circle me-2 fs-5"></i> ${sessionScope.errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                    <c:remove var="errorMessage" scope="session" />
                                </c:if>

                                <div class="row mb-4">
                                    <div class="col-12">
                                        <a href="${pageContext.request.contextPath}/admin/news/add"
                                            class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Thêm tin tức mới
                                        </a>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-list"></i> Danh sách tin tức
                                                </h5>
                                            </div>
                                            <div class="card-body p-0">
                                                <c:choose>
                                                    <c:when test="${not empty newsList}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover align-middle">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Hình ảnh</th>
                                                                        <th>Tiêu đề</th>
                                                                        <th>Tác giả</th>
                                                                        <th>Chuyên mục</th>
                                                                        <th>Ngày đăng</th>
                                                                        <th>Lượt xem</th>
                                                                        <th>Trạng thái</th>
                                                                        <th class="text-end">Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="news" items="${newsList}">
                                                                        <tr>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not empty news.image}">
                                                                                        <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                                                            class="news-image-preview"
                                                                                            alt="${news.title}">
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div class="bg-light p-2 rounded text-center">
                                                                                            <i
                                                                                                class="fas fa-image text-muted"></i>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <strong>${news.title}</strong>
                                                                                <br>
                                                                                <small
                                                                                    class="text-muted">${news.getShortContent(50)}...</small>
                                                                            </td>
                                                                            <td>${news.authorName}</td>
                                                                            <td>
                                                                                <span
                                                                                    class="badge bg-secondary">${news.categoryName}</span>
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${news.postedDate}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <i class="fas fa-eye me-1 text-muted"></i>
                                                                                ${news.viewCount}
                                                                            </td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${news.home}">
                                                                                        <span
                                                                                            class="badge bg-warning">
                                                                                            <i class="fas fa-star me-1"></i> Trang chủ
                                                                                        </span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge bg-info">
                                                                                            <i class="fas fa-file-alt me-1"></i> Thường
                                                                                        </span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="text-end">
                                                                                <div class="btn-group" role="group">
                                                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                                                        class="btn btn-sm btn-outline-info"
                                                                                        target="_blank" title="Xem">
                                                                                        <i class="fas fa-eye"></i>
                                                                                    </a>
                                                                                    <a href="${pageContext.request.contextPath}/admin/news/edit?id=${news.id}"
                                                                                        class="btn btn-sm btn-outline-primary"
                                                                                        title="Sửa">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-outline-danger"
                                                                                        onclick="deleteNews('${news.id}', '${news.title}')"
                                                                                        title="Xóa">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-5">
                                                            <i class="fas fa-newspaper fa-4x text-light mb-3"></i>
                                                            <h6 class="text-muted fw-normal">Chưa có tin tức nào</h6>
                                                            <p class="text-muted">Hãy thêm tin tức đầu tiên của bạn</p>
                                                            <a href="${pageContext.request.contextPath}/admin/news/add"
                                                                class="btn btn-primary mt-3">
                                                                <i class="fas fa-plus"></i> Thêm tin tức đầu tiên
                                                            </a>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i> Xác nhận xóa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p class="lead">Bạn có chắc chắn muốn xóa tin tức **"<span id="newsTitle" class="fw-bold"></span>**"?</p>
                                <p class="text-danger fw-bold"><i class="fas fa-exclamation-circle me-1"></i> Hành động này không thể hoàn tác!</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    function deleteNews(newsId, newsTitle) {
                        document.getElementById('newsTitle').textContent = newsTitle;
                        document.getElementById('confirmDelete').onclick = function () {
                            // Tạo form để submit DELETE request
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/news/delete';

                            const idInput = document.createElement('input');
                            idInput.type = 'hidden';
                            idInput.name = 'id';
                            idInput.value = newsId;

                            form.appendChild(idInput);
                            document.body.appendChild(form);
                            form.submit();
                        };

                        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
                        modal.show();
                    }
                </script>
            </body>

            </html>