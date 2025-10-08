
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Aurora Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <jsp:include page="/WEB-INF/views/layouts/_head_admin.jsp" />

</head>
<body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/views/layouts/_header.jsp" />
    
    <div id="layoutSidenav">
        
        <jsp:include page="/WEB-INF/views/layouts/_sidebar_admin.jsp" />

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <div class="d-flex align-items-center">
                            <button id="sidebarToggle" class="btn btn-outline-secondary btn-sm me-3 d-lg-none" type="button" aria-label="Toggle sidebar">
                                <i class="bi bi-list"></i>
                            </button>
                            <h1 class="mt-4 dashboard-title">Tổng quan bán hàng</h1>
                        </div>
                        <div class="d-flex align-items-center mt-4">
                            <span class="me-3 text-muted d-none d-md-inline">Xin chào, Admin</span>
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-bell"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><h6 class="dropdown-header">Thông báo</h6></li>
                                    <li><a class="dropdown-item" href="#">Đơn hàng mới #1234</a></li>
                                    <li><a class="dropdown-item" href="#">Sản phẩm sắp hết hàng</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Stats Cards Row -->
                    <div class="row mt-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="card stats-card stats-card-primary mb-4">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="stats-icon">
                                            <i class="bi bi-graph-up"></i>
                                        </div>
                                        <div class="ms-3">
                                            <div class="stats-label">Tổng quan</div>
                                            <div class="stats-value">15,420,000đ</div>
                                            <div class="stats-change positive">+12.5%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card stats-card stats-card-warning mb-4">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="stats-icon">
                                            <i class="bi bi-cart-check"></i>
                                        </div>
                                        <div class="ms-3">
                                            <div class="stats-label">Đơn hàng mới</div>
                                            <div class="stats-value">156</div>
                                            <div class="stats-change positive">+8.2%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card stats-card stats-card-success mb-4">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="stats-icon">
                                            <i class="bi bi-people"></i>
                                        </div>
                                        <div class="ms-3">
                                            <div class="stats-label">Sản phẩm</div>
                                            <div class="stats-value">89</div>
                                            <div class="stats-change negative">-2.1%</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card stats-card stats-card-info mb-4">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="stats-icon">
                                            <i class="bi bi-star"></i>
                                        </div>
                                        <div class="ms-3">
                                            <div class="stats-label">Đánh giá TB</div>
                                            <div class="stats-value">4.8/5</div>
                                            <div class="stats-change neutral">-</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Charts and Activity Row -->
                    <div class="row">
                        <div class="col-xl-8">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="bi bi-bar-chart me-1"></i>
                                    Doanh thu 7 ngày qua
                                </div>
                                <div class="card-body">
                                    <div class="chart-placeholder">
                                        <div class="text-center py-5">
                                            <i class="bi bi-bar-chart-line display-1 text-muted"></i>
                                            <p class="text-muted mt-3">Biểu đồ doanh thu sẽ hiển thị tại đây</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-4">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="bi bi-clock-history me-1"></i>
                                    Hoạt động gần đây
                                </div>
                                <div class="card-body">
                                    <div class="activity-list">
                                        <div class="activity-item">
                                            <div class="activity-icon activity-icon-success">
                                                <i class="bi bi-cart-plus"></i>
                                            </div>
                                            <div class="activity-content">
                                                <div class="activity-title">Đơn hàng mới #DH000234</div>
                                                <div class="activity-time">2 phút trước</div>
                                            </div>
                                        </div>
                                        
                                        <div class="activity-item">
                                            <div class="activity-icon activity-icon-warning">
                                                <i class="bi bi-exclamation-triangle"></i>
                                            </div>
                                            <div class="activity-content">
                                                <div class="activity-title">Sách "Đắc nhân tâm" sắp hết hàng</div>
                                                <div class="activity-time">15 phút trước</div>
                                            </div>
                                        </div>
                                        
                                        <div class="activity-item">
                                            <div class="activity-icon activity-icon-danger">
                                                <i class="bi bi-star"></i>
                                            </div>
                                            <div class="activity-content">
                                                <div class="activity-title">Đánh giá "Tôi thấy hoa vàng trên cỏ xanh"</div>
                                                <div class="activity-time">1 giờ trước</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            
            <jsp:include page="/WEB-INF/views/layouts/_footer.jsp" />
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/layouts/_scripts.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/assets/js/adminDashboard.js'/>"></script>
</body>
</html>
