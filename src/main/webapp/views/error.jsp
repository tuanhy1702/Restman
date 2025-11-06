<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lỗi - RestMan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e5ca91;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .error-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 3rem 2rem;
        }
        .error-body {
            padding: 2rem;
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
        .icon-large {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        .error-details {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            margin: 1rem 0;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-header">
            <i class="fas fa-exclamation-triangle icon-large"></i>
            <h2>Có lỗi xảy ra</h2>
            <p class="mb-0">Hệ thống gặp sự cố không mong muốn</p>
        </div>
        
        <div class="error-body">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-times-circle"></i>
                    <strong>Lỗi:</strong> ${error}
                </div>
            <% } else { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-times-circle"></i>
                    <strong>Lỗi:</strong> Có lỗi không xác định xảy ra
                </div>
            <% } %>
            
            <p class="text-muted mb-4">
                Xin lỗi vì sự bất tiện này. Chúng tôi đang khắc phục sự cố. 
                Vui lòng thử lại sau hoặc liên hệ với quản trị viên.
            </p>
            
            <!-- Error Details (only show in development) -->
            <% if (request.getAttribute("javax.servlet.error.exception") != null) { %>
                <div class="error-details">
                    <h6><i class="fas fa-bug"></i> Chi tiết lỗi (Development Mode):</h6>
                    <pre class="text-muted small"><%= request.getAttribute("javax.servlet.error.exception") %></pre>
                </div>
            <% } %>
            
            <div class="d-grid gap-2">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
                    <i class="fas fa-home"></i> Về trang chủ
                </a>
                <a href="javascript:history.back()" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
            
            <div class="mt-4">
                <small class="text-muted">
                    <i class="fas fa-info-circle"></i>
                    Nếu lỗi này tiếp tục xảy ra, vui lòng liên hệ với quản trị viên hệ thống.
                </small>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
