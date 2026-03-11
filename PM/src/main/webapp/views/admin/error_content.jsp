<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid fade-in mt-5 text-center">
    
    <i class="fa-solid fa-triangle-exclamation text-danger fa-5x mb-4"></i>
    <h1 class="text-danger fw-bold">Opps! Đã có lỗi xảy ra.</h1>
    <p class="lead text-muted">Hệ thống đang gặp sự cố. Dưới đây là thông tin chi tiết:</p>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger d-inline-block text-start shadow-sm mt-3" style="max-width: 600px;">
            <strong>Chi tiết kỹ thuật:</strong> <br>
            <c:out value="${error}" />
        </div>
    </c:if>

    <div class="mt-4">
        <button onclick="history.back()" class="btn btn-secondary me-2">
            <i class="fa-solid fa-arrow-left"></i> Quay lại trang trước
        </button>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">
            <i class="fa-solid fa-house"></i> Về trang Dashboard
        </a>
    </div>

</div>