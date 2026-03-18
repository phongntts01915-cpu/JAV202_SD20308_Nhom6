<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container my-5">
    <h2 class="mb-4"><i class="fa-solid fa-shopping-cart"></i> Giỏ hàng của bạn</h2>
    
    <c:choose>
        <c:when test="${empty sessionScope.cart}">
            <div class="alert alert-info">Giỏ hàng đang trống. <a href="${pageContext.request.contextPath}/home">Tiếp tục chọn món</a></div>
        </c:when>
        <c:otherwise>
            <table class="table align-middle shadow-sm bg-white rounded">
                <thead class="table-dark">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng tiền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="grandTotal" value="0" />
                    <c:forEach var="entry" items="${sessionScope.cart}">
                        <c:set var="item" value="${entry.value}" />
                        <c:set var="grandTotal" value="${grandTotal + item.totalPrice}" />
                        <tr>
                            <td><strong>${item.name}</strong></td>
                            <td><fmt:formatNumber value="${item.price}" /> VNĐ</td>
                            <td>
                                <input type="number" value="${item.quantity}" class="form-control w-25">
                            </td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${item.totalPrice}" /> VNĐ</td>
                            <td><button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="fs-4">
                        <td colspan="3" class="text-end">Thành tiền:</td>
                        <td class="text-danger fw-bold"><fmt:formatNumber value="${grandTotal}" /> VNĐ</td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
            
            <div class="text-end mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Chọn thêm món</a>
                <button class="btn btn-success btn-lg">Xác nhận thanh toán <i class="fa-solid fa-credit-card"></i></button>
            </div>
        </c:otherwise>
    </c:choose>
</div>