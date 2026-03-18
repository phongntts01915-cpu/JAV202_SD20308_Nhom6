<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - XYZ News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #EBEBEB; color: #2d3748; }
        .profile-header { background: linear-gradient(135deg, #091C35, #1D3557); color: white; padding: 60px 0 100px; text-align: center; }
        .profile-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); margin-top: -60px; background: white; overflow: hidden; }
        .avatar-lg { width: 120px; height: 120px; font-size: 3rem; border: 5px solid white; box-shadow: 0 5px 15px rgba(0,0,0,0.2); }
        .info-label { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; color: #6c757d; font-weight: 700; margin-bottom: 5px; }
        .info-value { font-size: 1.1rem; font-weight: 500; color: #091C35; border-bottom: 1px solid #e9ecef; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-custom { border-radius: 10px; padding: 10px 20px; font-weight: 600; transition: all 0.3s; }
        .btn-teal { background-color: #00A896; color: white; border: none; }
        .btn-teal:hover { background-color: #008f7f; color: white; transform: translateY(-2px); }
        .btn-outline-navy { border: 2px solid #091C35; color: #091C35; }
        .btn-outline-navy:hover { background-color: #091C35; color: white; transform: translateY(-2px); }
    </style>
</head>
<body>

    <div class="profile-header">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="text-white text-decoration-none position-absolute top-0 start-0 m-4 fw-bold">
                <i class="fas fa-arrow-left me-2"></i> Trở về Trang chủ
            </a>
            <h2 class="fw-bold">Hồ sơ của bạn</h2>
            <p class="opacity-75">Quản lý thông tin cá nhân và bảo mật tài khoản</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card profile-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-5">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold mx-auto avatar-lg mb-3">
                                ${sessionScope.currentUser.fullname.substring(0, 1).toUpperCase()}
                            </div>
                            <h3 class="fw-bold mb-1" style="color: #091C35;">${sessionScope.currentUser.fullname}</h3>
                            <span class="badge ${sessionScope.currentUser.admin ? 'bg-danger' : (sessionScope.currentUser.reporter ? 'bg-info' : 'bg-secondary')} px-3 py-2 rounded-pill">
                                <i class="fas ${sessionScope.currentUser.admin ? 'fa-crown' : (sessionScope.currentUser.reporter ? 'fa-pen' : 'fa-book-open')} me-1"></i>
                                ${sessionScope.currentUser.roleText}
                            </span>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-label"><i class="fas fa-id-card me-2"></i> Tên đăng nhập (ID)</div>
                                <div class="info-value">${sessionScope.currentUser.id}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-label"><i class="fas fa-envelope me-2"></i> Địa chỉ Email</div>
                                <div class="info-value">${sessionScope.currentUser.email}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-label"><i class="fas fa-phone me-2"></i> Số điện thoại</div>
                                <div class="info-value">${not empty sessionScope.currentUser.mobile ? sessionScope.currentUser.mobile : '<span class="text-muted fst-italic">Chưa cập nhật</span>'}</div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-label"><i class="fas fa-venus-mars me-2"></i> Giới tính</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${sessionScope.currentUser.gender}">Nam</c:when>
                                        <c:otherwise>Nữ</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="info-label"><i class="fas fa-birthday-cake me-2"></i> Ngày sinh</div>
                                <div class="info-value border-0 mb-0">
                                    <c:if test="${not empty sessionScope.currentUser.birthday}">
                                        <fmt:formatDate value="${sessionScope.currentUser.birthday}" pattern="dd/MM/yyyy" />
                                    </c:if>
                                    <c:if test="${empty sessionScope.currentUser.birthday}">
                                        <span class="text-muted fst-italic">Chưa cập nhật</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex gap-3 justify-content-center">
                            <a href="${pageContext.request.contextPath}/change-password" class="btn btn-outline-navy btn-custom w-50">
                                <i class="fas fa-key me-2"></i> Đổi mật khẩu
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-teal btn-custom w-50">
                                <i class="fas fa-newspaper me-2"></i> Đọc tin tức
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>