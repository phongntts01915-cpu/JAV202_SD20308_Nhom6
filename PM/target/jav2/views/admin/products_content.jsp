<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Quản Lý Sản Phẩm</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
            <i class="fa-solid fa-plus"></i> Thêm mới
        </button>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <table class="table table-hover modern-table">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${products}">
                        <tr>
                            <td>${item.id}</td>
                            <td><c:out value="${item.name}"/></td>
                            <td>${item.price} VNĐ</td>
                            <td>
                                <span class="badge ${item.status ? 'bg-success' : 'bg-danger'}">
                                    ${item.status ? 'Đang bán' : 'Ngừng bán'}
                                </span>
                            </td>
                            <td>
                                <a href="?action=edit&id=${item.id}" class="btn btn-sm btn-warning"><i class="fa-solid fa-pen"></i></a>
                                <a href="?action=delete&id=${item.id}" class="btn btn-sm btn-danger" onclick="return confirm('Chắc chắn xoá?');"><i class="fa-solid fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/products" method="post" id="productForm">
            <input type="hidden" name="action" value="add">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Thêm Sản Phẩm Mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label>Tên sản phẩm</label>
                        <input type="text" name="name" id="p_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Giá (VNĐ)</label>
                        <input type="number" name="price" id="p_price" class="form-control" min="1" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Lưu thông tin</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
// Client-side Validation cơ bản bằng JS
document.getElementById('productForm').addEventListener('submit', function(e) {
    const price = document.getElementById('p_price').value;
    if (price <= 0) {
        alert("Giá phải lớn hơn 0!");
        e.preventDefault(); // Ngăn chặn form submit
    }
});
</script>