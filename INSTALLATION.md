# Hướng dẫn cài đặt và chạy hệ thống RestMan

## Yêu cầu hệ thống

### Phần mềm cần thiết
- **Java 8** hoặc cao hơn
- **Maven 3.6+**
- **MySQL 8.0**
- **Apache Tomcat 8.5+**
- **Git** (để clone repository)

### Cấu hình tối thiểu
- **RAM**: 4GB
- **Ổ cứng**: 2GB trống
- **OS**: Windows 10+, Ubuntu 18.04+, macOS 10.14+

## Cài đặt từng bước

### 1. Cài đặt Java
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-8-jdk

# CentOS/RHEL
sudo yum install java-1.8.0-openjdk-devel

# Windows
# Tải từ https://www.oracle.com/java/technologies/javase-downloads.html
```

Kiểm tra cài đặt:
```bash
java -version
javac -version
```

### 2. Cài đặt Maven
```bash
# Ubuntu/Debian
sudo apt install maven

# CentOS/RHEL
sudo yum install maven

# Windows
# Tải từ https://maven.apache.org/download.cgi
```

Kiểm tra cài đặt:
```bash
mvn -version
```

### 3. Cài đặt MySQL
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install mysql-server

# CentOS/RHEL
sudo yum install mysql-server

# Windows
# Tải từ https://dev.mysql.com/downloads/mysql/
```

Khởi động MySQL:
```bash
# Linux
sudo systemctl start mysql
sudo systemctl enable mysql

# Windows
# Khởi động từ Services.msc
```

### 4. Cài đặt Apache Tomcat
```bash
# Ubuntu/Debian
sudo apt install tomcat8

# CentOS/RHEL
sudo yum install tomcat

# Windows
# Tải từ https://tomcat.apache.org/download-80.cgi
```

## Cấu hình Database

### 1. Tạo database và user
```sql
-- Đăng nhập MySQL
mysql -u root -p

-- Tạo database
CREATE DATABASE restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Tạo user
CREATE USER 'restman_user'@'localhost' IDENTIFIED BY 'restman_password';

-- Cấp quyền
GRANT SELECT, INSERT, UPDATE, DELETE ON restman_db.* TO 'restman_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Import schema
```bash
mysql -u restman_user -p restman_db < database/restman_schema.sql
```

### 3. Kiểm tra dữ liệu
```sql
USE restman_db;
SHOW TABLES;
SELECT COUNT(*) FROM tblFood;
SELECT COUNT(*) FROM tblCombo;
```

## Build và Deploy ứng dụng

### 1. Clone repository
```bash
git clone <repository-url>
cd RestMan
```

### 2. Build project
```bash
mvn clean package
```

### 3. Deploy lên Tomcat
```bash
# Copy file WAR vào thư mục webapps của Tomcat
cp target/restman.war $TOMCAT_HOME/webapps/

# Hoặc sử dụng Tomcat Manager
# Truy cập http://localhost:8080/manager/html
# Upload file restman.war
```

### 4. Khởi động Tomcat
```bash
# Linux
sudo systemctl start tomcat8

# Windows
# Khởi động từ Services.msc hoặc startup.bat
```

## Cấu hình ứng dụng

### 1. Cấu hình database connection
Chỉnh sửa file `src/main/resources/config.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/restman_db?useSSL=false&serverTimezone=UTC
db.username=restman_user
db.password=restman_password
```

### 2. Cấu hình Tomcat
Chỉnh sửa file `$TOMCAT_HOME/conf/server.xml`:
```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           URIEncoding="UTF-8" />
```

## Kiểm tra cài đặt

### 1. Truy cập ứng dụng
Mở trình duyệt và truy cập:
```
http://localhost:8080/restman
```

### 2. Đăng nhập với tài khoản mặc định
- **Manager**: admin / admin123
- **Sale Staff**: salestaff1 / staff123
- **Warehouse Staff**: warehouse1 / warehouse123
- **Customer**: customer1 / customer123

### 3. Kiểm tra các chức năng
- Đăng nhập/đăng xuất
- Tìm kiếm món ăn
- Quản lý combo
- Xem thống kê

## Troubleshooting

### Lỗi kết nối database
```
Error: Could not create connection to database server
```
**Giải pháp:**
1. Kiểm tra MySQL đã khởi động chưa
2. Kiểm tra username/password
3. Kiểm tra database đã tồn tại chưa
4. Kiểm tra firewall

### Lỗi encoding
```
Error: Incorrect string value
```
**Giải pháp:**
1. Kiểm tra database charset là utf8mb4
2. Kiểm tra connection URL có characterEncoding=utf8
3. Kiểm tra JSP pageEncoding="UTF-8"

### Lỗi 404 Not Found
```
Error: The requested resource is not available
```
**Giải pháp:**
1. Kiểm tra WAR file đã deploy đúng chưa
2. Kiểm tra context path
3. Kiểm tra Tomcat logs

### Lỗi ClassNotFoundException
```
Error: ClassNotFoundException: com.mysql.cj.jdbc.Driver
```
**Giải pháp:**
1. Kiểm tra MySQL Connector JAR trong classpath
2. Kiểm tra Maven dependencies
3. Rebuild project

## Logs và Monitoring

### 1. Tomcat Logs
```bash
# Linux
tail -f $TOMCAT_HOME/logs/catalina.out

# Windows
# Kiểm tra thư mục logs trong Tomcat installation
```

### 2. Application Logs
```bash
# Kiểm tra logs của ứng dụng
tail -f $TOMCAT_HOME/logs/restman.log
```

### 3. Database Logs
```bash
# MySQL error log
tail -f /var/log/mysql/error.log
```

## Backup và Restore

### 1. Backup Database
```bash
mysqldump -u restman_user -p restman_db > restman_backup_$(date +%Y%m%d).sql
```

### 2. Backup Application
```bash
# Backup WAR file
cp $TOMCAT_HOME/webapps/restman.war backup/restman_$(date +%Y%m%d).war

# Backup configuration
cp -r $TOMCAT_HOME/conf backup/conf_$(date +%Y%m%d)
```

### 3. Restore
```bash
# Restore database
mysql -u restman_user -p restman_db < restman_backup_20240101.sql

# Restore application
cp backup/restman_20240101.war $TOMCAT_HOME/webapps/restman.war
```

## Performance Tuning

### 1. JVM Settings
Thêm vào `$TOMCAT_HOME/bin/setenv.sh`:
```bash
export CATALINA_OPTS="-Xms512m -Xmx1024m -XX:+UseG1GC"
```

### 2. Database Optimization
```sql
-- Tối ưu database
OPTIMIZE TABLE tblFood, tblCombo, tblMember;

-- Kiểm tra indexes
SHOW INDEX FROM tblFood;
```

### 3. Connection Pool
Chỉnh sửa `config.properties`:
```properties
db.pool.maxActive=50
db.pool.maxIdle=20
db.pool.minIdle=10
```

## Security

### 1. Change Default Passwords
```sql
-- Thay đổi password mặc định
UPDATE tblMember SET password = 'new_password' WHERE username = 'admin';
```

### 2. Enable HTTPS
Chỉnh sửa `$TOMCAT_HOME/conf/server.xml`:
```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/keystore.p12"
                     certificateKeystorePassword="changeit"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

### 3. Firewall Configuration
```bash
# Chỉ cho phép truy cập từ IP cụ thể
sudo ufw allow from 192.168.1.0/24 to any port 8080
sudo ufw allow from 192.168.1.0/24 to any port 3306
```

## Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra logs
2. Xem troubleshooting guide
3. Liên hệ support team
4. Tạo issue trên GitHub

**Email**: support@restman.com  
**Documentation**: https://docs.restman.com  
**GitHub**: https://github.com/restman/restman
