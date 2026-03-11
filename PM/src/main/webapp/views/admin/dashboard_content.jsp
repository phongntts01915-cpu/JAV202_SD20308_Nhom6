<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fa-solid fa-chart-pie"></i> Tổng quan hệ thống</h2>
        <span class="text-muted">Xin chào, <strong>${sessionScope.USER_FULLNAME}</strong></span>
    </div>

    <!-- CARD THỐNG KÊ -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3 shadow-sm" style="border-radius: 10px;">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title">Tổng Người Dùng</h5>
                        <h2 class="mb-0">${totalUsers}</h2>
                    </div>
                    <i class="fa-solid fa-users fa-3x opacity-50"></i>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-white bg-success mb-3 shadow-sm" style="border-radius: 10px;">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title">Danh Mục</h5>
                        <h2 class="mb-0">${totalCategories}</h2>
                    </div>
                    <i class="fa-solid fa-tags fa-3x opacity-50"></i>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-white bg-warning mb-3 shadow-sm" style="border-radius: 10px;">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title text-dark">Sản Phẩm</h5>
                        <h2 class="mb-0 text-dark">${totalProducts}</h2>
                    </div>
                    <i class="fa-solid fa-box fa-3x opacity-50 text-dark"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- BIỂU ĐỒ THỐNG KÊ -->
    <div class="row">
        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Thống kê dữ liệu</h5>
                </div>
                <div class="card-body">
                    <canvas id="polyChart" height="100"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- BIỂU ĐỒ DOANH THU + TOP SẢN PHẨM -->
    <div class="row mt-4">

        <!-- BIỂU ĐỒ DOANH THU -->
        <div class="col-md-8">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white fw-bold">
                    <i class="fa-solid fa-chart-line text-primary"></i> Biểu đồ Doanh thu năm nay
                </div>
                <div class="card-body">
                    <canvas id="revenueChart" height="100"></canvas>
                </div>
            </div>
        </div>

        <!-- TOP SẢN PHẨM -->
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white fw-bold">
                    <i class="fa-solid fa-fire text-danger"></i> Top Sản Phẩm Bán Chạy
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">

                        <c:forEach var="item" items="${topProducts}" varStatus="status">
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0">
                                <span>
                                    <strong class="text-danger me-2">#${status.index + 1}</strong>
                                    ${item.key}
                                </span>
                                <span class="badge bg-primary rounded-pill">${item.value} ly</span>
                            </li>
                        </c:forEach>

                    </ul>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

    // ===== BIỂU ĐỒ THỐNG KÊ CƠ BẢN =====
    const ctx = document.getElementById('polyChart').getContext('2d');

    const dataUsers = Number('${totalUsers}') || 0;
    const dataCategories = Number('${totalCategories}') || 0;
    const dataProducts = Number('${totalProducts}') || 0;

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Người dùng', 'Danh mục', 'Sản phẩm'],
            datasets: [{
                label: 'Số lượng',
                data: [dataUsers, dataCategories, dataProducts],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(255, 206, 86, 0.7)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });


    // ===== BIỂU ĐỒ DOANH THU =====
const revenueData = JSON.parse('${revenueData != null ? revenueData : "[]"}');
    const ctxRev = document.getElementById('revenueChart').getContext('2d');

    new Chart(ctxRev, {
        type: 'line',
        data: {
            labels: [
                'Tháng 1','Tháng 2','Tháng 3','Tháng 4','Tháng 5','Tháng 6',
                'Tháng 7','Tháng 8','Tháng 9','Tháng 10','Tháng 11','Tháng 12'
            ],
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: revenueData,
                borderColor: 'rgba(75,192,192,1)',
                backgroundColor: 'rgba(75,192,192,0.2)',
                borderWidth: 2,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true
        }
    });

</script>