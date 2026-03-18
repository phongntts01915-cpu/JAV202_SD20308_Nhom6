<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Quản trị - XYZ Admin Premium</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        /* ===========================
           CUSTOM VARIABLES
        =========================== */
        :root {
            --primary-navy: #0f172a; /* Navy đậm */
            --accent-blue: #3b82f6; /* Xanh điểm nhấn */
            --light-bg: #f1f5f9;
            --white: #ffffff;
            --shadow-deep: 0 20px 25px -5px rgba(0, 0, 0, 0.2), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        /* ===========================
           RESET & TYPOGRAPHY
        =========================== */
        * {
            font-family: 'Be Vietnam Pro', sans-serif;
            transition: all 0.3s ease;
        }

        body {
            background: linear-gradient(135deg, var(--primary-navy) 0%, #1e293b 100%); 
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* ===========================
           LOGIN CARD
        =========================== */
        .login-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-deep);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        .login-header {
            background: linear-gradient(45deg, var(--primary-navy), #1e293b); 
            color: var(--white);
            padding: 3rem 2rem;
            text-align: center;
        }

        .login-header h3 {
            font-weight: 800;
            letter-spacing: 1px;
            font-size: 1.8rem;
        }

        .login-header p {
            font-weight: 400;
            color: #cbd5e1;
        }

        .login-body {
            padding: 2.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-navy);
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
        }

        .form-control:focus {
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .btn-login {
            background: linear-gradient(45deg, var(--accent-blue), #2563eb); 
            border: none;
            padding: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            border-radius: 12px !important;
            box-shadow: 0 6px 15px rgba(59, 130, 246, 0.3);
        }

        .btn-login:hover {
            background: linear-gradient(45deg, #2563eb, var(--accent-blue));
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.5);
        }

        .back-home {
            position: absolute;
            top: 25px;
            left: 25px;
            color: #e2e8f0;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .back-home:hover {
            color: var(--white);
            text-decoration: underline;
        }

        .alert {
            border-radius: 10px;
            border: none;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .alert-danger { background-color: #fecaca; color: #b91c1c; border-left: 5px solid #ef4444; }
        .alert-success { background-color: #d1fae5; color: #065f46; border-left: 5px solid #10b981; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
    <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="fas fa-arrow-left me-2"></i> Về trang chủ
    </a>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="login-card">
                    <div class="login-header">
                        <h3 class="mb-0">
                            <i class="fas fa-layer-group me-2"></i> XYZ ADMIN
                        </h3>
                        <p class="mb-0 mt-2">Hệ thống quản trị nội dung</p>
                    </div>

                    <div class="login-body">
                        <h5 class="text-center text-muted mb-4 fw-bold">Đăng nhập</h5>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.successMessage != null}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i> ${sessionScope.successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user-circle me-1 text-muted"></i> Tên đăng nhập
                                </label>
                                <input type="text" class="form-control" id="username" name="username"
                                    value="${username}" >
                            </div>

                            <div class="mb-4">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-1 text-muted"></i> Mật khẩu
                                </label>
                                <input type="password" class="form-control" id="password" name="password"
                                    required placeholder="Nhập mật khẩu của bạn">
                            </div>

                            <button type="submit" class="btn btn-primary btn-login w-100">
                                <i class="fas fa-sign-in-alt me-2"></i> Đăng nhập
                            </button>
                        </form>

                        <div class="text-center mt-4">
                            <p class="mb-0 text-muted">Chưa có tài khoản? 
                                <a href="${pageContext.request.contextPath}/register" class="text-primary fw-bold text-decoration-none">Đăng ký ngay</a>
                            </p>
                        </div>

                        <div class="text-center mt-3">
    <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
</div>

                        <div class="text-center mt-4">
                            <small class="text-muted">© 2025 XYZ News. All rights reserved.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>