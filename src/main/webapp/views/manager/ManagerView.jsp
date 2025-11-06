<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restman.entity.Manager" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang quản lý - RestMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff2cc; /* vàng nhạt */
            font-family: Arial, sans-serif;
            text-align: center;
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        /* NAVBAR */
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }

        /* Welcome section (ô chứa chữ "Quản lý combo") */
        .welcome-section {
            background: linear-gradient(135deg, #f59e0b 0%, #f97316 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem auto;
            width: 80%;
            max-width: 1000px;
            text-align: left;
        }

        .welcome-section h2 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .welcome-section p {
            font-size: 1.1rem;
        }

        /* MAIN BUTTON */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-custom {
            background-color: #0099ff;
            color: white;
            font-weight: bold;
            font-size: 1.5rem;
            border: 1px solid black;
            border-radius: 3px;
            width: 500px;
            padding: 8px 0;
            text-transform: capitalize;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #007acc;
            color: white;
            transform: scale(1.05);
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

<!-- NAVBAR -->
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

<!-- Ô "Quản lý combo" -->
<div class="welcome-section">
    <h2><i class="fas fa-layer-group"></i> Nhân viên quản lí</h2>
    <p class="mb-0">Theo dõi thống kê món ăn, nguyên liệu, khách hàng và nhà cung cấp</p>
</div>

<!-- Nút chính giữa -->
<main>
    <a href="${pageContext.request.contextPath}/combo" class="btn btn-custom">
        Quản lí combo
    </a>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
