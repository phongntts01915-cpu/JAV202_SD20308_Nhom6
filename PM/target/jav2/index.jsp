<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PolyCoffee - Thưởng thức hương vị Việt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --coffee: #6F4E37; --coffee-dark: #4b3526; --light: #F8F5F2; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--light); }
        .navbar { background-color: var(--coffee) !important; padding: 1rem 0; }
        .nav-link { font-weight: 500; }
        .card-product { border-radius: 15px; transition: 0.3s; }
        .card-product:hover { transform: translateY(-10px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .btn-buy { background-color: var(--coffee); color: white; border-radius: 25px; padding: 8px 20px; border: none; }
        .btn-buy:hover { background-color: var(--coffee-dark); color: white; }
        .cart-badge { position: absolute; top: -5px; right: -10px; padding: 3px 6px; border-radius: 50%; font-size: 10px; }
        .intro-section { padding: 80px 0; background-color: white; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold fs-3" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-mug-hot"></i> PolyCoffee
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#menu">Thực đơn</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">Giới thiệu</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/cart?action=view" class="text-white me-4 position-relative">
                        <i class="fa-solid fa-cart-shopping fs-4"></i>
                        <span id="cart-count" class="badge bg-danger cart-badge">
                            ${sessionScope.cart != null ? sessionScope.cart.size() : 0}
                        </span>
                    </a>

                    <c:choose>
                        <c:when test="${not empty sessionScope.USER_ROLE}">
                            <div class="dropdown">
                                <button class="btn btn-outline-light dropdown-toggle btn-sm" data-bs-toggle="dropdown">
                                    Chào, ${sessionScope.USER_FULLNAME}
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <c:if test="${sessionScope.USER_ROLE == 'ADMIN' || sessionScope.USER_ROLE == 'STAFF'}">
                                        <li><a class="dropdown-item fw-bold text-primary" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="fa-solid fa-gauge"></i> Quản trị hệ thống
                                        </a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-sign-out-alt"></i> Đăng xuất
                                    </a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm rounded-pill px-4">Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <header class="py-5 text-center text-white" style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'); background-size: cover; background-position: center; height: 500px; display: flex; align-items: center;">
        <div class="container">
            <h1 class="display-2 fw-bold mb-3 animate__animated animate__fadeInDown">Hương vị cà phê đích thực</h1>
            <p class="lead fs-3 mb-4">Mỗi tách cà phê là một câu chuyện, hãy để PolyCoffee viết cùng bạn.</p>
            <a href="#menu" class="btn btn-light btn-lg rounded-pill px-5 fw-bold" style="color: var(--coffee);">Khám phá ngay</a>
        </div>
    </header>

    <section class="intro-section" id="about">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <img src="https://images.unsplash.com/photo-1442512595331-e89e73853f31?auto=format&fit=crop&w=600&q=80" class="img-fluid rounded-4 shadow" alt="About">
                </div>
                <div class="col-md-6 ps-md-5">
                    <h2 class="display-5 fw-bold mb-4" style="color: var(--coffee);">Về PolyCoffee</h2>
                    <p class="text-muted fs-5">PolyCoffee không chỉ bán cà phê, chúng tôi mang đến không gian kết nối và cảm hứng sáng tạo. Với những hạt cà phê thượng hạng được tuyển chọn từ vùng cao nguyên Việt Nam, mỗi ly đồ uống đều chứa đựng tâm huyết của những nghệ nhân pha chế.</p>
                    <ul class="list-unstyled mt-4">
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Nguyên liệu sạch 100%</li>
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Không gian hiện đại, yên tĩnh</li>
                        <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Phục vụ tận tâm, chuyên nghiệp</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <div class="container py-5" id="menu">
        <div class="text-center mb-5">
            <h2 class="display-6 fw-bold text-uppercase" style="color: var(--coffee);">Thực đơn nổi bật</h2>
            <div class="mx-auto mt-2" style="width: 80px; height: 4px; background-color: var(--coffee);"></div>
        </div>
        
        <div class="row g-4">
            <c:forEach var="p" items="${productList}">
                <div class="col-md-3">
                    <div class="card h-100 card-product border-0 shadow-sm overflow-hidden">
                        <div class="position-relative">
                            <img src="https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=400&q=80" class="card-img-top" alt="${p.name}">
                            <span class="position-absolute top-0 end-0 m-3 badge bg-dark opacity-75">Hot Item</span>
                        </div>
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold fs-5">${p.name}</h5>
                            <p class="text-muted small mb-3 text-truncate-2">${p.description}</p>
                            <h5 class="text-danger fw-bold mb-3">
                                <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                            </h5>
<button onclick="addToCart('${p.id}')" class="btn btn-buy w-100 fw-bold">
                                    <i class="fa-solid fa-cart-plus me-2"></i> Thêm vào giỏ
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="py-5 bg-dark text-white">
        <div class="container text-center">
            <div class="mb-4">
                <i class="fa-solid fa-mug-hot fa-3x mb-3 text-warning"></i>
                <h3>PolyCoffee System</h3>
                <p class="text-muted">Mang hương vị Việt đến từng không gian làm việc.</p>
            </div>
            <div class="social-links mb-4">
                <a href="#" class="text-white me-3 fs-4"><i class="fa-brands fa-facebook"></i></a>
                <a href="#" class="text-white me-3 fs-4"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="text-white fs-4"><i class="fa-brands fa-tiktok"></i></a>
            </div>
            <hr class="opacity-25">
            <p class="mb-0 opacity-50">&copy; 2026 PolyCoffee - Principal Software Engineer System</p>
        </div>
    </footer>

    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 2000;">
        <div id="cartToast" class="toast align-items-center text-white bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex p-2">
                <div class="toast-body fs-6">
                    <i class="fa-solid fa-circle-check me-2"></i> Tuyệt vời! Món ăn đã được thêm vào giỏ.
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId) {
            // AJAX Fetch gửi lên CartServlet
            const params = new URLSearchParams();
            params.append('action', 'add');
            params.append('id', productId);

            fetch('${pageContext.request.contextPath}/cart', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            })
            .then(response => response.json())
            .then(data => {
                if(data.status === 'success') {
                    // 1. Hiện thông báo Toast
                    const toastEl = document.getElementById('cartToast');
                    const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
                    toast.show();
                    
                    // 2. Cập nhật số lượng trên icon giỏ hàng
                    document.getElementById('cart-count').innerText = data.totalItems;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Có lỗi xảy ra khi thêm vào giỏ!");
            });
        }
    </script>
</body>
</html>