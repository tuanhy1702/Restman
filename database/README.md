# RestMan Database Configuration

## Database Connection Settings

### MySQL Configuration
- **Database Name**: restman_db
- **Host**: localhost
- **Port**: 3306
- **Username**: restman_user
- **Password**: restman_password
- **Character Set**: utf8mb4
- **Collation**: utf8mb4_unicode_ci

### Connection URL
```
jdbc:mysql://localhost:3306/restman_db?useSSL=false&serverTimezone=UTC&characterEncoding=utf8
```

## Installation Instructions

### 1. Install MySQL 8.0
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install mysql-server

# CentOS/RHEL
sudo yum install mysql-server

# Windows
# Download from https://dev.mysql.com/downloads/mysql/
```

### 2. Start MySQL Service
```bash
# Linux
sudo systemctl start mysql
sudo systemctl enable mysql

# Windows
# Start MySQL service from Services.msc
```

### 3. Create Database and User
```sql
-- Login as root
mysql -u root -p

-- Create database
CREATE DATABASE restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user
CREATE USER 'restman_user'@'localhost' IDENTIFIED BY 'restman_password';

-- Grant privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON restman_db.* TO 'restman_user'@'localhost';
FLUSH PRIVILEGES;
```

### 4. Import Schema
```bash
mysql -u restman_user -p restman_db < database/restman_schema.sql
```

## Default Accounts

### Administrator
- **Username**: admin
- **Password**: admin123
- **Role**: Manager

### Sale Staff
- **Username**: salestaff1
- **Password**: staff123
- **Role**: Sale Staff

### Warehouse Staff
- **Username**: warehouse1
- **Password**: warehouse123
- **Role**: Warehouse Staff

### Customer
- **Username**: customer1
- **Password**: customer123
- **Role**: Customer

## Database Schema Overview

### Core Tables
- `tblMember` - Base user information
- `tblStaff` - Staff information
- `tblCustomer` - Customer information
- `tblManager` - Manager information
- `tblSaleStaff` - Sales staff information
- `tblWarehouseStaff` - Warehouse staff information

### Menu Tables
- `tblFood` - Food items
- `tblCombo` - Combo meals
- `tblComboFood` - Food items in combos

### Order Tables
- `tblBill` - Orders/bills
- `tblTable` - Restaurant tables
- `tblFoodOrder` - Food items in orders
- `tblOrderCombo` - Combos in orders

### Inventory Tables
- `tblSupplier` - Suppliers
- `tblImportBill` - Import bills
- `tblMembershipCard` - Customer membership cards

## Views and Procedures

### Views
- `vw_customer_info` - Customer information view
- `vw_staff_info` - Staff information view
- `vw_combo_detail` - Combo details view

### Stored Procedures
- `GetFoodStatistics()` - Food statistics
- `GetCustomerStatistics()` - Customer statistics
- `GetSupplierStatistics()` - Supplier statistics

## Backup and Restore

### Backup Database
```bash
mysqldump -u restman_user -p restman_db > restman_backup.sql
```

### Restore Database
```bash
mysql -u restman_user -p restman_db < restman_backup.sql
```

## Performance Optimization

### Indexes
- Primary keys on all tables
- Foreign key indexes
- Search indexes on frequently queried columns

### Configuration Recommendations
```ini
# MySQL Configuration (my.cnf)
[mysqld]
innodb_buffer_pool_size = 256M
innodb_log_file_size = 64M
max_connections = 200
query_cache_size = 32M
```

## Troubleshooting

### Common Issues

1. **Connection Refused**
   - Check MySQL service status
   - Verify port 3306 is open
   - Check firewall settings

2. **Access Denied**
   - Verify username/password
   - Check user privileges
   - Ensure user exists

3. **Character Encoding Issues**
   - Verify database charset is utf8mb4
   - Check connection URL parameters
   - Ensure table charset is correct

### Log Files
- **Error Log**: `/var/log/mysql/error.log` (Linux)
- **General Log**: `/var/log/mysql/mysql.log` (Linux)
- **Windows**: Check MySQL installation directory logs

## Security Considerations

1. **Change Default Passwords**
2. **Use Strong Passwords**
3. **Limit User Privileges**
4. **Enable SSL Connections**
5. **Regular Security Updates**
6. **Backup Regularly**

## Monitoring

### Key Metrics to Monitor
- Connection count
- Query performance
- Disk usage
- Memory usage
- Error rates

### Useful Queries
```sql
-- Check active connections
SHOW PROCESSLIST;

-- Check database size
SELECT 
    table_schema AS 'Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables 
WHERE table_schema = 'restman_db'
GROUP BY table_schema;

-- Check table sizes
SELECT 
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.tables 
WHERE table_schema = 'restman_db'
ORDER BY (data_length + index_length) DESC;
```
