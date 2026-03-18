<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bình luận - XYZ Admin Premium</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-navy: #0f172a; 
            --secondary-navy: #1e293b;
            --accent-blue: #3b82f6; 
            --light-bg: #f1f5f9; 
            --text-dark: #334155;
            --text-light: #94a3b8;
            --white: #ffffff;
            --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Be Vietnam Pro', sans-serif; 
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
            border-radius: 0 0 20px 20px; 
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
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .user-profile-badge:hover {
            background: #e2e8f0;
        }

        .user-profile-badge i {
            color: var(--accent-blue);
            font-size: 1.2rem;
        }

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
            font-weight: 700;
            font-size: 1.1rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table { margin-bottom: 0; vertical-align: middle; }
        .table thead th { background: #f8fafc; color: #64748b; font-weight: 600; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px; border-bottom: 2px solid #e2e8f0; padding: 1rem; }
        .table tbody td { padding: 1rem; color: var(--text-dark); border-bottom: 1px solid #f1f5f9; font-size: 0.95rem; }
        .table tbody tr:hover { background-color: #f8fafc; }
        .table tbody tr:last-child td { border-bottom: none; }

        .badge { padding: 0.5em 0.8em; font-weight: 500; border-radius: 6px; }

        /* Custom Cảnh báo Bình luận đỏ */
        .table-danger td { background-color: #fee2e2 !important; border-bottom-color: #fca5a5 !important; }
        .table-danger:hover td { background-color: #fecaca !important; }

        .alert { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/comments">
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
                        <h4 class="mb-0">Quản lý Bình luận</h4>
                        
                        <div class="navbar-nav ms-auto dropdown">
                            <a href="#" class="user-profile-badge text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle"></i>
                                Xin chào, ${sessionScope.currentUser.fullname}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 mt-2" style="border-radius: 12px;">
                                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile">
                                    <i class="fas fa-id-badge me-2 text-success"></i> Thông tin cá nhân
                                </a></li>
                                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/change-password">
                                    <i class="fas fa-key me-2 text-warning"></i> Đổi mật khẩu
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a></li>
                            </ul>
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
                    <div class="card">
                        <div class="card-header bg-danger text-white border-bottom-0">
                            <h5 class="mb-0 text-white"><i class="fas fa-exclamation-circle text-white me-2"></i> Danh sách bình luận cần kiểm duyệt</h5>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${not empty commentsList}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th>Người đăng</th>
                                                    <th style="width: 40%">Nội dung bình luận</th>
                                                    <th>Bài báo</th>
                                                    <th class="text-center">Báo cáo</th>
                                                    <th class="text-end">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="cmt" items="${commentsList}">
                                                    <tr class="${cmt.reportCount >= 3 ? 'table-danger' : ''}">
                                                        <td>
                                                            <strong>${cmt.userFullName}</strong><br>
                                                            <small class="text-muted"><fmt:formatDate value="${cmt.createdDate}" pattern="dd/MM/yyyy HH:mm"/></small>
                                                        </td>
                                                        <td>${cmt.content}</td>
                                                        <td><span class="badge bg-primary">${cmt.newsTitle}</span></td>
                                                        <td class="text-center">
                                                            <c:if test="${cmt.reportCount > 0}">
                                                                <span class="badge bg-warning text-dark px-2 py-1 fs-6 rounded-pill"><i class="fas fa-flag text-danger"></i> ${cmt.reportCount}</span>
                                                            </c:if>
                                                            <c:if test="${cmt.reportCount == 0}">
                                                                <span class="text-muted">0</span>
                                                            </c:if>
                                                        </td>
                                                        <td class="text-end">
                                                            <form action="${pageContext.request.contextPath}/admin/comments" method="POST" style="display:inline;" onsubmit="return confirm('Xóa bình luận này vĩnh viễn?');">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${cmt.id}">
                                                                <button type="submit" class="btn btn-sm btn-danger"><i class="fas fa-trash me-1"></i> Xóa</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <div class="mb-3"><i class="fas fa-check-circle fa-4x text-success opacity-50"></i></div>
                                        <h6 class="text-muted fw-normal">Hệ thống đang sạch sẽ. Không có bình luận nào cần xử lý.</h6>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>