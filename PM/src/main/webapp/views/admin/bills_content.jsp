<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-file-invoice-dollar"></i> Quản lý Hóa đơn</h2>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Mã HD</th>
                        <th>Ngày lập</th>
                        <th>Khách hàng</th>
                        <th>Nhân viên</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bills}">
                        <tr>
                            <td>#${b.id}</td>
                            <td><fmt:formatDate value="${b.date}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>${b.customerName != null ? b.customerName : "Khách vãng lai"}</td>
                            <td>${b.staffName}</td>
                            <td class="fw-bold text-danger"><fmt:formatNumber value="${b.amount}" type="currency" currencySymbol=""/> VNĐ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${b.status == 0}"><span class="badge bg-warning">Chờ xử lý</span></c:when>
                                    <c:when test="${b.status == 1}"><span class="badge bg-success">Đã thanh toán</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">Đã hủy</span></c:otherwise>
                                </c:choose>
                            </td>
<td>

    <!-- Nút xem chi tiết -->
    <button class="btn btn-sm btn-info text-white">
        <i class="fa-solid fa-eye"></i>
    </button>

    <!-- Nút thu tiền -->
    <c:if test="${b.status == 0}">
        <a href="?action=markPaid&id=${b.id}"
           class="btn btn-sm btn-success"
           onclick="return confirm('Xác nhận khách đã thanh toán tiền cho hóa đơn #${b.id}?');">
            <i class="fa-solid fa-check"></i> Thu tiền
        </a>
    </c:if>

</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>