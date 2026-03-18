<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PolyCoffee Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
<div class="d-flex">

    <nav class="sidebar flex-shrink-0 p-3" style="width: 250px;">
        <h3 class="text-center py-3 border-bottom">
            <i class="fa-solid fa-mug-hot"></i> PolyCoffee
        </h3>

 <ul class="list-unstyled mt-3">

    <%-- Nút xem trang chủ --%>
    <li class="mb-3">
        <a href="${pageContext.request.contextPath}/home"
           class="btn btn-outline-info w-100 text-start text-white border-0">
            <i class="fa-solid fa-house-user"></i> Về trang chủ
        </a>
    </li>

    <hr class="text-white opacity-25">

    <li>
        <a href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fa-solid fa-chart-pie"></i> Dashboard
        </a>
    </li>

    <%-- Menu chỉ dành cho ADMIN --%>
    <c:if test="${sessionScope.USER_ROLE == 'ADMIN'}">
        <li>
            <a href="${pageContext.request.contextPath}/admin/users">
                <i class="fa-solid fa-user-tie"></i> Nhân viên
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/customer/cart">
                <i class="fa-solid fa-users"></i> Khách hàng
            </a>
        </li>
    </c:if>

    <li>
        <a href="${pageContext.request.contextPath}/admin/categories">
            <i class="fa-solid fa-tags"></i> Categories
        </a>
    </li>

    <li>
        <a href="${pageContext.request.contextPath}/admin/products">
            <i class="fa-solid fa-box"></i> Products
        </a>
    </li>

    <%-- Menu dành cho ADMIN và STAFF --%>
    <li>
        <a href="${pageContext.request.contextPath}/admin/bills">
            <i class="fa-solid fa-file-invoice-dollar"></i> Hóa đơn
        </a>
    </li>

    <!-- NÚT ĐỔI MẬT KHẨU -->
    <li class="mt-4">
        <a href="#" class="text-warning fw-bold"
           data-bs-toggle="modal"
           data-bs-target="#changePassModal">
            <i class="fa-solid fa-key"></i> Đổi mật khẩu
        </a>
    </li>

    <!-- LOGOUT -->
    <li class="mt-2">
        <a href="${pageContext.request.contextPath}/logout" class="text-danger">
            <i class="fa-solid fa-sign-out-alt"></i> Logout
        </a>
    </li>

</ul>
    </nav>

    <div class="flex-grow-1 p-4">
        <jsp:include page="${contentPage}" />
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</body>
</html>