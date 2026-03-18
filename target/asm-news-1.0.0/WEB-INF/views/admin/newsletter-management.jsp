<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Newsletter - XYZ Admin Premium</title>

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
/* Đã loại bỏ width và position fixed cũ, dùng Bootstrap Grid và position-fixed ở HTML */
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

/* Hiệu ứng Hover */
.sidebar .nav-link:hover {
    background: rgba(255, 255, 255, 0.1);
    color: var(--white);
    transform: translateX(5px);
}

/* Hiệu ứng Active */
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
    /* Đã loại bỏ margin-left cố định */
    padding-left: 0;
    padding-top: 0; /* Loại bỏ padding-top: 120px; do Navbar đã có margin-bottom 2rem */
}

.navbar-admin {
    background: var(--white);
    padding: 1rem 2rem;
    box-shadow: var(--shadow-soft);
    margin-bottom: 2rem;
    border-radius: 0 0 20px 20px; /* Bo góc dưới */
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
   PAGE TITLE (Đã loại bỏ Title cũ)
=========================== */
/* Giữ title nhỏ hơn để khớp với header nội dung trang */
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
   CARDS (Đã đồng bộ)
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

/* ===========================
   STATS CARDS (Đã đồng bộ gradient)
=========================== */
.stat-card {
    border-radius: 20px;
    padding: 1.8rem;
    color: white;
    position: relative;
    overflow: hidden;
    border: none;
    box-shadow: var(--shadow-soft);
    transition: all 0.3s ease;
    height: 100%;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 150px;
    height: 150px;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 50%;
    pointer-events: none;
}

.stat-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-hover);
}

.stat-card h2 {
    font-weight: 700;
    font-size: 2.2rem;
    margin-bottom: 5px;
}

.stat-card h5 {
    font-size: 0.9rem;
    opacity: 0.9;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-weight: 500;
}

.stat-icon-right {
    font-size: 3rem;
    opacity: 0.3;
    position: absolute;
    right: 20px;
    bottom: 20px;
}

/* Card Colors */
.stat-card.primary { background: linear-gradient(135deg, #2563eb 0%, #3b82f6 100%); } /* Info / Royal Blue */
.stat-card.success { background: linear-gradient(135deg, #059669 0%, #10b981 100%); } /* Emerald */


/* ===========================
   TABLE (Đã đồng bộ)
=========================== */
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

/* Badges */
.badge {
    padding: 0.5em 0.8em;
    font-weight: 500;
    border-radius: 6px;
}
.badge.bg-success { background-color: #10b981 !important; color: white; }
.badge.bg-secondary { background-color: #e2e8f0 !important; color: #475569; }


/* Buttons */
.btn-group .btn-sm {
    border-radius: 6px !important;
    font-weight: 500;
    padding: 6px 10px;
}

.btn-outline-warning {
    color: #f59e0b;
    border-color: #f59e0b;
}

.btn-outline-warning:hover {
    background: #f59e0b;
    color: white;
}

.btn-outline-success {
    color: #10b981;
    border-color: #10b981;
}

.btn-outline-success:hover {
    background: #10b981;
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
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
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
                                        <a class="nav-link active"
                                            href="${pageContext.request.contextPath}/admin/newsletters">
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
                                    <h4 class="mb-0">Quản lý Newsletter</h4>
                                    <div class="navbar-nav ms-auto">
                                        <span class="navbar-text">
                                            <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.currentUser.fullname}
                                        </span>
                                    </div>
                                </div>
                            </nav>

                            <div class="container-fluid px-4">
                                <h2 class="page-title">Quản lý Newsletter</h2>

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

                                <div class="row g-4 pb-4">
                                    <div class="col-md-6">
                                        <div class="stat-card primary">
                                            <div class="d-flex flex-column position-relative z-1">
                                                <h2 class="mb-0">${totalNewsletters}</h2>
                                                <h5 class="mb-0">Tổng số đăng ký</h5>
                                            </div>
                                            <i class="fas fa-envelope stat-icon-right"></i>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="stat-card success">
                                            <div class="d-flex flex-column position-relative z-1">
                                                <h2 class="mb-0">${activeNewsletters}</h2>
                                                <h5 class="mb-0">Đang hoạt động</h5>
                                            </div>
                                            <i class="fas fa-check-circle stat-icon-right"></i>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-list"></i> Danh sách đăng ký Newsletter
                                                </h5>
                                            </div>
                                            <div class="card-body p-0">
                                                <c:choose>
                                                    <c:when test="${not empty newsletters}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover align-middle">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Email</th>
                                                                        <th>Trạng thái</th>
                                                                        <th class="text-end">Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="newsletter" items="${newsletters}">
                                                                        <tr>
                                                                            <td>
                                                                                <i class="fas fa-envelope-open-text me-2 text-muted"></i>
                                                                                ${newsletter.email}
                                                                            </td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${newsletter.enabled}">
                                                                                        <span class="badge bg-success">
                                                                                            <i class="fas fa-check"></i>
                                                                                            Hoạt động
                                                                                        </span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge bg-secondary">
                                                                                            <i class="fas fa-times"></i>
                                                                                            Đã hủy
                                                                                        </span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="text-end">
                                                                                <div class="btn-group" role="group">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${newsletter.enabled}">
                                                                                            <button type="button"
                                                                                                class="btn btn-sm btn-outline-warning"
                                                                                                onclick="toggleNewsletter('${newsletter.email}', false)"
                                                                                                title="Vô hiệu hóa">
                                                                                                <i
                                                                                                    class="fas fa-pause"></i>
                                                                                            </button>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <button type="button"
                                                                                                class="btn btn-sm btn-outline-success"
                                                                                                onclick="toggleNewsletter('${newsletter.email}', true)"
                                                                                                title="Kích hoạt">
                                                                                                <i
                                                                                                    class="fas fa-play"></i>
                                                                                            </button>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-outline-danger"
                                                                                        onclick="deleteNewsletter('${newsletter.email}')"
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
                                                            <i class="fas fa-envelope fa-4x text-light mb-3"></i>
                                                            <h6 class="text-muted fw-normal">Chưa có đăng ký Newsletter nào</h6>
                                                            <p class="text-muted">Người dùng có thể đăng ký Newsletter từ trang chủ</p>
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
                                <p class="lead">Bạn có chắc chắn muốn xóa email **"<span id="deleteEmail" class="fw-bold"></span>"** khỏi danh sách Newsletter?</p>
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
                    function toggleNewsletter(email, enabled) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/admin/newsletters/toggle';

                        const emailInput = document.createElement('input');
                        emailInput.type = 'hidden';
                        emailInput.name = 'email';
                        emailInput.value = email;

                        const enabledInput = document.createElement('input');
                        enabledInput.type = 'hidden';
                        enabledInput.name = 'enabled';
                        enabledInput.value = enabled;

                        form.appendChild(emailInput);
                        form.appendChild(enabledInput);
                        document.body.appendChild(form);
                        form.submit();
                    }

                    function deleteNewsletter(email) {
                        document.getElementById('deleteEmail').textContent = email;
                        document.getElementById('confirmDelete').onclick = function () {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/newsletters/delete';

                            const emailInput = document.createElement('input');
                            emailInput.type = 'hidden';
                            emailInput.name = 'email';
                            emailInput.value = email;

                            form.appendChild(emailInput);
                            document.body.appendChild(form);
                            form.submit();
                        };

                        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
                        modal.show();
                    }
                </script>
            </body>

            </html>