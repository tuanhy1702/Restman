<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restman.entity.Customer" %>
<%@ page import="com.restman.entity.Food" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết món ăn - RestMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff2cc;
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        .food-detail-section {
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .food-image {
            height: 300px;
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 5rem;
        }
        .price-tag {

            color: white;
            padding: 1rem;
            border-radius: 15px;
            text-align: left;

        }.h6 {
            font-size: 1.8rem; /* 👈 tăng cỡ chữ */
            font-weight: bold; /* 👈 làm chữ đậm hơn nếu cần */
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        Food food = (Food) request.getAttribute("food");
        if (food == null) {
            response.sendRedirect(request.getContextPath() + "/views/customer/SearchFoodView.jsp");
            return;
        }
    %>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/views/customer/CustomerView.jsp">
                <i class="fas fa-utensils"></i> RestMan
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user"></i> Xin chào, <%= customer.getName() %>
                </span>
                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/auth?action=logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <!-- Header Section -->
        <div class="food-detail-section">
            <h2><i class="fas fa-utensils"></i> Chi tiết món ăn</h2>
            <p class="mb-0">Thông tin chi tiết về món ăn bạn đã chọn</p>
        </div>
        
        <!-- Food Detail Card -->
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="food-image">
                    <i class="fas fa-utensils"></i>
                </div>
            </div>
            
            <div class="col-md-6 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <h3 class="card-title text-primary"><%= food.getName() %></h3>
                        
                        <div class="mb-3">
                            <h6 class="text-muted">Thể loại:</h6>
                            <span class="badge bg-secondary">
                                <i class="fas fa-tag"></i> <%= food.getCategory() != null ? food.getCategory() : "Chưa phân loại" %>
                            </span>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="text-muted">Mô tả:</h6>
                            <p class="card-text">
                                <%= food.getDescription() != null ? food.getDescription() : "Món ăn ngon miệng được chế biến từ những nguyên liệu tươi ngon nhất." %>
                            </p>
                        </div>
                        
                        <div class="price-tag mb-4">
                            <h4 class="mb-0">
                                <i class="fas "></i>
                                <%
                                    java.text.DecimalFormatSymbols symbols = new java.text.DecimalFormatSymbols();
                                    symbols.setGroupingSeparator(' ');
                                    java.text.DecimalFormat df = new java.text.DecimalFormat("#,###", symbols);
                                %>
                                <span class="text-primary h6"><%= df.format(food.getPrice()) %> VNĐ</span>
                            </h4>
                        </div>
                        
                        <div class="d-grid gap-2">

                            <a href="${pageContext.request.contextPath}/views/customer/SearchFoodView.jsp" 
                               class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Quay lại tìm kiếm
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Additional Information -->

    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart() {
            // TODO: Implement add to cart functionality
            alert('Chức năng thêm vào giỏ hàng sẽ được phát triển trong phiên bản tiếp theo!');
        }
    </script>
</body>
</html>
