<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PolyCoffee - Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #F8F5F2; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .login-card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden; }
        .login-header { background-color: #6F4E37; color: white; padding: 30px; text-align: center; }
        .btn-coffee { background-color: #6F4E37; color: white; border: none; }
        .btn-coffee:hover { background-color: #C8A27A; color: white; }
        /* Animation nhẹ khi load form */
        .fade-in { animation: fadeIn 0.8s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<div class="container fade-in">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card login-card">
                <div class="login-header">
                    <h2><i class="fa-solid fa-mug-hot"></i> PolyCoffee</h2>
                    <p class="mb-0">Hệ thống quản trị</p>
                </div>
                <div class="card-body p-4">
                    
                    <%-- Hiển thị thông báo lỗi nếu có --%>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    
                    <c:if test="${param.msg == 'auth_required'}">
                        <div class="alert alert-warning text-center" role="alert">
                            Vui lòng đăng nhập để tiếp tục!
                        </div>
                    </c:if>

<form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">

    <div class="mb-3">
        <label class="form-label">Tên đăng nhập</label>
        <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="username" class="form-control" required placeholder="Nhập username...">
        </div>
    </div>

    <div class="mb-4">
        <label class="form-label">Mật khẩu</label>
        <div class="input-group">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="password" id="pwd" class="form-control" required placeholder="Nhập mật khẩu...">
        </div>
        <div class="form-text text-danger" id="pwdError" style="display:none;">
            Mật khẩu phải từ 6 ký tự!
        </div>
    </div>

    <button type="submit" class="btn btn-coffee w-100 py-2 fw-bold">
        ĐĂNG NHẬP
    </button>

    <!-- LINK ĐĂNG KÝ -->
    <div class="text-center mt-4">
        <p class="mb-0 text-muted">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/register"
               class="text-decoration-none fw-bold"
               style="color: #6F4E37;">
                Đăng ký ngay
            </a>
        </p>
    </div>

</form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Client-side validation: Kiểm tra độ dài mật khẩu trước khi submit
document.getElementById('loginForm').addEventListener('submit', function(e) {
    const pwd = document.getElementById('pwd').value;
    if (pwd.length < 6) {
        document.getElementById('pwdError').style.display = 'block';
        e.preventDefault(); // Chặn gửi form
    }
});
</script>
</body>
</html>