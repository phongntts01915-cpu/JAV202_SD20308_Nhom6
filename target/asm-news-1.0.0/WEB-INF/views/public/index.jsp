<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - XYZ News</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* SỬ DỤNG MÀU MỚI */
        :root {
    --navy: #091C35; /* Tối hơn, sâu hơn */
    --navy-light: #1D3557;
    --navy-hover: #2c5282;
    --accent: #00A896; /* Xanh ngọc lục bảo (Teal) - Sang trọng */
    --text-light: #CBD5E0;
    --shadow-subtle: 0 4px 15px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ mới */
    --shadow-lift: 0 15px 35px rgba(0, 0, 0, 0.12); /* Bóng đổ khi hover */
}

body {
    /* DÒNG CẦN THAY ĐỔI MÀU */
    font-family: 'Inter', sans-serif;
    background-color: #EBEBEB; 
    color: #2d3748;
}

/* Trong thẻ <style> - Khoảng Dòng 44 */
h1, h2, h3, h4, h5, h6, .widget-title, .navbar-brand {
    font-family: 'Inter', sans-serif; 
    font-weight: 700; 
}

        /* Navbar sang trọng */
        .navbar {
            background: linear-gradient(135deg, var(--navy), var(--navy-light)) !important;
            box-shadow: 0 6px 30px rgba(9, 28, 53, 0.4); /* Bóng đổ mạnh hơn cho Navbar */
            position: fixed;
            top: 0;
            z-index: 1030;
            padding: 0.9rem 0;
        }

        .navbar .nav-link, .navbar-brand {
            color: white !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .navbar-brand {
            letter-spacing: 1px; /* Thêm khoảng cách chữ cho thương hiệu */
        }

        .navbar .nav-link:hover, .navbar .nav-link.active {
            color: var(--accent) !important;
            border-bottom: 2px solid var(--accent); /* Thêm gạch dưới tinh tế */
            padding-bottom: 0.6rem;
            transform: none; /* Bỏ transform translateY */
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border-radius: 12px;
        }

        /* Card tin tức hiện đại */
        .news-card {
            border: none;
            border-radius: 18px; /* Bo tròn lớn hơn một chút */
            overflow: hidden;
            box-shadow: var(--shadow-subtle); /* Dùng biến shadow mới */
            transition: all 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94); /* Hiệu ứng mượt mà hơn */
            background: white;
        }

        .news-card:hover {
            transform: translateY(-8px); /* Giảm độ nảy để chuyên nghiệp hơn */
            box-shadow: var(--shadow-lift); /* Bóng đổ nâng khối khi hover */
        }

        .news-card img {
            height: 240px; /* Tăng chiều cao ảnh card */
            object-fit: cover;
            border-top-left-radius: 18px;
            border-top-right-radius: 18px;
            transition: transform 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94); /* Hiệu ứng zoom ảnh mượt hơn */
        }

        .news-card:hover img {
            transform: scale(1.08);
        }

        /* Featured News - Tin nổi bật chính */
        .featured-news {
            height: 600px;
            border-radius: 20px;
            overflow: hidden;
            position: relative;
            transition: all 0.5s ease;
        }
        
        .featured-news:hover {
            box-shadow: 0 25px 50px rgba(0,0,0,0.25) !important; /* Bóng đổ sâu hơn cho tin nổi bật */
        }


        .featured-news img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .featured-overlay {
            position: absolute;
            inset: 0;
            /* Bắt đầu gradient muộn hơn */
            background: linear-gradient(180deg, transparent 35%, rgba(9, 28, 53, 0.95) 100%); 
            display: flex;
            flex-direction: column;
            justify-content: end;
            padding: 3.5rem; /* Tăng padding */
            color: white;
        }

        .featured-overlay h2 {
            font-size: 2.8rem;
            line-height: 1.2;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.8);
        }

        /* Sidebar */
        .sidebar-widget {
            background: white;
            border-radius: 20px; /* Bo tròn lớn hơn cho widget */
            padding: 2rem; /* Tăng padding */
            box-shadow: var(--shadow-subtle);
            border-left: 5px solid var(--accent);
        }

        .widget-title {
            color: var(--navy);
            font-size: 1.6rem; /* Tăng kích thước tiêu đề widget */
            border-bottom: 4px solid var(--accent); /* Gạch dưới dày hơn */
            padding-bottom: 0.8rem;
            margin-bottom: 1.5rem;
        }

        .most-viewed-item {
            transition: all 0.3s ease;
            padding: 0.8rem 0;
            border-bottom: 1px solid #edf2f7;
        }

        .most-viewed-item:hover {
            background-color: #e6f7f5; /* Màu hover hợp với màu accent mới */
            padding-left: 15px; /* Tăng hiệu ứng dịch chuyển */
            border-radius: 8px;
        }

        .list-group-item {
            border: none;
            padding: 0.9rem 1.2rem;
            transition: all 0.3s ease;
            border-radius: 12px !important; /* Bo tròn hơn */
            margin-bottom: 0.6rem;
            font-weight: 500;
        }

        .list-group-item:hover {
            background-color: var(--accent); /* Đổi màu hover sang accent mới */
            color: white !important;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--navy), var(--navy-light));
            color: var(--text-light);
            margin-top: 120px; /* Tăng khoảng cách margin */
            padding: 70px 0 40px;
        }

        .social-links a {
            width: 45px;
            height: 45px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 8px;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--accent);
            transform: translateY(-8px) scale(1.05); /* Hiệu ứng bay lên tinh tế hơn */
        }

        /* Nút back to top */
        #backToTop {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent); /* Dùng màu accent mới */
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            box-shadow: 0 8px 20px rgba(0, 168, 150, 0.4); /* Bóng đổ nổi bật hơn */
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            transition: background 0.3s ease;
        }

        #backToTop:hover {
            background: var(--navy); /* Hover sang màu Navy */
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-lg fixed-top">
        <div class="container">
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/">
                <i class="fas fa-newspaper me-2"></i> XYZ News
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/news">Tin tức</a></li>
                    <c:forEach var="category" items="${categories}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/news?action=category&id=${category.id}">
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
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i> ${sessionScope.currentUser.fullname}
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
                                    <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container" style="margin-top: 100px;">
        <c:if test="${sessionScope.successMessage != null}">
            <div class="alert alert-success alert-dismissible fade show mt-4" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <c:if test="${sessionScope.errorMessage != null}">
            <div class="alert alert-danger alert-dismissible fade show mt-4" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>
    </div>

    <main class="container my-5">
        <div class="row g-5">
            <div class="col-lg-8">
                <c:if test="${not empty homeNews}">
                    <section class="mb-5">
                        <h2 class="mb-4 text-center text-lg-start"><i class="fas fa-star text-warning me-3"></i>Tin nổi bật</h2>

                        <c:forEach var="news" items="${homeNews}" varStatus="status">
                            <c:if test="${status.index == 0}">
                                <div class="featured-news shadow-lg mb-4">
                                    <img src="${pageContext.request.contextPath}/upload/${news.image}" alt="${news.title}">
                                    <div class="featured-overlay">
                                        <span class="badge bg-danger fs-6 mb-3">HOT</span>
                                        <h2>${news.title}</h2>
                                        <p class="lead fs-5 mb-4">${news.getShortContent(200)}</p>
                                        <div class="d-flex align-items-center text-white-50 mb-3 mb-4">
                                            <small>
                                                <i class="fas fa-user me-2"></i>${news.authorName}
                                                <span class="mx-3">|</span>
                                                <i class="fas fa-calendar me-2"></i><fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy"/>
                                                <span class="mx-3">|</span>
                                                <i class="fas fa-eye me-2"></i>${news.viewCount} lượt xem
                                            </small>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}" class="btn btn-outline-light btn-lg">
                                            Đọc ngay <i class="fas fa-arrow-right ms-2"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <div class="row g-4">
                            <c:forEach var="news" items="${homeNews}" varStatus="status">
                                <c:if test="${status.index > 0 && status.index < 3}">
                                    <div class="col-md-6">
                                        <div class="card news-card h-100">
                                            <div class="overflow-hidden">
                                                <c:if test="${not empty news.image}">
                                                    <img src="${pageContext.request.contextPath}/upload/${news.image}" class="card-img-top" alt="${news.title}">
                                                </c:if>
                                            </div>
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}" class="text-decoration-none text-dark">
                                                        ${news.title}
                                                    </a>
                                                </h5>
                                                <p class="card-text text-muted">${news.getShortContent(120)}</p>
                                                <div class="mt-auto">
                                                    <small class="text-muted">
                                                        <i class="fas fa-calendar me-1"></i><fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy"/>
                                                        <span class="mx-2">•</span>
                                                        <i class="fas fa-eye me-1"></i>${news.viewCount} lượt
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>

                <section>
                    <h3 class="mb-4"><i class="fas fa-clock text-primary me-3"></i>Tin mới nhất</h3>
                    <div class="row g-4">
                        <c:forEach var="news" items="${latestNews}">
                            <div class="col-md-6">
                                <div class="card news-card h-100">
                                    <div class="overflow-hidden">
                                        <c:if test="${not empty news.image}">
                                            <img src="${pageContext.request.contextPath}/upload/${news.image}" class="card-img-top" alt="${news.title}">
                                        </c:if>
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">
                                            <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}" class="text-decoration-none text-dark">
                                                ${news.title}
                                            </a>
                                        </h5>
                                        <p class="card-text text-muted flex-grow-1">${news.getShortContent(100)}</p>
                                        <small class="text-muted mt-auto">
                                            <i class="fas fa-calendar me-1"></i><fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy"/>
                                            <span class="mx-2">•</span>
                                            <i class="fas fa-eye me-1"></i>${news.viewCount} lượt xem
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </div>

            <div class="col-lg-4">
                <div class="sidebar-widget mb-4">
                    <h5 class="widget-title"><i class="fas fa-fire text-danger me-3"></i>Tin được xem nhiều</h5>
                    <c:forEach var="news" items="${mostViewedNews}" varStatus="status">
                        <div class="most-viewed-item d-flex">
                          
                            <span class="badge rounded-pill me-3" 
                                style="width: 35px; height: 35px; padding-top: 7px; background-color: var(--accent); font-size: 1.1rem; font-weight: 700;">
                                ${status.index + 1}
                            </span>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">
                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}" class="text-decoration-none text-dark">
                                        ${news.title}
                                    </a>
                                </h6>
                                <small class="text-muted"><i class="fas fa-eye me-1"></i>${news.viewCount} lượt xem</small>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="sidebar-widget mb-4">
                    <h5 class="widget-title"><i class="fas fa-th-list text-success me-3"></i>Chuyên mục</h5>
                    <div class="list-group list-group-flush">
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/news?action=category&id=${category.id}"
                               class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                ${category.name}
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <div class="sidebar-widget">
                    <h5 class="widget-title"><i class="fas fa-envelope text-info me-3"></i>Đăng ký nhận tin</h5>
                    <p>Nhận tin tức nóng hổi mỗi ngày trực tiếp vào email</p>
                    <form action="${pageContext.request.contextPath}/newsletter" method="post">
                        <input type="hidden" name="action" value="subscribe">
                        <div class="input-group mb-3">
                            <input type="email" name="email" class="form-control" placeholder="Email của bạn" required>
                            <button class="btn btn-primary" type="submit"><i class="fas fa-paper-plane"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h4><i class="fas fa-newspaper me-3"></i>ASM News</h4>
                    <p class="mb-0">Website tin tức 24h - Cập nhật nhanh nhất, chính xác nhất</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="social-links mb-4">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-tiktok"></i></a>
                    </div>
                    <form class="d-inline-flex" action="${pageContext.request.contextPath}/newsletter" method="post">
                        <input type="hidden" name="action" value="subscribe">
                        <input type="email" name="email" class="form-control me-2" placeholder="Email của bạn" required>
                        <button class="btn btn-outline-light"><i class="fas fa-paper-plane"></i></button>
                    </form>
                </div>
            </div>
            <hr class="my-4 border-secondary">
            <div class="text-center">
                <p>&copy; 2025 ASM News. All rights reserved. | Developed by FPT Polytechnic Student</p>
            </div>
        </div>
    </footer>

    <button id="backToTop" class="btn btn-lg"><i class="fas fa-arrow-up"></i></button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Back to top button
        window.onscroll = function() {
            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
                document.getElementById("backToTop").style.display = "flex";
            } else {
                document.getElementById("backToTop").style.display = "none";
            }
        };

        document.getElementById('backToTop').addEventListener('click', function() {
            window.scrollTo({top: 0, behavior: 'smooth'});
        });
    </script>
</body>

</html>