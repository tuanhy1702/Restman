<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - RestMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e5ca91;
            min-height: 100vh;
        }
        .hero-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9) 0%, rgba(118, 75, 162, 0.9) 100%);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }
        .feature-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 3rem;
            color: #f59e0b;
            margin-bottom: 1rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(249, 115, 22, 0.4);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-utensils"></i> RestMan
            </a>
            <div class="navbar-nav ms-auto">
                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/login.jsp">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                </a>
            </div>
        </div>
    </nav>
    
    <!-- Hero Section -->
    <div class="hero-section" style="background: linear-gradient(135deg, rgba(245, 158, 11, 0.9) 0%, rgba(249, 115, 22, 0.9) 100%);">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">
                <i class="fas fa-utensils"></i> RestMan
            </h1>
            <p class="lead mb-4">Hệ thống quản lý nhà hàng toàn diện</p>
            <p class="mb-4">Quản lý menu, đơn hàng, khách hàng và nhân viên một cách hiệu quả</p>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light btn-lg">
                <i class="fas fa-rocket"></i> Bắt đầu ngay
            </a>
        </div>
    </div>
    
    <!-- Features Section -->
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-utensils feature-icon"></i>
                    <h5>Quản lý Menu</h5>
                    <p class="text-muted">Quản lý món ăn và combo một cách dễ dàng</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-shopping-cart feature-icon"></i>
                    <h5>Xử lý Đơn hàng</h5>
                    <p class="text-muted">Nhận và xử lý đơn hàng nhanh chóng</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-users feature-icon"></i>
                    <h5>Quản lý Khách hàng</h5>
                    <p class="text-muted">Theo dõi thông tin khách hàng và thẻ thành viên</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-chart-bar feature-icon"></i>
                    <h5>Thống kê Báo cáo</h5>
                    <p class="text-muted">Xem thống kê chi tiết về doanh thu và khách hàng</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-warehouse feature-icon"></i>
                    <h5>Quản lý Kho</h5>
                    <p class="text-muted">Theo dõi nguyên liệu và nhà cung cấp</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-mobile-alt feature-icon"></i>
                    <h5>Đặt hàng Online</h5>
                    <p class="text-muted">Khách hàng có thể đặt bàn và đặt món trực tuyến</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- User Types Section -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12 text-center mb-5">
                <h2>Dành cho mọi đối tượng</h2>
                <p class="text-muted">Hệ thống được thiết kế để phục vụ tất cả các vai trò trong nhà hàng</p>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-user-tie feature-icon"></i>
                    <h5>Nhân viên Quản lý</h5>
                    <p class="text-muted">Xem thống kê, quản lý menu và combo</p>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-user-check feature-icon"></i>
                    <h5>Nhân viên Bán hàng</h5>
                    <p class="text-muted">Nhận đơn hàng, thanh toán và làm thẻ thành viên</p>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-boxes feature-icon"></i>
                    <h5>Nhân viên Kho</h5>
                    <p class="text-muted">Quản lý nguyên liệu và nhà cung cấp</p>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="feature-card p-4 text-center">
                    <i class="fas fa-user feature-icon"></i>
                    <h5>Khách hàng</h5>
                    <p class="text-muted">Tìm kiếm món ăn và đặt hàng trực tuyến</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p class="mb-0">
                <i class="fas fa-utensils"></i> RestMan - Restaurant Management System
            </p>
            <p class="mb-0 text-muted">© 2024 RestMan Team. All rights reserved.</p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
