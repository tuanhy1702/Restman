<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restman.entity.Manager" %>
<%@ page import="com.restman.entity.Combo" %>
<%@ page import="com.restman.entity.ComboFood" %>
<%@ page import="com.restman.dao.ComboFoodDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý combo - RestMan</title>
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
        .welcome-section {
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .btn-primary {
            background: #1fcd59;
            border: none;
            border-radius: 10px;
        }
        .btn-primary:hover {
            background-color: #17a74a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(249, 115, 22, 0.4);
        }
        .btn-secondary {
            background-color: #0099ff !important;
            border: none;
            border-radius: 10px;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #007acc !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 153, 255, 0.4);
        }
        .combo-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 480px;
            display: flex;
            flex-direction: column;
        }
        .combo-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }.card-body {
             font-size: 1.45rem;
        }
        .combo-image {
            height: 180px;
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            border-radius: 15px 15px 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            flex-shrink: 0;
        }
        .combo-body {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        .combo-food-list {
            flex: 1;
            overflow-y: auto;
            max-height: 150px;
            border-radius: 10px;
        }
        .combo-food-list::-webkit-scrollbar {
            width: 8px;
        }
        .combo-food-list::-webkit-scrollbar-thumb {
            background: #f59e0b;
            border-radius: 4px;
        }
        .combo-food-list::-webkit-scrollbar-thumb:hover {
            background: #d97706;
        }
    </style>
</head>
<body>
    <%
        Manager manager = (Manager) session.getAttribute("user");
        if (manager == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    %>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/views/manager/ManagerView.jsp">
                <i class="fas fa-utensils"></i> RestMan
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user-tie"></i> Xin chào, <%= manager.getName() %>
                </span>
                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/auth?action=logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2><i class="fas fa-layer-group"></i> Quản lý combo</h2>
            <p class="mb-0">Quản lý các combo món ăn trong menu của nhà hàng</p>
        </div>
        
        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/combo?action=add" 
                   class="btn btn-primary btn-lg w-100">
                    <i class="fas fa-plus"></i> Thêm combo mới
                </a>
            </div>
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/views/manager/ManagerView.jsp" 
                   class="btn btn-secondary btn-lg w-100">
                    <i class="fas fa-arrow-left"></i> Quay lại trang chủ
                </a>
            </div>
        </div>
        
        <!-- Messages -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <!-- Combo List -->
        <%
            List<Combo> combos = (List<Combo>) request.getAttribute("combos");
            if (combos != null && !combos.isEmpty()) {
        %>
            <div class="row">
                <% for (Combo combo : combos) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card combo-card">
                            <div class="combo-image">
                                <i class="fas fa-layer-group"></i>
                            </div>
                            <div class="card-body combo-body">
                                <h5 class="card-title"><%= combo.getName() %></h5>
                                <p class="card-text text-muted">
                                    <%= combo.getDescription() != null ? combo.getDescription() : "Combo món ăn ngon miệng" %>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="h6 text-primary mb-0">
                                        <i class="fas"></i>
                                            <%
                                                java.text.DecimalFormatSymbols symbols = new java.text.DecimalFormatSymbols();
                                                symbols.setGroupingSeparator(' ');
                                                java.text.DecimalFormat df = new java.text.DecimalFormat("#,###", symbols);
                                            %>
                                            <span class="text-primary h6"><%= df.format(combo.getPrice()) %> VNĐ</span>
                                    </span>
                                    <span class="badge bg-info">ID: <%= combo.getId() %></span>
                                </div>

                                
                                <div class="combo-food-list">
                                    <ul class="list-group list-group-flush mb-3">
                                        <%
                                            Map<Integer, List<ComboFood>> comboFoodsMap = (Map<Integer, List<ComboFood>>) request.getAttribute("comboFoodsMap");
                                            List<ComboFood> comboFoods = (comboFoodsMap != null) ? comboFoodsMap.get(combo.getId()) : null;
                                            if (comboFoods != null && !comboFoods.isEmpty()) {
                                                for (ComboFood cf : comboFoods) {
                                                    String foodName = (cf.getFood() != null && cf.getFood().getName() != null)
                                                        ? cf.getFood().getName()
                                                        : ("Món #" + cf.getFoodId());
                                        %>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <span><i class="fas fa-utensils text-muted"></i> <%= foodName %></span>
                                                    <span class="badge bg-secondary">x<%= cf.getQuantity() %></span>
                                                </li>
                                        <%
                                                }
                                            } else {
                                        %>
                                                <li class="list-group-item text-muted text-center">Chưa có món ăn trong combo</li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </div>

                                
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
