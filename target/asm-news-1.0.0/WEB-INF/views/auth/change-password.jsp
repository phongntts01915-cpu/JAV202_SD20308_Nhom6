<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đổi mật khẩu - XYZ System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { background-color: #0f172a; font-family: 'Be Vietnam Pro', sans-serif; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { background: #fff; border-radius: 15px; width: 100%; max-width: 400px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); overflow: hidden; }
        .auth-header { background: #1e293b; color: white; text-align: center; padding: 25px; }
        .form-control { border-radius: 8px; padding: 10px 15px; }
        .btn-primary { background-color: #2563eb; border: none; border-radius: 8px; padding: 12px; font-weight: 600; }
        .back-btn { position: absolute; top: 20px; left: 20px; color: white; text-decoration: none; }
    </style>
</head>
<body>
    <a href="javascript:history.back()" class="back-btn"><i class="fas fa-arrow-left"></i> Quay lại</a>
    
    <div class="auth-card">
        <div class="auth-header">
            <h4 class="mb-0"><i class="fas fa-key me-2"></i> Đổi mật khẩu</h4>
        </div>
        <div class="p-4">
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger py-2">${sessionScope.errorMessage}</div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <form action="${pageContext.request.contextPath}/change-password" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary text-uppercase" style="font-size: 12px;">Mật khẩu hiện tại</label>
                    <input type="password" class="form-control" name="oldPassword" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary text-uppercase" style="font-size: 12px;">Mật khẩu mới</label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary text-uppercase" style="font-size: 12px;">Xác nhận mật khẩu mới</label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-save me-2"></i> CẬP NHẬT MẬT KHẨU</button>
            </form>
        </div>
    </div>
</body>
</html>