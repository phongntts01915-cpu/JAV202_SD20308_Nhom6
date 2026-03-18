<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quên mật khẩu - XYZ System</title>
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
    <a href="${pageContext.request.contextPath}/login" class="back-btn"><i class="fas fa-arrow-left"></i> Về trang đăng nhập</a>
    
    <div class="auth-card">
        <div class="auth-header">
            <h4 class="mb-0"><i class="fas fa-unlock-alt me-2"></i> Khôi phục mật khẩu</h4>
        </div>
        <div class="p-4">
            <p class="text-muted text-center mb-4" style="font-size: 14px;">Vui lòng nhập ID và Email đã đăng ký để hệ thống cấp lại mật khẩu.</p>
            
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger py-2">${sessionScope.errorMessage}</div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold text-secondary text-uppercase" style="font-size: 12px;">Tên đăng nhập (ID)</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary text-uppercase" style="font-size: 12px;">Email xác thực</label>
                    <input type="email" class="form-control" name="email" required>
                </div>
                <button type="submit" class="btn btn-primary w-100"><i class="fas fa-paper-plane me-2"></i> KHÔI PHỤC MẬT KHẨU</button>
            </form>
        </div>
    </div>
</body>
</html>