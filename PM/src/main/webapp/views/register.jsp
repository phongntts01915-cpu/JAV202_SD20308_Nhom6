<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #F8F5F2; }
        .register-container { max-width: 500px; margin: 50px auto; }
        .card { border-radius: 15px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .btn-primary { background-color: #6F4E37; border: none; }
        .btn-primary:hover { background-color: #4b3526; }
    </style>
</head>
<body>
    <div class="container register-container">
        <div class="text-center mb-4">
            <h1 class="fw-bold" style="color: #6F4E37;"><i class="fa-solid fa-mug-hot"></i> PolyCoffee</h1>
            <p class="text-muted">Tạo tài khoản để trải nghiệm tốt nhất</p>
        </div>

        <div class="card p-4">
            <c:if test="${not empty error}">
                <div class="alert alert-danger shadow-sm"><i class="fa-solid fa-triangle-exclamation"></i> ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label class="form-label fw-bold">Họ và tên</label>
                    <input type="text" name="fullname" class="form-control" required placeholder="Nguyễn Văn A">
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Email</label>
                    <input type="email" name="email" class="form-control" required placeholder="email@example.com">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Tên đăng nhập</label>
                    <input type="text" name="username" class="form-control" required minlength="4">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" required minlength="6">
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Xác nhận mật khẩu</label>
                    <input type="password" name="confirmPassword" class="form-control" required minlength="6">
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold rounded-pill">Đăng Ký Ngay</button>
            </form>
            
            <div class="text-center mt-4">
                <p class="mb-0">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold" style="color: #6F4E37;">Đăng nhập</a></p>
            </div>
        </div>
    </div>
</body>
</html>