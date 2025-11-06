<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restman.entity.Customer" %>
<%@ page import="com.restman.entity.Food" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm món ăn - RestMan</title>
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
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .search-section {
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .btn-primary {
            background: #0099ff;
            border: none;
            border-radius: 10px;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(249, 115, 22, 0.4);
        }
        .food-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }
        .food-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        .food-image {
            height: 200px;
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            border-radius: 15px 15px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
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
        <!-- Search Section -->
        <div class="search-section">
            <h2><i class="fas fa-search"></i> Tìm kiếm món ăn</h2>
            <p class="mb-0">Nhập tên món ăn để tìm kiếm thông tin chi tiết</p>
        </div>
        
        <!-- Search Form -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/food" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label for="searchTerm" class="form-label">Tên món ăn</label>
                            <input type="text" class="form-control" id="searchTerm" name="searchTerm" 
                                   placeholder="Nhập tên món ăn..." value="${searchTerm}">
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                        <a href="${pageContext.request.contextPath}/views/customer/CustomerView.jsp" 
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Search Results -->
        <% 
            List<Food> foods = (List<Food>) request.getAttribute("foods");
            if (foods != null && !foods.isEmpty()) {
        %>
            <div class="row">
                <% for (Food food : foods) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card food-card">
                            <div class="food-image">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%= food.getName() %></h5>


                                <div class="d-flex justify-content-between align-items-center">
                                    <a href="${pageContext.request.contextPath}/food?action=detail&foodId=<%= food.getId() %>" 
                                       class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else if (request.getParameter("searchTerm") != null) { %>
            <div class="alert alert-info" role="alert">
                <i class="fas fa-info-circle"></i> Không tìm thấy món ăn nào với từ khóa "${searchTerm}"
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
