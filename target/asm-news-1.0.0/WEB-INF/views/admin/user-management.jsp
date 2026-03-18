<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - XYZ Admin Premium</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
/* ===========================
   CUSTOM VARIABLES (Đồng bộ với Dashboard)
=========================== */
:root {
    --primary-navy: #0f172a; 
    --secondary-navy: #1e293b; 
    --accent-blue: #3b82f6; 
    --light-bg: #f1f5f9; 
    --text-dark: #334155;
    --text-light: #94a3b8;
    --white: #ffffff;
    --shadow-soft: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

* {
    font-family: 'Be Vietnam Pro', sans-serif;
    transition: all 0.3s ease;
}

body {
    background-color: var(--light-bg);
    color: var(--text-dark);
    overflow-x: hidden;
}

/* SIDEBAR */
.sidebar {
    height: 100vh;
    background: var(--primary-navy); 
    box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1); 
    z-index: 1000;
}

.sidebar h5 {
    font-weight: 700;
    letter-spacing: 0.5px;
    color: var(--white);
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    margin-bottom: 20px;
    text-align: center;
}

.sidebar .nav-link {
    color: #cbd5e1;
    padding: 14px 20px;
    margin-bottom: 8px;
    border-radius: 12px;
    font-size: 0.95rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.sidebar .nav-link i { width: 24px; text-align: center; font-size: 1.1rem; }
.sidebar .nav-link:hover { background: rgba(255, 255, 255, 0.1); color: var(--white); transform: translateX(5px); }
.sidebar .nav-link.active { background: linear-gradient(90deg, var(--accent-blue), #2563eb); color: var(--white) !important; font-weight: 600; box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3); transform: none; }
.sidebar hr { background-color: rgba(255, 255, 255, 0.2); opacity: 1; }

/* MAIN CONTENT & NAVBAR */
.main-content { background-color: var(--light-bg); padding-left: 0; padding-top: 0; }
.navbar-admin { background: var(--white); padding: 1rem 2rem; box-shadow: var(--shadow-soft); margin-bottom: 2rem; border-radius: 0 0 20px 20px; border-bottom: none; z-index: 900; display: flex; align-items: center; }
.navbar-admin h4 { color: var(--primary-navy); font-weight: 700; font-size: 1.5rem; }
.navbar-text { background: var(--light-bg); padding: 8px 16px; border-radius: 50px; display: flex; align-items: center; gap: 10px; color: var(--primary-navy); font-weight: 600; border: 1px solid #e2e8f0; }
.navbar-text i { color: var(--accent-blue); font-size: 1.2rem; }

/* PAGE TITLE */
.page-title { font-size: 26px; font-weight: 700; margin-bottom: 12px; position: relative; padding-bottom: 12px; color: var(--primary-navy); }
.page-title::after { content: ""; position: absolute; bottom: 0; left: 0; width: 160px; height: 3px; background: var(--accent-blue); border-radius: 2px; }

/* CARDS & TABLE */
.card { border: none; border-radius: 20px; background: var(--white); box-shadow: var(--shadow-soft); margin-bottom: 2rem; overflow: hidden; }
.card-header { background: var(--secondary-navy); color: var(--white); font-weight: 700; font-size: 1.1rem; padding: 1.2rem 1.5rem; border-bottom: none; border-radius: 20px 20px 0 0 !important; display: flex; align-items: center; gap: 10px; }
.card-header i { color: var(--white); }
.table { margin-bottom: 0; vertical-align: middle; }
.table thead th { background: #f8fafc; color: #64748b; font-weight: 600; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px; border-bottom: 2px solid #e2e8f0; padding: 1rem; }
.table tbody td { padding: 1rem; color: var(--text-dark); border-bottom: 1px solid #f1f5f9; font-size: 0.95rem; }
.table tbody tr:hover { background-color: #f8fafc; }
.table tbody tr:last-child td { border-bottom: none; }

/* Badges */
.badge { padding: 0.5em 0.8em; font-weight: 600; border-radius: 6px; }
.badge.bg-danger { background-color: #dc2626 !important; }
.badge.bg-info { background-color: #3b82f6 !important; }
.badge.bg-secondary { background-color: #64748b !important; }

/* Buttons */
.btn { border-radius: 10px !important; font-weight: 600; padding: 10px 18px; transition: all 0.3s ease; }
.btn-primary { background-color: var(--accent-blue) !important; border-color: var(--accent-blue) !important; }
.btn-primary:hover { background-color: #2563eb !important; border-color: #2563eb !important; box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3); }
.btn-group .btn-sm { border-radius: 6px !important; font-weight: 500; padding: 6px 10px; }
.btn-outline-primary { color: #1e293b; border-color: #1e293b; }
.btn-outline-primary:hover { background: #1e293b; color: white; }
.btn-outline-danger { color: #ef4444; border-color: #ef4444; }
.btn-outline-danger:hover { background: #ef4444; color: white; }

/* Modal */
.modal-header { background: var(--primary-navy); color: var(--white); font-weight: 600; border-radius: 20px 20px 0 0 !important; }
.modal-content { border-radius: 20px !important; }
.modal-footer { border-radius: 0 0 20px 20px !important; background: #f8fafc; }

/* Alerts */
.alert { border-radius: 12px; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); font-weight: 500; }
.alert-success { background: #10b981; color: var(--white); }
.alert-danger { background: #d32f2f; color: var(--white); }
.alert .btn-close { filter: invert(1); opacity: 0.8; }
.form-check-inline { margin-right: 1.5rem; }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3 col-lg-2 px-0 sidebar position-fixed">
                <div class="p-3">
                    <h5 class="text-white text-center mt-2">
                        <i class="fas fa-layer-group me-2"></i> XYZ ADMIN
                    </h5>

                    <nav class="nav flex-column mt-4">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                            <i class="fas fa-chart-pie"></i> Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
                            <i class="fas fa-file-alt"></i> Quản lý tin tức
                        </a>
                        <c:if test="${sessionScope.currentUser.admin}">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-folder-open"></i> Quản lý chuyên mục
                            </a>
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users-cog"></i> Quản lý người dùng
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments"></i> Quản lý bình luận
                            </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                <i class="fas fa-envelope-open-text"></i> Newsletter
                            </a>
                        </c:if>
                        <hr class="text-white-50">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-external-link-alt"></i> Xem trang chủ
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </nav>
                </div>
            </div>

            <div class="col-md-9 col-lg-10 ms-auto main-content">
                <nav class="navbar navbar-expand-lg navbar-admin sticky-top">
                    <div class="container-fluid">
                        <h4 class="mb-0">Quản lý người dùng</h4>
                        <div class="navbar-nav ms-auto">
                            <span class="navbar-text">
                                <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.currentUser.fullname}
                            </span>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4">
                    <h2 class="page-title">Danh sách người dùng</h2>

                    <c:if test="${sessionScope.successMessage != null}">
                        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="fas fa-check-circle me-2 fs-5"></i> ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session" />
                    </c:if>

                    <c:if test="${sessionScope.errorMessage != null}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="fas fa-exclamation-circle me-2 fs-5"></i> ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="errorMessage" scope="session" />
                    </c:if>

                    <div class="row mb-4">
                        <div class="col-12">
                            <button type="button" class="btn btn-primary" onclick="showAddUserModal()">
                                <i class="fas fa-plus"></i> Thêm người dùng mới
                            </button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-list"></i> Danh sách người dùng
                                    </h5>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Họ tên</th>
                                                            <th>Email</th>
                                                            <th>Ngày sinh</th>
                                                            <th>Giới tính</th>
                                                            <th>Điện thoại</th>
                                                            <th>Vai trò</th><th>Trạng thái</th>
                                                            <th class="text-end">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
<c:forEach var="user" items="${users}">
                                                    <tr>
                                                        <td><code>${user.id}</code></td>
                                                        <td><strong>${user.fullname}</strong></td>
                                                        <td>${user.email}</td>
                                                        <td>
                                                            <c:if test="${user.birthday != null}">
                                                                <fmt:formatDate value="${user.birthday}" pattern="dd/MM/yyyy" />
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.gender}">
                                                                    <span class="text-primary fw-bold"><i class="fas fa-mars me-1"></i> Nam</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-danger fw-bold"><i class="fas fa-venus me-1"></i> Nữ</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${user.mobile}</td>
                                                        
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.admin}"><span class="badge bg-danger"><i class="fas fa-crown me-1"></i> Quản trị</span></c:when>
                                                                <c:when test="${user.reporter}"><span class="badge bg-info"><i class="fas fa-pencil-alt me-1"></i> Phóng viên</span></c:when>
                                                                <c:otherwise><span class="badge bg-secondary"><i class="fas fa-book-open me-1"></i> Độc giả</span></c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.active}">
                                                                    <span class="badge bg-success">Hoạt động</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">Bị khóa</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        
                                                        <td class="text-end">
                                                            <div class="btn-group" role="group">
                                                                <button type="button" class="btn btn-sm btn-outline-primary"
                                                                    onclick="editUser('${user.id}', '${user.fullname}', '${user.email}', '${user.birthday}', '${user.gender}', '${user.mobile}', '${user.role}')"
                                                                    title="Sửa">
                                                                    <i class="fas fa-edit"></i>
                                                                </button>
                                                                
                                                                <c:if test="${user.id != sessionScope.currentUser.id}">
                                                                    <c:choose>
                                                                        <c:when test="${user.active}">
                                                                            <button type="button" class="btn btn-sm btn-outline-warning"
                                                                                onclick="toggleUserStatus('${user.id}', '${user.fullname}', false)" title="Khóa tài khoản">
                                                                                <i class="fas fa-lock"></i>
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button type="button" class="btn btn-sm btn-outline-success"
                                                                                onclick="toggleUserStatus('${user.id}', '${user.fullname}', true)" title="Mở khóa">
                                                                                <i class="fas fa-unlock"></i>
                                                                            </button>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-5">
                                                <i class="fas fa-users-cog fa-4x text-light mb-3"></i>
                                                <h6 class="text-muted fw-normal">Chưa có người dùng nào</h6>
                                                <button type="button" class="btn btn-primary mt-3" onclick="showAddUserModal()">
                                                    <i class="fas fa-plus"></i> Thêm người dùng đầu tiên
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="userModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="userModalTitle"><i class="fas fa-user-plus me-2"></i> Thêm người dùng mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="userIdInput" class="form-label">ID đăng nhập <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="userIdInput" name="id" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userFullname" class="form-label">Họ tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="userFullname" name="fullname" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="userEmail" name="email" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userPassword" class="form-label">Mật khẩu <span class="text-danger" id="passwordRequiredLabel">*</span></label>
                                    <input type="password" class="form-control" id="userPassword" name="password">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userMobile" class="form-label">Điện thoại</label>
                                    <input type="text" class="form-control" id="userMobile" name="mobile">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="userBirthday" class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" id="userBirthday" name="birthday">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Giới tính</label>
                                <div class="pt-2">
                                    <label class="form-check form-check-inline">
                                        <input type="radio" class="form-check-input" name="gender" id="genderMale" value="true"> Nam
                                    </label>
                                    <label class="form-check form-check-inline">
                                        <input type="radio" class="form-check-input" name="gender" id="genderFemale" value="false"> Nữ
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Vai trò</label>
                            <div class="pt-2">
                                <label class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" name="role" id="roleReader" value="2" checked> Độc giả
                                </label>
                                <label class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" name="role" id="roleReporter" value="0"> Phóng viên
                                </label>
                                <label class="form-check form-check-inline">
                                    <input type="radio" class="form-check-input" name="role" id="roleAdmin" value="1"> Quản trị
                                </label>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" id="saveUserBtn">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i> Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
<p class="lead" id="modalActionText"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    function showAddUserModal() {
        document.getElementById('userModalTitle').innerHTML = '<i class="fas fa-user-plus me-2"></i> Thêm người dùng mới';
        document.getElementById('saveUserBtn').textContent = 'Thêm mới';

        document.getElementById('userIdInput').value = '';
        document.getElementById('userIdInput').disabled = false;
        document.getElementById('userIdInput').required = true;

        document.getElementById('userFullname').value = '';
        document.getElementById('userEmail').value = '';
        document.getElementById('userPassword').value = '';
        document.getElementById('userMobile').value = '';
        document.getElementById('userBirthday').value = '';

        document.getElementById('genderMale').checked = true;
        
        // Sửa Default Role khi tạo user mới
        document.getElementById('roleReader').checked = true;

        document.getElementById('userPassword').required = true;
        document.getElementById('passwordRequiredLabel').style.display = "inline";

        new bootstrap.Modal(document.getElementById('userModal')).show();
    }

    function editUser(id, fullname, email, birthday, gender, mobile, role) {
        document.getElementById('userModalTitle').innerHTML = '<i class="fas fa-user-edit me-2"></i> Sửa thông tin người dùng';
        document.getElementById('saveUserBtn').textContent = 'Cập nhật';

        document.getElementById('userIdInput').value = id;
        document.getElementById('userIdInput').disabled = true;
        document.getElementById('userIdInput').required = false;

        document.getElementById('userFullname').value = fullname;
        document.getElementById('userEmail').value = email;
        document.getElementById('userMobile').value = mobile || '';
        document.getElementById('userBirthday').value = birthday || '';

        document.getElementById('genderMale').checked = gender === 'true';
        document.getElementById('genderFemale').checked = gender === 'false';

        // SỬA CÁCH BẮT GIÁ TRỊ ROLE BẰNG JAVASCRIPT
        document.getElementById('roleAdmin').checked = role === '1';
        document.getElementById('roleReporter').checked = role === '0';
        document.getElementById('roleReader').checked = role === '2';

        document.getElementById('userPassword').required = false;
        document.getElementById('passwordRequiredLabel').style.display = "none";
        document.getElementById('userPassword').value = '';

        new bootstrap.Modal(document.getElementById('userModal')).show();
    }

function toggleUserStatus(id, fullname, isActivating) {
        const modalTitle = document.querySelector('.modal-title');
        const confirmBtn = document.getElementById('confirmDelete');
        const modalText = document.getElementById('modalActionText'); // Lấy thẻ p vừa tạo

        // Tùy biến giao diện (Chữ, Màu sắc, Icon) theo trạng thái
        if(isActivating) {
            modalTitle.innerHTML = '<i class="fas fa-unlock text-success me-2"></i> Xác nhận mở khóa';
            modalText.innerHTML = `Bạn có chắc chắn muốn <b>mở khóa</b> tài khoản của "<b>` + fullname + `</b>"?`;
            
            confirmBtn.className = 'btn btn-success';
            confirmBtn.textContent = 'Mở khóa';
        } else {
            modalTitle.innerHTML = '<i class="fas fa-lock text-warning me-2"></i> Xác nhận khóa tài khoản';
            modalText.innerHTML = `Bạn có chắc chắn muốn <b>khóa</b> tài khoản của "<b>` + fullname + `</b>"?<br><br><small class="text-danger fw-bold"><i class="fas fa-exclamation-circle me-1"></i> Người dùng này sẽ không thể đăng nhập vào hệ thống!</small>`;
            
            confirmBtn.className = 'btn btn-warning text-dark';
            confirmBtn.textContent = 'Khóa ngay';
        }

        // Logic submit form (Giữ nguyên)
        confirmBtn.onclick = function () {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/admin/users/toggle-status';

            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;

            const activeInput = document.createElement('input');
            activeInput.type = 'hidden';
            activeInput.name = 'isActive';
            activeInput.value = isActivating;

            form.appendChild(idInput);
            form.appendChild(activeInput);
            document.body.appendChild(form);
            form.submit();
        };

        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        modal.show();
    }
    </script>
</body>
</html>