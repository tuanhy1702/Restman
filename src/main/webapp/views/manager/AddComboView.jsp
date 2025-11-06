<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.restman.entity.Manager" %>
<%@ page import="com.restman.entity.Food" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm combo mới - RestMan</title>
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
            background: #17a74a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(249, 115, 22, 0.4);
        }
        .food-item {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        .food-item:hover {
            border-color: #f59e0b;
            box-shadow: 0 5px 15px rgba(249, 115, 22, 0.1);
        }
        .food-item.selected {
            border-color: #28a745;
            background-color: #f8fff9;
        }
        .selected-foods {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1rem;
            min-height: 200px;
        }
        .selected-food-item {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 0.75rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
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
        <div class="welcome-section">
            <h2><i class="fas fa-plus"></i> Thêm combo mới</h2>
            <p class="mb-0">Tạo combo món ăn mới cho menu nhà hàng</p>
        </div>

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

        <div class="row">
            <!-- Combo Information Form -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle"></i> Thông tin combo</h5>
                    </div>
                    <div class="card-body">
                        <form id="comboForm" action="${pageContext.request.contextPath}/combo" method="post">
                            <input type="hidden" name="action" value="create">

                            <div class="mb-3">
                                <label for="name" class="form-label">Tên combo <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>

                            <div class="mb-3">
                                <label for="price" class="form-label">Giá combo (VNĐ) <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="price" name="price" min="0" step="1000" required>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button id="saveComboBtn" type="submit" class="btn btn-primary" disabled>
                                    <i class="fas fa-save"></i> Lưu combo
                                </button>
                                <a href="${pageContext.request.contextPath}/combo" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Food Selection -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-utensils"></i> Chọn món ăn cho combo</h5>
                    </div>
                    <div class="card-body">
                        <!-- Search Food -->
                        <div class="mb-3">
                            <form action="${pageContext.request.contextPath}/combo" method="get">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="searchFood" value="true">
                                <div class="row">
                                    <div class="col-md-8 mb-2">
                                        <input type="text" class="form-control" name="searchTerm" placeholder="Tìm kiếm món ăn..." value="${param.searchTerm != null ? param.searchTerm : ''}">
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select class="form-control" id="searchType" name="searchType">
                                            <option value="name" ${param.searchType == null || param.searchType == 'name' ? 'selected' : ''}>Theo tên</option>
                                            <option value="category" ${param.searchType == 'category' ? 'selected' : ''}>Theo thể loại</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-outline-primary">
                                        <i class="fas fa-search"></i> Tìm kiếm
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Selected Foods -->
                        <div class="mb-3">
                            <h6 class="d-flex justify-content-between align-items-center">
                                <span>Món ăn đã chọn: <span class="badge bg-primary" id="selectedCount">0</span></span>
                            </h6>
                            <div class="selected-foods" id="selectedFoods">
                                <p class="text-muted text-center">Chưa có món ăn nào được chọn</p>
                            </div>
                            <button type="button" class="btn btn-danger btn-sm mt-2" id="clearAllBtn" onclick="clearAllFoods()" style="display: none;">
                                <i class="fas fa-trash"></i> Xóa tất cả
                            </button>
                        </div>

                        <!-- Available Foods -->
                        <h6>Danh sách món ăn:</h6>
                        <%
                            List<Food> foods = (List<Food>) request.getAttribute("foods");
                            if (foods != null && !foods.isEmpty()) {
                        %>
                            <div class="row">
                                <% for (Food food : foods) { %>
                                    <div class="col-md-6 mb-2">
                                        <div class="food-item" data-food-id="<%= food.getId() %>" data-food-name="<%= food.getName() %>" data-food-price="<%= food.getPrice() %>">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h6 class="mb-1"><%= food.getName() %></h6>
                                                    <small class="text-muted">
                                                        <i class="fas fa-tag"></i> <%= food.getCategory() != null ? food.getCategory() : "Chưa phân loại" %>
                                                    </small>
                                                    <br>
                                                    <small class="text-primary">
                                                        <i class="fas"></i>
                                                            <%
                                                                java.text.DecimalFormatSymbols symbols = new java.text.DecimalFormatSymbols();
                                                                symbols.setGroupingSeparator(' ');
                                                                java.text.DecimalFormat df = new java.text.DecimalFormat("#,###", symbols);
                                                            %>
                                                            <span class="text-primary h6"><%= df.format(food.getPrice()) %> VNĐ</span>
                                                    </small>
                                                </div>
                                                <div>
                                                    <button type="button" class="btn btn-success btn-sm mt-1 add-food-btn"
                                                            data-food-id="<%= food.getId() %>">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        <% } else { %>
                            <div class="text-center py-4">
                                <i class="fas fa-utensils fa-2x text-muted mb-3"></i>
                                <p class="text-muted">Không có món ăn nào để hiển thị</p>

                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (function() {
            'use strict';

            let selectedFoods = [];
            const STORAGE_KEY = 'restman_selectedFoods';

            // 💾 Lưu danh sách món ăn đã chọn vào localStorage
            function saveSelectedFoods() {
                try { localStorage.setItem(STORAGE_KEY, JSON.stringify(selectedFoods)); } catch (e) {}
            }

            // 🔄 Tải danh sách món ăn đã chọn từ localStorage
            function loadSelectedFoods() {
                try {
                    const raw = localStorage.getItem(STORAGE_KEY);
                    if (raw) {
                        const data = JSON.parse(raw);
                        if (Array.isArray(data)) {
                            selectedFoods = data.map(it => ({
                                id: Number(it.id),
                                name: (it.name || '').toString(),
                                price: Number(it.price) || 0,
                                quantity: Number(it.quantity) || 1
                            }));
                            updateSelectedFoodsDisplay();
                        }
                    }
                } catch (e) {}
            }

            // 🚮 Khi tải lại trang (không phải tìm kiếm), xóa dữ liệu món ăn đã chọn trước đó
            function resetSelectedFoodsOnLoad() {
                try { localStorage.removeItem(STORAGE_KEY); } catch (e) {}
                selectedFoods = [];
                updateSelectedFoodsDisplay();
            }

            // 🟢 Gắn sự kiện cho các nút thêm món ăn (add-food-btn)
            document.addEventListener('click', function(e) {
                const btn = e.target.closest('.add-food-btn');
                if (btn) {
                    e.preventDefault();
                    const foodId = parseInt(btn.getAttribute('data-food-id'));
                    try {
                        if (foodId) addToCombo(foodId, btn);
                    } catch (err) {
                        console.error('Lỗi khi thêm món:', err);
                        alert('Không thể thêm món. Vui lòng tải lại trang.');
                    }
                }
            });

            // 🧭 Khi trang được tải:
            // Nếu là kết quả tìm kiếm (searchFood=true) → giữ nguyên món ăn đã chọn
            // Ngược lại → đặt lại danh sách rỗng
            document.addEventListener('DOMContentLoaded', function() {
                try {
                    var params = new URLSearchParams(window.location.search);
                    if (params.get('searchFood') === 'true') {
                        loadSelectedFoods();
                    } else {
                        resetSelectedFoodsOnLoad();
                    }
                } catch (e) {
                    // Trường hợp lỗi: vẫn giữ dữ liệu cũ để tránh mất lựa chọn
                    loadSelectedFoods();
                }
            });

            // 📋 Khi gửi form tạo combo
            document.addEventListener('DOMContentLoaded', function() {
                const comboForm = document.getElementById('comboForm');
                if (comboForm) {
                    comboForm.addEventListener('submit', function(e) {
                        if (selectedFoods.length === 0) {
                            e.preventDefault();
                            alert('Vui lòng chọn ít nhất một món ăn cho combo!');
                            return;
                        }
                        // Thêm danh sách món ăn đã chọn vào form (dạng input ẩn)
                        selectedFoods.forEach(function(food){
                            var input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'selectedFoods';
                            input.value = (food.id + ':' + food.quantity);
                            this.appendChild(input);
                        }.bind(this));
                    });
                }
            });

            // ➕ Hàm thêm món vào danh sách combo
            function addToCombo(foodId, triggerBtn) {
                console.log('addToCombo ->', { foodId });

                // Ưu tiên tìm phần tử món ăn theo nút được bấm
                let foodItem = triggerBtn ? triggerBtn.closest('.food-item') : null;
                if (!foodItem) {
                    foodItem = document.querySelector(`.food-item[data-food-id="${foodId}"]`);
                }
                if (!foodItem) {
                    console.error('Không tìm thấy món ăn có ID:', foodId);
                    return;
                }

                const rawName = foodItem.dataset.foodName || (foodItem.querySelector('h6') ? foodItem.querySelector('h6').textContent : '');
                const foodName = (rawName && rawName.trim().length > 0) ? rawName.trim() : `Món #${foodId}`;
                const foodPrice = Number(foodItem.dataset.foodPrice || 0) || 0;

                // Lấy số lượng, mặc định là 1 nếu không có input
                const quantityInput = foodItem.querySelector(`#quantity-${foodId}`) || foodItem.querySelector('input[type="number"]');
                const quantity = quantityInput ? (parseInt(quantityInput.value) || 1) : 1;

                // Kiểm tra xem món ăn đã tồn tại trong danh sách chưa
                const existingIndex = selectedFoods.findIndex(food => food.id === foodId);
                const isUpdate = existingIndex !== -1;

                if (isUpdate) {
                    selectedFoods[existingIndex].quantity = quantity;
                    if (!selectedFoods[existingIndex].name) selectedFoods[existingIndex].name = foodName;
                    if (typeof selectedFoods[existingIndex].price !== 'number') selectedFoods[existingIndex].price = foodPrice;
                } else {
                    selectedFoods.push({
                        id: foodId,
                        name: foodName,
                        price: foodPrice,
                        quantity: quantity
                    });
                }

                // ✨ Hiệu ứng chọn món
                foodItem.classList.add('selected');
                setTimeout(() => {
                    foodItem.classList.remove('selected');
                }, 500);

                // Cập nhật giao diện và lưu lại
                updateSelectedFoodsDisplay();
                saveSelectedFoods();
                console.log('selectedFoods after add:', selectedFoods);

                // ✅ Hiển thị thông báo tạm thời trên nút
                const btn = triggerBtn || foodItem.querySelector('.add-food-btn');
                if (btn) {
                    const originalText = btn.innerHTML;
                    btn.innerHTML = '<i class="fas fa-check"></i>';
                    btn.classList.remove('btn-success');
                    btn.classList.add('btn-primary');
                    setTimeout(() => {
                        btn.innerHTML = originalText;
                        btn.classList.remove('btn-primary');
                        btn.classList.add('btn-success');
                    }, 1000);
                }

                // 🪧 Thông báo khi thêm/cập nhật món
                const message = isUpdate
                    ? 'Đã cập nhật số lượng "' + foodName + '" thành ' + quantity
                    : 'Đã thêm "' + foodName + '" vào danh sách đã chọn';

                // Hiển thị thông báo nổi
                showNotification(message, 'success');

                // Cuộn mượt xuống khu vực món ăn đã chọn
                setTimeout(() => {
                    const selectedSection = document.getElementById('selectedFoods');
                    if (selectedSection) {
                        selectedSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }
                }, 300);
            }

            // ❌ Xóa món ra khỏi danh sách combo
            function removeFromCombo(foodId) {
                selectedFoods = selectedFoods.filter(food => food.id !== foodId);
                updateSelectedFoodsDisplay();
                saveSelectedFoods();
            }

            window.removeFromCombo = removeFromCombo;

            // 🖼️ Cập nhật hiển thị danh sách món ăn đã chọn
            function updateSelectedFoodsDisplay() {
                const container = document.getElementById('selectedFoods');
                const selectedCount = document.getElementById('selectedCount');
                const clearAllBtn = document.getElementById('clearAllBtn');
                const saveBtn = document.getElementById('saveComboBtn');

                // Cập nhật số lượng món ăn đã chọn
                selectedCount.textContent = selectedFoods.length;

                if (selectedFoods.length === 0) {
                    container.innerHTML = '<p class="text-muted text-center">Chưa có món ăn nào được chọn</p>';
                    clearAllBtn.style.display = 'none';
                    if (saveBtn) saveBtn.disabled = true;
                    return;
                }

                clearAllBtn.style.display = 'block';
                if (saveBtn) saveBtn.disabled = false;

                let html = '';
                const formatCurrency = (n) => Number(n || 0).toLocaleString('vi-VN');
                selectedFoods.forEach(food => {
                    html += '<div class="selected-food-item" data-selected-food-id="' + food.id + '">' +
                        '  <div>' +
                        '    <strong>' + (food.name && food.name.trim().length ? food.name : ('Món #' + food.id)) + '</strong>' +
                        '    <br>' +
                        '    <small class="text-muted">Số lượng: </small>' +
                        '    <input type="number" class="form-control form-control-sm d-inline-block selected-qty" style="width:80px" min="1" value="' + food.quantity + '" data-food-id="' + food.id + '">' +
                        '    <br>' +
                        '    <small class="text-primary">' + formatCurrency(food.price) + ' VNĐ</small>' +
                        '  </div>' +
                        '  <button type="button" class="btn btn-danger btn-sm remove-selected" data-food-id="' + food.id + '">' +
                        '    <i class="fas fa-trash"></i>' +
                        '  </button>' +
                        '</div>';
                });

                container.innerHTML = html;

                // 🎯 Sự kiện khi thay đổi số lượng món ăn
                container.addEventListener('input', function(ev) {
                    const qtyInput = ev.target.closest('.selected-qty');
                    if (qtyInput) {
                        const id = parseInt(qtyInput.getAttribute('data-food-id'));
                        const val = Math.max(1, parseInt(qtyInput.value) || 1);
                        const idx = selectedFoods.findIndex(f => f.id === id);
                        if (idx > -1) {
                            selectedFoods[idx].quantity = val;
                            updateSelectedFoodsDisplay();
                            saveSelectedFoods();
                        }
                    }
                });

                // 🗑️ Sự kiện khi nhấn nút xóa món
                container.addEventListener('click', function(ev) {
                    const rmBtn = ev.target.closest('.remove-selected');
                    if (rmBtn) {
                        const id = parseInt(rmBtn.getAttribute('data-food-id'));
                        removeFromCombo(id);
                    }
                });
            }

            // 🧹 Xóa tất cả món ăn đã chọn
            function clearAllFoods() {
                if (confirm('Bạn có chắc muốn xóa tất cả món ăn đã chọn?')) {
                    selectedFoods = [];
                    updateSelectedFoodsDisplay();
                    showNotification('Đã xóa tất cả món ăn đã chọn', 'info');
                }
            }

            window.clearAllFoods = clearAllFoods;

            // 🔔 Hiển thị thông báo tạm thời (notification)
            function showNotification(message, type) {
                // Xóa thông báo cũ (nếu có)
                const existingNotif = document.querySelector('.food-notification');
                if (existingNotif) {
                    existingNotif.remove();
                }

                // Tạo thông báo mới
                const notification = document.createElement('div');
                notification.className = 'alert alert-' + (type == 'success' ? 'success' : 'info') + ' food-notification';
                notification.style.cssText = 'position: fixed; top: 80px; right: 20px; z-index: 9999; min-width: 300px; animation: slideIn 0.3s ease-out;';
                notification.innerHTML = '<i class="fas fa-' + (type == 'success' ? 'check-circle' : 'info-circle') + '"></i> ' + message;

                document.body.appendChild(notification);

                // Tự động ẩn sau 3 giây
                setTimeout(() => {
                    notification.style.animation = 'slideOut 0.3s ease-out';
                    setTimeout(() => {
                        notification.remove();
                    }, 300);
                }, 3000);
            }

        })();
    </script>

</body>
</html>
