<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - XYZ Admin Premium</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-navy: #0f172a; /* Navy đậm sang trọng */
            --secondary-navy: #1e293b;
            --accent-blue: #3b82f6; /* Xanh điểm nhấn */
            --light-bg: #f1f5f9; /* Nền xám xanh nhẹ */
            --text-dark: #334155;
            --text-light: #94a3b8;
            --white: #ffffff;
            --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

       /* Trong phần <style> */
body {
    /* Đổi tên font ở đây */
    font-family: 'Be Vietnam Pro', sans-serif; 
    
    /* Các thuộc tính khác giữ nguyên */
    background-color: var(--light-bg);
    color: var(--text-dark);
    overflow-x: hidden;
}

        /* ======== SIDEBAR ======== */
        .sidebar {
            background: var(--primary-navy);
            min-height: 100vh;
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
            transition: all 0.3s ease;
        }

        .sidebar .nav-link i {
            width: 24px;
            text-align: center;
            font-size: 1.1rem;
            transition: transform 0.3s;
        }

        .sidebar .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--white);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background: linear-gradient(90deg, var(--accent-blue), #2563eb);
            color: var(--white);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .sidebar hr {
            background-color: rgba(255, 255, 255, 0.2);
            opacity: 1;
        }

        /* ======== MAIN CONTENT & NAVBAR ======== */
        .main-content {
            padding-left: 0;
        }

        .navbar-admin {
            background: var(--white);
            padding: 1rem 2rem;
            box-shadow: var(--shadow-soft);
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px; /* Bo góc dưới */
        }

        .navbar-admin h4 {
            color: var(--primary-navy);
            font-weight: 700;
            font-size: 1.5rem;
        }

        .user-profile-badge {
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

        .user-profile-badge i {
            color: var(--accent-blue);
            font-size: 1.2rem;
        }

        /* ======== STAT CARDS (Premium Gradients) ======== */
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

        .stat-card h3 {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 5px;
        }

        .stat-card p {
            font-size: 0.9rem;
            opacity: 0.9;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 500;
        }

        .stat-icon {
            font-size: 3rem;
            opacity: 0.3;
            position: absolute;
            right: 20px;
            bottom: 20px;
        }

        /* Card Colors */
        .stat-card.primary { background: linear-gradient(135deg, #1e293b 0%, #334155 100%); } /* Navy */
        .stat-card.success { background: linear-gradient(135deg, #059669 0%, #10b981 100%); } /* Emerald */
        .stat-card.warning { background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%); } /* Amber */
        .stat-card.info { background: linear-gradient(135deg, #2563eb 0%, #3b82f6 100%); } /* Royal Blue */


        /* ======== TABLES & CARDS ======== */
        .card {
            border: none;
            border-radius: 20px;
            background: var(--white);
            box-shadow: var(--shadow-soft);
            margin-bottom: 2rem;
        }

        .card-header {
            background: var(--white);
            border-bottom: 1px solid #e2e8f0;
            padding: 1.5rem;
            border-radius: 20px 20px 0 0 !important;
        }

        .card-header h5 {
            color: var(--primary-navy);
            font-weight: 700;
            font-size: 1.1rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-header h5 i {
            color: var(--accent-blue);
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

        /* Badges & Buttons */
        .badge {
            padding: 0.5em 0.8em;
            font-weight: 500;
            border-radius: 6px;
        }
        .badge.bg-secondary { background-color: #e2e8f0 !important; color: #475569; }
        .badge.bg-warning { background-color: #fef3c7 !important; color: #b45309; }

        .btn-outline-primary {
            border-color: #cbd5e1;
            color: #64748b;
        }
        .btn-outline-primary:hover {
            background: var(--accent-blue);
            border-color: var(--accent-blue);
            color: white;
        }

        /* Alerts */
        .alert {
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3 col-lg-2 px-0 sidebar position-fixed">
                <div class="p-3">
                    <h5 class="text-white text-center mt-2">
                        <i class="fas fa-layer-group me-2"></i>XYZ ADMIN
                    </h5>

                    <nav class="nav flex-column mt-4">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
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

                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                <i class="fas fa-envelope-open-text"></i> Newsletter
                            </a>
                        </c:if>
                        <hr>
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
                        <h4 class="mb-0">Tổng quan hệ thống</h4>
                        <div class="navbar-nav ms-auto">
                            <span class="user-profile-badge">
                                <i class="fas fa-user-circle"></i>
                                Xin chào, ${sessionScope.currentUser.fullname}
                            </span>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4">
                    <c:if test="${sessionScope.successMessage != null}">
                        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="fas fa-check-circle me-2 fs-5"></i>
                            <div>${sessionScope.successMessage}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session" />
                    </c:if>

                    <c:if test="${sessionScope.errorMessage != null}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="fas fa-exclamation-triangle me-2 fs-5"></i>
                            <div>${sessionScope.errorMessage}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>
                </div>

                <div class="container-fluid px-4 pb-4">
                    <div class="row g-4 mb-4">
                        <div class="col-md-6 col-xl-3">
                            <div class="stat-card primary">
                                <div class="d-flex flex-column position-relative z-1">
                                    <h3 class="mb-0">${totalNews}</h3>
                                    <p class="mb-0">Tin tức</p>
                                </div>
                                <i class="fas fa-newspaper stat-icon"></i>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="stat-card success">
                                <div class="d-flex flex-column position-relative z-1">
                                    <h3 class="mb-0">${totalCategories}</h3>
                                    <p class="mb-0">Chuyên mục</p>
                                </div>
                                <i class="fas fa-tags stat-icon"></i>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="stat-card warning">
                                <div class="d-flex flex-column position-relative z-1">
                                    <h3 class="mb-0">${totalUsers}</h3>
                                    <p class="mb-0">Người dùng</p>
                                </div>
                                <i class="fas fa-users stat-icon"></i>
                            </div>
                        </div>

                        <div class="col-md-6 col-xl-3">
                            <div class="stat-card info">
                                <div class="d-flex flex-column position-relative z-1">
                                    <h3 class="mb-0">${totalNewsletters}</h3>
                                    <p class="mb-0">Đăng ký tin</p>
                                </div>
                                <i class="fas fa-envelope stat-icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-clock"></i> Tin tức mới nhất
                                    </h5>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${not empty latestNews}">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle">
                                                    <thead>
                                                        <tr>
                                                            <th width="40%">Tiêu đề</th>
                                                            <th>Tác giả</th>
                                                            <th>Chuyên mục</th>
                                                            <th>Ngày đăng</th>
                                                            <th>Lượt xem</th>
                                                            <th class="text-end">Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="news" items="${latestNews}">
                                                            <tr>
                                                                <td>
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="ms-2">
                                                                            <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                                                class="text-decoration-none fw-bold text-dark"
                                                                                target="_blank">
                                                                                ${news.title}
                                                                            </a>
                                                                            <c:if test="${news.home}">
                                                                                <span class="badge bg-warning ms-2" style="font-size: 0.7em;">
                                                                                    <i class="fas fa-star me-1"></i>Hot
                                                                                </span>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="text-muted"><i class="far fa-user me-1"></i>${news.authorName}</span>
                                                                </td>
                                                                <td>
                                                                    <span class="badge bg-secondary">${news.categoryName}</span>
                                                                </td>
                                                                <td>
                                                                    <span class="text-muted" style="font-size: 0.9em;">
                                                                        <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy" />
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <span class="fw-bold text-primary">
                                                                        ${news.viewCount}
                                                                    </span>
                                                                </td>
                                                                <td class="text-end">
                                                                    <a href="${pageContext.request.contextPath}/admin/news/edit?id=${news.id}"
                                                                        class="btn btn-sm btn-outline-primary"
                                                                        title="Chỉnh sửa">
                                                                        <i class="fas fa-pen"></i>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-5">
                                                <div class="mb-3">
                                                    <i class="fas fa-newspaper fa-4x text-light"></i>
                                                </div>
                                                <h6 class="text-muted fw-normal">Chưa có dữ liệu tin tức nào</h6>
                                                <a href="${pageContext.request.contextPath}/admin/news/add"
                                                    class="btn btn-primary mt-3 px-4 rounded-pill">
                                                    <i class="fas fa-plus me-2"></i> Thêm mới
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>