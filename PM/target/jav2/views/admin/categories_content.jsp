<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-tags"></i> Quản Lý Danh Mục</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCatModal">
            <i class="fa-solid fa-plus"></i> Thêm danh mục
        </button>
    </div>

    <%-- Thông báo lỗi khóa ngoại --%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger shadow-sm"><i class="fa-solid fa-circle-exclamation"></i> ${error}</div>
    </c:if>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <table class="table table-hover modern-table">
                <thead class="table-light">
                    <tr>
                        <th width="10%">ID</th>
                        <th width="30%">Tên danh mục</th>
                        <th width="40%">Mô tả</th>
                        <th width="20%">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${categories}">
                        <tr>
                            <td>${c.id}</td>
                            <td><strong><c:out value="${c.name}"/></strong></td>
                            <td><c:out value="${c.description}"/></td>
                            <td>
                                <a href="?action=delete&id=${c.id}" class="btn btn-sm btn-danger" onclick="return confirm('Chắc chắn xóa danh mục này?');">
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

<div class="modal fade" id="addCatModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/categories" method="post">
            <input type="hidden" name="action" value="add">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Thêm danh mục mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Tên danh mục</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Mô tả chi tiết</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-save"></i> Lưu thông tin</button>
                </div>
            </div>
        </form>
    </div>
</div>