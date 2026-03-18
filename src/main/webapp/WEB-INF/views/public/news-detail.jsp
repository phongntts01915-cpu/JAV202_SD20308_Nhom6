<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title} - XYZ News</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

<style>
    :root {
        --navy: #091C35; 
        --navy-light: #1D3557; 
        --navy-hover: #2c5282; 
        --accent: #00A896; 
        --background-content: #EBEBEB; 
        --text-color: #2d3748; 
        --shadow-navbar: 0 6px 30px rgba(9, 28, 53, 0.4); 
        --shadow-subtle: 0 4px 15px rgba(0, 0, 0, 0.05); 
    }

    body {
        font-family: 'Inter', sans-serif; 
        background-color: var(--background-content); 
        color: var(--text-color);
    }
    
    h1, h2, h3, h4, h5, h6, .card-title, .widget-title, .navbar-brand {
        font-family: 'Inter', sans-serif;
        font-weight: 700;
    }

    /* Navbar & Footer */
    .navbar {
        background: linear-gradient(135deg, var(--navy), var(--navy-light)) !important;
        box-shadow: var(--shadow-navbar); 
        position: sticky; 
        top: 0;
        z-index: 1030;
        padding: 0.9rem 0; 
    }

    .navbar-brand { font-weight: 700; color: white !important; font-size: 1.5rem; letter-spacing: 1px; }
    .navbar .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 500; transition: all 0.3s ease; }
    .navbar .nav-link:hover, .navbar .nav-link.active { color: var(--accent) !important; border-bottom: 2px solid var(--accent); padding-bottom: 0.6rem; transform: none; }
    .navbar-toggler-icon { filter: invert(1); }
    .dropdown-menu { border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15); border-radius: 8px; }
    .footer { background: linear-gradient(135deg, var(--navy), var(--navy-light)); color: var(--text-light); padding: 60px 0 30px; margin-top: 80px; }
    .footer h5 { color: white; font-weight: 700; }
    .footer input.form-control { background-color: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.3); color: white; }

    /* Cards */
    .card, .news-card, .related-news-card { border-radius: 12px; box-shadow: var(--shadow-subtle); border: none; background: white; transition: all 0.3s ease; }
    .news-card:hover, .related-news-card:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); }
    .news-image { width: 100%; height: 450px; object-fit: cover; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); }
    
    .sidebar-widget, .col-lg-4 .card { border-left: 5px solid var(--accent); }
    .card-header, .widget-title { background-color: white; border-bottom: 2px solid var(--accent); color: var(--navy); font-weight: 600; border-top-left-radius: 12px; border-top-right-radius: 12px; }

    .btn-primary { background-color: var(--accent) !important; border-color: var(--accent) !important; transition: all 0.3s ease; }
    .btn-primary:hover { background-color: var(--navy) !important; border-color: var(--navy) !important; }
    .list-group-item-action { border: none; padding: 0.9rem 1.2rem; transition: all 0.3s ease; border-radius: 12px !important; margin-bottom: 0.3rem; font-weight: 500; }
    .list-group-item-action:hover { background-color: var(--accent); color: white !important; }
    
    /* Detail Page Specific */
    .breadcrumb-item a { color: var(--navy); text-decoration: none; font-weight: 500; }
    .breadcrumb-item a:hover { color: var(--accent); }
    .card-title { font-size: 2.5rem; font-weight: 700; color: var(--navy); line-height: 1.2; }

    .news-meta-container { background-color: #F8F9FA; border-left: 5px solid var(--accent); padding: 1rem 1.5rem; margin-bottom: 2rem !important; border-radius: 8px; box-shadow: var(--shadow-subtle); }
    .news-meta-container i { color: var(--navy); margin-right: 5px; }
    .news-meta-container span { color: #6c757d; font-size: 0.95em; font-weight: 500; }
    .news-meta-container .separator { color: #ced4da; margin: 0 10px; }
    .news-content { font-size: 1.1em; line-height: 1.8; color: #4a5568; }
    h3 { font-weight: 700; color: var(--navy); border-bottom: 2px solid var(--accent); padding-bottom: 10px; margin-bottom: 20px !important; }
    .card-title-related a { font-weight: 600; color: var(--navy); font-size: 1.15rem; line-height: 1.4; transition: color 0.2s; }
    .card-title-related a:hover { color: var(--accent); }
    .related-short-content { color: #718096; font-size: 0.95rem; }

    /* TƯƠNG TÁC & BÌNH LUẬN */
    .interaction-bar { border-top: 1px solid #e2e8f0; padding: 20px 0 10px 0; margin-top: 30px; display: flex; gap: 15px; align-items: center; }
    .btn-interact { border-radius: 50px; padding: 8px 20px; font-weight: 500; transition: all 0.2s ease; }
    .btn-like { background: #f1f5f9; color: #3b82f6; border: 1px solid transparent; }
    .btn-like:hover { background: #3b82f6; color: white; }
    .btn-dislike { background: #f1f5f9; color: #64748b; border: 1px solid transparent; }
    .btn-dislike:hover { background: #ef4444; color: white; }
    .btn-comment-scroll { background: #f1f5f9; color: var(--navy); border: 1px solid transparent; }
    .btn-comment-scroll:hover { background: var(--navy); color: white; }
    .comment-section { background-color: #f8fafc; border-radius: 12px; padding: 25px; margin-top: 10px; border: 1px solid #e2e8f0; }
</style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-newspaper"></i> XYZ News 
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a></li>
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
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
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

    <main class="container my-4">
        <div class="row">
            <div class="col-lg-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb" style="margin-bottom: 1.5rem;">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home me-1"></i> Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/news?action=category&id=${news.categoryId}">${news.categoryName}</a></li>
                        <li class="breadcrumb-item active text-truncate" aria-current="page">
                            <span class="text-muted">${news.title}</span>
                        </li>
                    </ol>
                </nav>

                <article class="card">
                    <div class="card-body">
                        <h1 class="card-title mb-3">${news.title}</h1>

                        <div class="news-meta-container d-flex flex-wrap align-items-center mb-4">
                            <span class="me-4 mb-2 mb-md-0"><i class="fas fa-user"></i> <span>${news.authorName}</span></span>
                            <span class="separator d-none d-md-inline-block">|</span>
                            <span class="me-4 mb-2 mb-md-0"><i class="fas fa-calendar-alt"></i> <span><fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" /></span></span>
                            <span class="separator d-none d-md-inline-block">|</span>
                            <span class="me-4 mb-2 mb-md-0"><i class="fas fa-eye"></i> <span>${news.viewCount} lượt xem</span></span>
                            <span class="separator d-none d-md-inline-block">|</span>
                            <span class="mb-2 mb-md-0"><i class="fas fa-tags"></i> <span>${news.categoryName}</span></span>
                        </div>

                        <c:if test="${not empty news.image}">
                            <div class="mb-4">
                                <img src="${pageContext.request.contextPath}/upload/${news.image}" class="news-image" alt="${news.title}">
                            </div>
                        </c:if>

                        <div class="news-content">
                            ${news.content}
                        </div>

                        <div class="interaction-bar">
                            <button type="button" class="btn btn-interact btn-like m-0" onclick="reactNews('${news.id}', 'like')">
                                <i class="far fa-thumbs-up me-1"></i> Thích 
                                <span id="likeCount" class="badge bg-white text-primary ms-1 shadow-sm border">${news.likeCount != null ? news.likeCount : 0}</span>
                            </button>

                            <button type="button" class="btn btn-interact btn-dislike m-0 ms-2" onclick="reactNews('${news.id}', 'dislike')">
                                <i class="far fa-thumbs-down me-1"></i> Không thích 
                                <span id="dislikeCount" class="badge bg-white text-danger ms-1 shadow-sm border">${news.dislikeCount != null ? news.dislikeCount : 0}</span>
                            </button>

                            <a href="#comment-section" class="btn btn-interact btn-comment-scroll text-decoration-none ms-auto">
                                <i class="far fa-comment-dots me-1"></i> Bình luận 
                                <span id="totalCommentBadge" class="badge bg-white text-dark ms-1 shadow-sm border">${news.commentCount != null ? news.commentCount : 0}</span>
                            </a>
                        </div>

                        <div id="comment-section" class="comment-section">
                            <h5 class="mb-4 fw-bold" style="color: var(--navy);">
                                <i class="fas fa-comments text-primary me-2"></i> Ý kiến bạn đọc
                            </h5>
                            
                            <c:choose>
                                <c:when test="${sessionScope.currentUser == null}">
                                    <div class="text-center p-4 bg-white rounded-3 border">
                                        <i class="fas fa-lock fs-3 text-muted mb-3 d-block"></i>
                                        <p class="mb-3 text-muted">Vui lòng đăng nhập để tham gia bình luận bài viết này.</p>
                                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary px-4 rounded-pill">Đăng nhập ngay</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex gap-3">
                                        <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold shadow-sm" 
                                             style="width: 45px; height: 45px; flex-shrink: 0; font-size: 1.2rem;">
                                            ${sessionScope.currentUser.fullname.substring(0, 1).toUpperCase()}
                                        </div>
                                        <div class="flex-grow-1">
                                            <input type="hidden" id="newsIdInput" value="${news.id}">
                                            <textarea class="form-control" id="commentContent" rows="3" placeholder="Chia sẻ quan điểm của bạn..." style="border-radius: 12px; resize: none; border: 1px solid #cbd5e1;"></textarea>
                                            <div class="d-flex justify-content-end mt-2">
                                                <button type="button" class="btn btn-primary rounded-pill px-4" onclick="addComment()">
                                                    <i class="fas fa-paper-plane me-1"></i> Gửi bình luận
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="comments-list mt-5" id="commentsContainer">
                                <c:forEach var="cmt" items="${commentsList}">
                                    <div class="comment-item d-flex gap-3 mb-4 p-3 bg-white border rounded-3 shadow-sm" id="comment-box-${cmt.id}">
                                        <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" 
                                             style="width: 45px; height: 45px; flex-shrink: 0; font-size: 1.2rem;">
                                            ${cmt.userFullName.substring(0, 1).toUpperCase()}
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="mb-1 fw-bold text-dark">${cmt.userFullName}</h6>
                                                    <small class="text-muted d-block mb-2">
                                                        <i class="far fa-clock me-1"></i>
                                                        <fmt:formatDate value="${cmt.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </small>
                                                </div>
                                                <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id == cmt.userId}">
<button class="btn btn-sm btn-outline-secondary border-0" onclick="enableEditComment('${cmt.id}')" title="Sửa bình luận"><i class="fas fa-pen"></i></button>     

</c:if>

<c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.id != cmt.userId}">
                                                    <button class="btn btn-sm btn-outline-danger border-0 ms-1" onclick="reportComment('${cmt.id}')" title="Báo cáo vi phạm"><i class="fas fa-flag"></i></button>
                                                </c:if>
                                            </div>
                                            
                                            <p class="mb-0 text-secondary" id="comment-text-${cmt.id}" style="line-height: 1.6; white-space: pre-wrap;"><c:out value="${cmt.content}" /></p>
                                            
                                            <div id="edit-form-${cmt.id}" class="d-none mt-2">
                                                <textarea class="form-control mb-2" id="edit-input-${cmt.id}" rows="2"></textarea>
<button class="btn btn-sm btn-primary" onclick="saveEditComment('${cmt.id}')">Lưu thay đổi</button>
<button class="btn btn-sm btn-light" onclick="cancelEditComment('${cmt.id}')">Hủy</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <c:if test="${empty commentsList}">
                                    <div class="text-center p-4 text-muted border border-dashed rounded-3 mt-3" id="noCommentPlaceholder">
                                        <i class="far fa-comment-dots fa-2x mb-2 opacity-50"></i>
                                        <p class="mb-0">Chưa có bình luận nào. Hãy là người đầu tiên lên tiếng!</p>
                                    </div>
                                </c:if>
                            </div>
                        </div> 
                    </div>
                </article>
            
                <c:if test="${not empty relatedNews}">
                    <div class="mt-5">
                        <h3 class="mb-4"><i class="fas fa-newspaper" style="color: var(--accent);"></i> Tin liên quan</h3>
                        <div class="row">
                            <c:forEach var="relatedNews" items="${relatedNews}">
                                <div class="col-md-6 mb-4">
                                    <div class="card related-news-card h-100">
                                        <div class="overflow-hidden">
                                            <c:if test="${not empty relatedNews.image}">
                                                <img src="${pageContext.request.contextPath}/upload/${relatedNews.image}" class="card-img-top" style="height: 200px; object-fit: cover; border-radius: 12px 12px 0 0;" alt="${relatedNews.title}">
                                            </c:if>
                                        </div>
                                        <div class="card-body d-flex flex-column">
                                            <h6 class="card-title-related mb-2">
                                                <a href="${pageContext.request.contextPath}/news?action=detail&id=${relatedNews.id}" class="text-decoration-none">${relatedNews.title}</a>
                                            </h6>
                                            <p class="card-text flex-grow-1 related-short-content">${relatedNews.getShortContent(100)}</p>
                                            <div class="news-meta mt-auto">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i> <fmt:formatDate value="${relatedNews.postedDate}" pattern="dd/MM/yyyy" /> | <i class="fas fa-eye"></i> ${relatedNews.viewCount}
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div> 
            
            <div class="col-lg-4">
                <div class="card mb-4 sidebar-widget"> 
                    <div class="card-header"><h5 class="mb-0"><i class="fas fa-list" style="color: var(--accent);"></i> Chuyên mục</h5></div>
                    <div class="card-body">
                        <div class="list-group list-group-flush">
                            <c:forEach var="category" items="${categories}">
                                <a href="${pageContext.request.contextPath}/news?action=category&id=${category.id}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                    ${category.name} <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="card sidebar-widget"> 
                    <div class="card-header"><h5 class="mb-0"><i class="fas fa-envelope" style="color: var(--accent);"></i> Đăng ký nhận tin</h5></div>
                    <div class="card-body">
                        <p class="mb-3">Nhận tin tức mới nhất qua email của bạn</p>
                        <form action="${pageContext.request.contextPath}/newsletter" method="post">
                            <input type="hidden" name="action" value="subscribe">
                            <div class="mb-3">
                                <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100"><i class="fas fa-paper-plane"></i> Đăng ký</button>
                        </form>
                    </div>
                </div>
            </div> 
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-newspaper"></i> XYZ News</h5>
                    <p>Website tin tức 24h cập nhật nhanh nhất</p>
                </div>
                <div class="col-md-6">
                    <h5>Đăng ký nhận tin</h5>
                    <form action="${pageContext.request.contextPath}/newsletter" method="post" class="d-flex">
                        <input type="hidden" name="action" value="subscribe">
                        <input type="email" name="email" class="form-control me-2" placeholder="Email của bạn" required>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>
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

    <script>
        // 1. Thích / Không thích
        function reactNews(newsId, action) {
            fetch('${pageContext.request.contextPath}/news/react', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'newsId=' + newsId + '&action=' + action
            })
            .then(response => {
                if (response.status === 401) {
                    alert("Bạn cần đăng nhập để thực hiện chức năng này!");
                    window.location.href = '${pageContext.request.contextPath}/login';
                    return null;
                }
                return response.json();
            })
            .then(data => {
                if (data) {
                    document.getElementById('likeCount').innerText = data.likes;
                    document.getElementById('dislikeCount').innerText = data.dislikes;
                }
            })
            .catch(error => console.error('Lỗi kết nối Server:', error));
        }

        // 2. Thêm Bình luận mới
        function addComment() {
            let contentElem = document.getElementById('commentContent');
            let content = contentElem.value;
            let newsId = document.getElementById('newsIdInput').value;

            if (content.trim() === '') {
                alert("Vui lòng nhập nội dung!"); return;
            }

            fetch('${pageContext.request.contextPath}/comment/action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=add&newsId=' + newsId + '&content=' + encodeURIComponent(content)
            })
            .then(res => {
                if (res.status === 401) { window.location.href = '${pageContext.request.contextPath}/login'; return null; }
                return res.json();
            })
            .then(data => {
                if (data && data.status === 'success') {
                    contentElem.value = ''; // Xóa chữ trong form
                    
                    // Ẩn chữ "chưa có bình luận" nếu có
                    let placeholder = document.getElementById('noCommentPlaceholder');
                    if (placeholder) placeholder.style.display = 'none';
                    
                    // Chèn DOM thẳng lên đầu
                    let newHtml = `
                        <div class="comment-item d-flex gap-3 mb-4 p-3 bg-white border rounded-3 shadow-sm border-start border-primary border-4">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 45px; height: 45px; font-size: 1.2rem;">
                                ` + data.fullname.substring(0,1).toUpperCase() + `
                            </div>
                            <div class="flex-grow-1">
                                <h6 class="mb-1 fw-bold text-dark">` + data.fullname + ` <span class="badge bg-success ms-2" style="font-size: 0.7em">Vừa xong</span></h6>
                                <p class="mb-0 text-secondary" style="line-height: 1.6; white-space: pre-wrap;">` + data.content + `</p>
                            </div>
                        </div>`;
                    
                    document.getElementById('commentsContainer').insertAdjacentHTML('afterbegin', newHtml);
                    
                    // Tăng số lượng bình luận
                    let countBadge = document.getElementById('totalCommentBadge');
                    if(countBadge) countBadge.innerText = parseInt(countBadge.innerText) + 1;
                } else {
                    alert("Có lỗi xảy ra: " + data.message);
                }
            });
        }

        // 3. Mở khung Sửa bình luận
        function enableEditComment(id) {
            let textElem = document.getElementById('comment-text-' + id);
            let inputElem = document.getElementById('edit-input-' + id);
            inputElem.value = textElem.innerText; // Đưa chữ cũ vào form
            textElem.classList.add('d-none');
            document.getElementById('edit-form-' + id).classList.remove('d-none');
        }

        // 4. Hủy Sửa bình luận
        function cancelEditComment(id) {
            document.getElementById('comment-text-' + id).classList.remove('d-none');
            document.getElementById('edit-form-' + id).classList.add('d-none');
        }

        // 5. Lưu Bình luận (Update)
        function saveEditComment(id) {
            let newContent = document.getElementById('edit-input-' + id).value;

            if (newContent.trim() === '') { alert("Nội dung không được rỗng!"); return; }

            fetch('${pageContext.request.contextPath}/comment/action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=edit&commentId=' + id + '&content=' + encodeURIComponent(newContent)
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    // Cập nhật text thẳng trên màn hình
                    document.getElementById('comment-text-' + id).innerText = newContent;
                    cancelEditComment(id);
                } else {
                    alert(data.message || "Có lỗi xảy ra!");
                }
            })
            .catch(err => alert("Lỗi hệ thống!"));
        }

        // Hàm xử lý Báo cáo
        function reportComment(id) {
            if (!confirm("Bạn có chắc chắn muốn báo cáo bình luận này vi phạm tiêu chuẩn cộng đồng?")) return;

            fetch('${pageContext.request.contextPath}/comment/action', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=report&commentId=' + id
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    alert("Đã gửi báo cáo thành công! Admin sẽ kiểm duyệt bình luận này.");
                } else {
                    alert("Có lỗi xảy ra, vui lòng thử lại.");
                }
            });
        }
    </script>
</body>
</html>