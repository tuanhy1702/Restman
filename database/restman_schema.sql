-- RestMan Database Schema
-- Tạo database và các bảng cho hệ thống quản lý nhà hàng

-- Tạo database
CREATE DATABASE IF NOT EXISTS restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman_db;

-- Bảng thành viên (Member) - bảng cha cho Customer và Staff
CREATE TABLE tblMember (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(20),
    email VARCHAR(100),
    dateOfBirth DATE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng nhân viên (Staff)
CREATE TABLE tblStaff (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    position VARCHAR(50) NOT NULL,
    Memberid INT(10) NOT NULL,
    FOREIGN KEY (Memberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng khách hàng (Customer)
CREATE TABLE tblCustomer (
    Memberid INT(10) PRIMARY KEY,
    FOREIGN KEY (Memberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng nhân viên quản lý (Manager)
CREATE TABLE tblManager (
    Staffid INT(10) PRIMARY KEY,
    StaffMemberid INT(10) NOT NULL,
    FOREIGN KEY (Staffid) REFERENCES tblStaff(id) ON DELETE CASCADE,
    FOREIGN KEY (StaffMemberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng nhân viên bán hàng (SaleStaff)
CREATE TABLE tblSaleStaff (
    Staffid INT(10) PRIMARY KEY,
    StaffMemberid INT(10) NOT NULL,
    MembershipCardid INT DEFAULT 0,
    FOREIGN KEY (Staffid) REFERENCES tblStaff(id) ON DELETE CASCADE,
    FOREIGN KEY (StaffMemberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng nhân viên kho (WarehouseStaff)
CREATE TABLE tblWarehouseStaff (
    Staffid INT(10) PRIMARY KEY,
    StaffMemberid INT(10) NOT NULL,
    FOREIGN KEY (Staffid) REFERENCES tblStaff(id) ON DELETE CASCADE,
    FOREIGN KEY (StaffMemberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng thẻ thành viên (MembershipCard)
CREATE TABLE tblMembershipCard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    point INT DEFAULT 0,
    date DATE NOT NULL,
    CustomerMemberid INT(10) NOT NULL,
    FOREIGN KEY (CustomerMemberid) REFERENCES tblCustomer(Memberid) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng món ăn (Food)
CREATE TABLE tblFood (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    discription TEXT,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng combo (Combo)
CREATE TABLE tblCombo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    discription TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng món ăn trong combo (ComboFood)
CREATE TABLE tblComboFood (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 1,
    Comboid INT NOT NULL,
    Foodid INT NOT NULL,
    FOREIGN KEY (Comboid) REFERENCES tblCombo(id) ON DELETE CASCADE,
    FOREIGN KEY (Foodid) REFERENCES tblFood(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng hóa đơn (Bill)
CREATE TABLE tblBill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    price FLOAT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    CustomerMemberid INT(10) NOT NULL,
    SaleStaffStaffid INT(10) NOT NULL,
    SaleStaffStaffMemberid INT(10) NOT NULL,
    FOREIGN KEY (CustomerMemberid) REFERENCES tblCustomer(Memberid) ON DELETE CASCADE,
    FOREIGN KEY (SaleStaffStaffid) REFERENCES tblSaleStaff(Staffid) ON DELETE CASCADE,
    FOREIGN KEY (SaleStaffStaffMemberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng bàn ăn (Table)
CREATE TABLE tblTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    NumberOfSeats INT NOT NULL,
    status VARCHAR(20) DEFAULT 'available',
    Billid INT,
    FOREIGN KEY (Billid) REFERENCES tblBill(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng đơn hàng món ăn (FoodOrder)
CREATE TABLE tblFoodOrder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 1,
    price FLOAT NOT NULL,
    Billid INT NOT NULL,
    Foodid INT NOT NULL,
    FOREIGN KEY (Billid) REFERENCES tblBill(id) ON DELETE CASCADE,
    FOREIGN KEY (Foodid) REFERENCES tblFood(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng đơn hàng combo (OrderCombo)
CREATE TABLE tblOrderCombo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 1,
    price FLOAT NOT NULL,
    Billid INT NOT NULL,
    Comboid INT NOT NULL,
    FOREIGN KEY (Billid) REFERENCES tblBill(id) ON DELETE CASCADE,
    FOREIGN KEY (Comboid) REFERENCES tblCombo(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng nhà cung cấp (Supplier)
CREATE TABLE tblSupplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng hóa đơn nhập hàng (ImportBill)
CREATE TABLE tblImportBill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price FLOAT NOT NULL,
    date DATE NOT NULL,
    WarehouseStaffStaffid INT(10) NOT NULL,
    WarehouseStaffStaffMemberid INT(10) NOT NULL,
    Supplierid INT NOT NULL,
    FOREIGN KEY (WarehouseStaffStaffid) REFERENCES tblWarehouseStaff(Staffid) ON DELETE CASCADE,
    FOREIGN KEY (WarehouseStaffStaffMemberid) REFERENCES tblMember(id) ON DELETE CASCADE,
    FOREIGN KEY (Supplierid) REFERENCES tblSupplier(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tạo indexes để tối ưu hiệu suất
CREATE INDEX idx_member_username ON tblMember(username);
CREATE INDEX idx_food_name ON tblFood(name);
CREATE INDEX idx_food_category ON tblFood(category);
CREATE INDEX idx_combo_name ON tblCombo(name);
CREATE INDEX idx_bill_date ON tblBill(date);
CREATE INDEX idx_bill_status ON tblBill(status);
CREATE INDEX idx_table_status ON tblTable(status);

-- Insert dữ liệu mẫu
-- Thêm admin/manager mặc định
INSERT INTO tblMember (username, password, name, phoneNumber, email, address) VALUES
('admin', 'admin123', 'Administrator', '0123456789', 'admin@restman.com', '123 Admin Street');

INSERT INTO tblStaff (position, Memberid) VALUES
('Manager', 1);

INSERT INTO tblManager (Staffid, StaffMemberid) VALUES
(1, 1);

-- Thêm nhân viên bán hàng mẫu
INSERT INTO tblMember (username, password, name, phoneNumber, email, address) VALUES
('salestaff1', 'staff123', 'Nguyễn Văn A', '0987654321', 'staff1@restman.com', '456 Staff Street');

INSERT INTO tblStaff (position, Memberid) VALUES
('Sale Staff', 2);

INSERT INTO tblSaleStaff (Staffid, StaffMemberid, MembershipCardid) VALUES
(2, 2, 0);

-- Thêm nhân viên kho mẫu
INSERT INTO tblMember (username, password, name, phoneNumber, email, address) VALUES
('warehouse1', 'warehouse123', 'Trần Thị B', '0912345678', 'warehouse@restman.com', '789 Warehouse Street');

INSERT INTO tblStaff (position, Memberid) VALUES
('Warehouse Staff', 3);

INSERT INTO tblWarehouseStaff (Staffid, StaffMemberid) VALUES
(3, 3);

-- Thêm khách hàng mẫu
INSERT INTO tblMember (username, password, name, phoneNumber, email, dateOfBirth, address) VALUES
('customer1', 'customer123', 'Lê Văn C', '0945678901', 'customer@email.com', '1990-01-01', '321 Customer Street');

INSERT INTO tblCustomer (Memberid) VALUES
(4);

-- Thêm món ăn mẫu
INSERT INTO tblFood (name, price, discription, category) VALUES
('Phở Bò', 50000, 'Phở bò truyền thống với nước dùng đậm đà', 'Món chính'),
('Bún Bò Huế', 45000, 'Bún bò Huế cay nồng đặc trưng', 'Món chính'),
('Cơm Tấm', 40000, 'Cơm tấm với sườn nướng thơm ngon', 'Món chính'),
('Gỏi Cuốn', 25000, 'Gỏi cuốn tôm thịt tươi ngon', 'Khai vị'),
('Chả Cá Lã Vọng', 60000, 'Chả cá Lã Vọng nổi tiếng Hà Nội', 'Món chính'),
('Bánh Mì Pate', 20000, 'Bánh mì pate truyền thống', 'Đồ ăn nhanh'),
('Nước Cam', 15000, 'Nước cam tươi vắt', 'Đồ uống'),
('Trà Đá', 5000, 'Trà đá giải khát', 'Đồ uống');

-- Thêm combo mẫu
INSERT INTO tblCombo (name, price, discription) VALUES
('Combo Phở Bò', 60000, 'Phở bò + Nước cam'),
('Combo Cơm Tấm', 50000, 'Cơm tấm + Trà đá'),
('Combo Bún Bò', 55000, 'Bún bò Huế + Nước cam');

-- Thêm món ăn vào combo
INSERT INTO tblComboFood (Comboid, Foodid, quantity) VALUES
(1, 1, 1), -- Phở Bò vào Combo Phở Bò
(1, 7, 1), -- Nước Cam vào Combo Phở Bò
(2, 3, 1), -- Cơm Tấm vào Combo Cơm Tấm
(2, 8, 1), -- Trà Đá vào Combo Cơm Tấm
(3, 2, 1), -- Bún Bò Huế vào Combo Bún Bò
(3, 7, 1); -- Nước Cam vào Combo Bún Bò

-- Thêm bàn ăn mẫu
INSERT INTO tblTable (name, NumberOfSeats, status) VALUES
('Bàn 1', 4, 'available'),
('Bàn 2', 2, 'available'),
('Bàn 3', 6, 'available'),
('Bàn 4', 4, 'available'),
('Bàn 5', 8, 'available'),
('Bàn 6', 2, 'available'),
('Bàn 7', 4, 'available'),
('Bàn 8', 6, 'available');

-- Thêm nhà cung cấp mẫu
INSERT INTO tblSupplier (name, address) VALUES
('Công ty Thực phẩm ABC', '123 Đường ABC, Quận 1, TP.HCM'),
('Nhà cung cấp XYZ', '456 Đường XYZ, Quận 2, TP.HCM'),
('Thực phẩm sạch DEF', '789 Đường DEF, Quận 3, TP.HCM');

-- Thêm hóa đơn nhập hàng mẫu
INSERT INTO tblImportBill (name, quantity, price, date, WarehouseStaffStaffid, WarehouseStaffStaffMemberid, Supplierid) VALUES
('Nhập thịt bò', 50, 2000000, '2024-01-15', 3, 3, 1),
('Nhập rau củ', 100, 500000, '2024-01-16', 3, 3, 2),
('Nhập gia vị', 30, 300000, '2024-01-17', 3, 3, 3);

-- Tạo view để dễ dàng truy vấn thông tin
CREATE VIEW vw_customer_info AS
SELECT 
    m.id,
    m.username,
    m.name,
    m.phoneNumber,
    m.email,
    m.dateOfBirth,
    m.address,
    c.Memberid as customer_id
FROM tblMember m
JOIN tblCustomer c ON m.id = c.Memberid;

CREATE VIEW vw_staff_info AS
SELECT 
    m.id,
    m.username,
    m.name,
    m.phoneNumber,
    m.email,
    m.dateOfBirth,
    m.address,
    s.id as staff_id,
    s.position
FROM tblMember m
JOIN tblStaff s ON m.id = s.Memberid;

CREATE VIEW vw_combo_detail AS
SELECT 
    c.id as combo_id,
    c.name as combo_name,
    c.price as combo_price,
    c.discription as combo_description,
    f.id as food_id,
    f.name as food_name,
    f.price as food_price,
    f.category as food_category,
    cf.quantity
FROM tblCombo c
LEFT JOIN tblComboFood cf ON c.id = cf.Comboid
LEFT JOIN tblFood f ON cf.Foodid = f.id;

-- Tạo stored procedures
DELIMITER //

CREATE PROCEDURE GetFoodStatistics()
BEGIN
    SELECT 
        category,
        COUNT(*) as total_foods,
        AVG(price) as avg_price,
        MIN(price) as min_price,
        MAX(price) as max_price
    FROM tblFood 
    GROUP BY category
    ORDER BY total_foods DESC;
END //

CREATE PROCEDURE GetCustomerStatistics()
BEGIN
    SELECT 
        COUNT(*) as total_customers,
        COUNT(CASE WHEN m.dateOfBirth IS NOT NULL THEN 1 END) as customers_with_birthday,
        COUNT(CASE WHEN m.phoneNumber IS NOT NULL THEN 1 END) as customers_with_phone
    FROM tblMember m
    JOIN tblCustomer c ON m.id = c.Memberid;
END //

CREATE PROCEDURE GetSupplierStatistics()
BEGIN
    SELECT 
        COUNT(*) as total_suppliers,
        SUM(ib.price) as total_import_value,
        AVG(ib.price) as avg_import_value
    FROM tblSupplier s
    LEFT JOIN tblImportBill ib ON s.id = ib.Supplierid;
END //

DELIMITER ;

-- Tạo triggers để tự động cập nhật thời gian
DELIMITER //

CREATE TRIGGER tr_member_updated 
BEFORE UPDATE ON tblMember
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

CREATE TRIGGER tr_food_updated 
BEFORE UPDATE ON tblFood
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

CREATE TRIGGER tr_combo_updated 
BEFORE UPDATE ON tblCombo
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //

DELIMITER ;

-- Tạo user cho ứng dụng
CREATE USER IF NOT EXISTS 'restman_user'@'localhost' IDENTIFIED BY 'restman_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON restman_db.* TO 'restman_user'@'localhost';
FLUSH PRIVILEGES;

-- Hiển thị thông tin database
SELECT 'Database RestMan đã được tạo thành công!' as message;
SELECT COUNT(*) as total_tables FROM information_schema.tables WHERE table_schema = 'restman_db';
SELECT COUNT(*) as total_foods FROM tblFood;
SELECT COUNT(*) as total_combos FROM tblCombo;
SELECT COUNT(*) as total_customers FROM tblCustomer;
SELECT COUNT(*) as total_staff FROM tblStaff;
