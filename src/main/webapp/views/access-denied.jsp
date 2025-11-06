<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Truy cập bị từ chối - RestMan</title>
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
        .access-denied-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
            text-align: center;
        }
        .access-denied-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 3rem 2rem;
        }
        .access-denied-body {
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
    </style>
</head>
<body>
    <div class="access-denied-container">
        <div class="access-denied-header">
            <i class="fas fa-ban icon-large"></i>
            <h2>Truy cập bị từ chối</h2>
            <p class="mb-0">Bạn không có quyền truy cập vào trang này</p>
        </div>
        
        <div class="access-denied-body">
            <div class="alert alert-warning" role="alert">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>Lỗi 403 - Forbidden</strong>
            </div>
            
            <p class="text-muted mb-4">
                Xin lỗi, bạn không có quyền truy cập vào trang này. 
                Vui lòng liên hệ với quản trị viên nếu bạn cho rằng đây là lỗi.
            </p>
            
            <div class="d-grid gap-2">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập lại
                </a>
                <a href="javascript:history.back()" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
            
            <div class="mt-4">
                <small class="text-muted">
                    <i class="fas fa-info-circle"></i>
                    Nếu bạn đã đăng nhập nhưng vẫn gặp lỗi này, 
                    có thể tài khoản của bạn không có quyền truy cập vào chức năng này.
                </small>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
