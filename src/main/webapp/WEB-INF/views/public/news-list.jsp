<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - XYZ News</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* ================================================= */
        /* BIẾN MÀU VÀ FONT ĐỒNG BỘ */
        /* ================================================= */
        :root {
            --navy: #091C35; /* Navy Dark - Màu chủ đạo cho Menu/Footer */
            --navy-light: #1D3557; /* Navy Tối nhẹ */
            --navy-hover: #2c5282; /* Màu hover chữ/link */
            --accent: #00A896; /* Xanh ngọc lục bảo (Teal) - Màu nhấn chính */
            --background-content: #EBEBEB; /* Nền xám sáng trung tính */
            --text-color: #2d3748; /* Màu chữ chính */
            --shadow-navbar: 0 6px 30px rgba(9, 28, 53, 0.4); /* Bóng đổ mạnh cho Navbar */
            --shadow-subtle: 0 4px 15px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ */
            --shadow-lift: 0 15px 35px rgba(0, 0, 0, 0.12); /* Bóng đổ khi hover */
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background-content); /* Dùng màu nền đồng bộ */
            color: var(--text-color);
        }

        h1, h2, h3, h4, h5, h6, .navbar-brand {
            font-family: 'Inter', sans-serif; 
            font-weight: 700; 
            color: var(--navy); /* Đảm bảo tiêu đề chính có màu Navy */
        }

        /* ================================================= */
        /* NAVBAR (ĐỒNG BỘ INDEX & DETAIL) */
        /* ================================================= */
        .navbar {
            background: linear-gradient(135deg, var(--navy), var(--navy-light)) !important;
            box-shadow: var(--shadow-navbar);
            position: sticky;
            top: 0;
            z-index: 1030;
            padding: 0.9rem 0;
        }

        .navbar-brand {
            color: white !important;
            letter-spacing: 1px;
            font-size: 1.5rem;
        }

        .navbar .nav-link {
            color: white !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        /* Màu hover/active là ACCENT (Teal) */
        .navbar .nav-link:hover,
        .navbar .nav-link.active {
            color: var(--accent) !important;
            border-bottom: 2px solid var(--accent);
            padding-bottom: 0.6rem;
            transform: none;
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border-radius: 12px;
        }

        /* ================================================= */
        /* CARD TIN TỨC (ĐỒNG BỘ INDEX) */
        /* ================================================= */
        .news-card {
            border: none;
            border-radius: 18px; 
            overflow: hidden;
            box-shadow: var(--shadow-subtle); 
            transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94); 
            background: white;
            height: 100%;
        }

        .news-card:hover {
            transform: translateY(-8px); 
            box-shadow: var(--shadow-lift); 
        }

        .news-card img {
            height: 240px; /* Chiều cao ảnh card đồng bộ */
            object-fit: cover;
            border-top-left-radius: 18px;
            border-top-right-radius: 18px;
            transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        }

        .news-card:hover img {
            transform: scale(1.08);
        }

        .news-meta {
            color: #6c757d; /* Màu xám tinh tế hơn */
            font-size: 0.9em;
            font-weight: 500;
        }
        
        /* Tiêu đề trang */
        .page-title-icon {
            color: var(--accent); /* Icon tiêu đề dùng màu ACCENT */
            margin-right: 15px;
        }
        
        /* ================================================= */
        /* FOOTER (ĐỒNG BỘ INDEX & DETAIL) */
        /* ================================================= */
        .footer {
            background: linear-gradient(135deg, var(--navy), var(--navy-light));
            color: #e3e8ee;
            padding: 70px 0 40px;
            margin-top: 80px;
        }
        
        .footer h5 {
            color: white; 
            font-weight: 700;
        }
        
        .footer input.form-control {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }
        
        .btn-primary {
            background-color: var(--accent) !important;
            border-color: var(--accent) !important;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--navy) !important;
            border-color: var(--navy) !important;
        }
        
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-lg">
        <div class="container">
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/">
                <i class="fas fa-newspaper me-2"></i> XYZ News
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/news">Tin tức</a>
                    </li>
                    <c:forEach var="category" items="${categories}">
                        <li class="nav-item">
                            <a class="nav-link"
                                href="${pageContext.request.contextPath}/news?action=category&id=${category.id}">
                                ${category.name}
                            </a>
                        </li>
                    </c:forEach>
                </ul>

                <form class="d-flex mx-lg-4 my-2 my-lg-0" action="${pageContext.request.contextPath}/news" method="GET" style="min-width: 250px;">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group shadow-sm">
                        <input class="form-control border-0" type="search" name="keyword" placeholder="Tìm kiếm bài viết..." required style="border-radius: 20px 0 0 20px; padding-left: 18px; font-size: 0.95rem;">
                        <button class="btn bg-white border-0" type="submit" style="border-radius: 0 20px 20px 0; color: var(--accent);">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.currentUser != null}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                    role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle"></i> ${sessionScope.currentUser.fullname}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0" style="border-radius: 12px;"> 
    <c:if test="${sessionScope.currentUser.admin || sessionScope.currentUser.reporter}">
        <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin">
            <i class="fas fa-tachometer-alt me-2 text-primary"></i> Quản trị hệ thống
        </a></li>
        <li><hr class="dropdown-divider"></li>
    </c:if>

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
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <div class="row mb-5">
            <div class="col-12">
                <h1 class="mb-3">
                    <c:if test="${not empty category}">
                        <i class="fas fa-tag page-title-icon"></i> ${pageTitle}
                    </c:if>
                    <c:if test="${empty category}">
                        <i class="fas fa-newspaper page-title-icon"></i> ${pageTitle}
                    </c:if>
                </h1>
            </div>
        </div>

        <div class="row">
            <c:choose>
                <c:when test="${not empty newsList}">
                    <c:forEach var="news" items="${newsList}">
                        <div class="col-lg-6 mb-4">
                            <div class="card news-card h-100">
                                <div class="overflow-hidden">
                                    <c:if test="${not empty news.image}">
                                        <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                            class="card-img-top news-image" alt="${news.title}">
                                    </c:if>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                            class="text-decoration-none text-dark">
                                            ${news.title}
                                        </a>
                                    </h5>
                                    <p class="card-text flex-grow-1 text-muted">${news.getShortContent(150)}</p>
                                    <div class="news-meta mt-auto">
                                        <small>
                                            <i class="fas fa-user me-1"></i> ${news.authorName} 
                                            <span class="mx-2">|</span>
                                            <i class="fas fa-calendar me-1"></i>
                                            <fmt:formatDate value="${news.postedDate}"
                                                pattern="dd/MM/yyyy" /> 
                                            <span class="mx-2">|</span>
                                            <i class="fas fa-eye me-1"></i> ${news.viewCount} lượt xem 
                                            <span class="mx-2">|</span>
                                            <i class="fas fa-tag me-1"></i> ${news.categoryName}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">Chưa có tin tức nào</h5>
                            <p class="text-muted">
                                <c:if test="${not empty category}">
                                    Chưa có tin tức nào trong chuyên mục ${category.name}
                                </c:if>
                                <c:if test="${empty category}">
                                    Chưa có tin tức nào được đăng
                                </c:if>
                            </p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-newspaper me-2"></i> XYZ News</h5>
                    <p>Website tin tức 24h cập nhật nhanh nhất</p>
                </div>
                <div class="col-md-6">
                    <h5>Đăng ký nhận tin</h5>
                    <form action="${pageContext.request.contextPath}/newsletter" method="post"
                        class="d-flex">
                        <input type="hidden" name="action" value="subscribe">
                        <input type="email" name="email" class="form-control me-2"
                            placeholder="Email của bạn" required>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
            <hr class="my-4">
            <div class="row">
                <div class="col-12 text-center">
                    <p>&copy; 2025 XYZ News. All rights reserved. | Developed by FPT Polytechnic Student</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>