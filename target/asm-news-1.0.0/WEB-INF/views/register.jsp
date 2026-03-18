<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - XYZ News</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Dùng lại toàn bộ CSS từ login.jsp của bạn */
        :root { --primary-navy: #0f172a; --accent-blue: #3b82f6; --light-bg: #f1f5f9; --white: #ffffff; }
        * { font-family: 'Be Vietnam Pro', sans-serif; transition: all 0.3s ease; }
        body { background: linear-gradient(135deg, var(--primary-navy) 0%, #1e293b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 0; }
        .login-card { background: var(--white); border-radius: 20px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.2); overflow: hidden; animation: fadeIn 0.8s ease-out; width: 100%; }
        .login-header { background: linear-gradient(45deg, var(--primary-navy), #1e293b); color: var(--white); padding: 2rem; text-align: center; }
        .login-body { padding: 2rem; }
        .btn-login { background: linear-gradient(45deg, var(--accent-blue), #2563eb); border: none; padding: 12px; font-weight: 700; border-radius: 12px !important; color: white; }
        .form-label { font-weight: 600; color: var(--primary-navy); margin-bottom: 5px; }
        .back-home { position: absolute; top: 25px; left: 25px; color: #e2e8f0; text-decoration: none; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/login" class="back-home">
        <i class="fas fa-arrow-left me-2"></i> Quay lại Đăng nhập
    </a>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="login-card">
                    <div class="login-header">
                        <h3 class="mb-0"><i class="fas fa-user-plus me-2"></i> ĐĂNG KÝ TÀI KHOẢN</h3>
                    </div>
                    <div class="login-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Tên đăng nhập *</label>
                                    <input type="text" name="id" class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Mật khẩu *</label>
                                    <input type="password" name="password" class="form-control" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Họ và tên *</label>
                                <input type="text" name="fullname" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email *</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" name="mobile" class="form-control">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" name="birthday" class="form-control">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label d-block">Giới tính</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="m" value="1" checked>
                                    <label class="form-check-label" for="m">Nam</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="f" value="0">
                                    <label class="form-check-label" for="f">Nữ</label>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary btn-login w-100">
                                <i class="fas fa-check-circle me-2"></i> HOÀN TẤT ĐĂNG KÝ
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>