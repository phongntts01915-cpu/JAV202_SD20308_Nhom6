<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-users"></i> Quản Lý Tài Khoản</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
            <i class="fa-solid fa-user-plus"></i> Cấp tài khoản
        </button>
    </div>

    <%-- Thông báo lỗi từ Servlet --%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger shadow-sm"><i class="fa-solid fa-circle-exclamation"></i> ${error}</div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <table class="table table-hover modern-table">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Họ và Tên</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td><strong><c:out value="${u.username}"/></strong></td>
                            <td><c:out value="${u.fullname}"/></td>
                            <td>
                                <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-info'}">
                                    ${u.role}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${u.status ? 'bg-success' : 'bg-secondary'}">
                                    ${u.status ? 'Hoạt động' : 'Đã khóa'}
                                </span>
                            </td>
                            <td>
                                <a href="?action=delete&id=${u.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/users" method="post">
            <input type="hidden" name="action" value="add">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Cấp tài khoản mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Tên đăng nhập (Username)</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Mật khẩu khởi tạo</label>
                        <input type="password" name="password" class="form-control" required minlength="6">
                    </div>
                    <div class="mb-3">
                        <label>Họ và tên nhân viên</label>
                        <input type="text" name="fullname" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Phân quyền (Role)</label>
                        <select name="role" class="form-select">
                            <option value="STAFF">Nhân viên (STAFF)</option>
                            <option value="ADMIN">Quản trị viên (ADMIN)</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-save"></i> Tạo tài khoản</button>
                </div>
            </div>
        </form>
    </div>
</div>