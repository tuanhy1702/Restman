# RestMan - Restaurant Management System

## Mô tả dự án
Hệ thống quản lý nhà hàng RestMan cho phép quản lý toàn diện các hoạt động của nhà hàng bao gồm:
- Quản lý thông tin món ăn và combo
- Quản lý khách hàng và nhân viên
- Xử lý đơn hàng và thanh toán
- Quản lý nhà cung cấp và nguyên liệu
- Thống kê và báo cáo

## Công nghệ sử dụng
- **Backend**: Java 8, Servlet, JSP
- **Database**: MySQL 8.0
- **Web Server**: Apache Tomcat 8
- **Build Tool**: Maven
- **Frontend**: HTML, CSS, JavaScript, Bootstrap

## Kiến trúc hệ thống
Hệ thống được thiết kế theo mô hình MVC (Model-View-Controller):
- **Model**: Entity classes (Food, Combo, Customer, Staff, etc.)
- **View**: JSP pages
- **Controller**: Servlet classes
- **Data Access**: DAO pattern

## Cấu trúc thư mục
```
src/
├── main/
│   ├── java/
│   │   └── com/restman/
│   │       ├── entity/          # Entity classes
│   │       ├── dao/             # Data Access Objects
│   │       ├── servlet/         # Servlet controllers
│   │       ├── util/            # Utility classes
│   │       └── config/          # Configuration classes
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml         # Web configuration
│       │   └── lib/            # JAR dependencies
│       ├── css/                # CSS stylesheets
│       ├── js/                 # JavaScript files
│       ├── images/             # Images
│       └── views/              # JSP pages
└── test/
    └── java/                   # Test classes
```

## Cài đặt và chạy
1. Cài đặt Java 8, Maven, MySQL 8.0, Apache Tomcat 8
2. Clone repository và build project: `mvn clean package`
3. Deploy file WAR vào Tomcat
4. Cấu hình database connection trong `config/database.properties`
5. Chạy script SQL để tạo database và tables
6. Truy cập ứng dụng qua browser

## Chức năng chính
### Nhân viên quản lý
- Xem thống kê món ăn, nguyên liệu, khách hàng, nhà cung cấp
- Quản lý thông tin món ăn
- Tạo và quản lý menu combo

### Nhân viên kho
- Nhập nguyên liệu từ nhà cung cấp
- Quản lý thông tin nhà cung cấp

### Nhân viên bán hàng
- Nhận khách và xử lý đơn hàng
- Thanh toán tại bàn
- Làm thẻ thành viên cho khách hàng
- Xác nhận đặt bàn và đặt món trực tuyến

### Khách hàng
- Tìm kiếm thông tin món ăn
- Đặt bàn và đặt món trực tuyến
