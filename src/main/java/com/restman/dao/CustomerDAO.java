package com.restman.dao;

import com.restman.entity.Customer;
import java.sql.*;
import java.util.logging.Logger;

/**
 * DAO class để thao tác với bảng Customer
 */
public class CustomerDAO extends DAO {
    private static final Logger logger = Logger.getLogger(CustomerDAO.class.getName());
    
    public CustomerDAO() {
        super();
    }
    
    /**
     * Đăng nhập khách hàng
     */
    public Customer login(String username, String password) {
        String sql = "SELECT m.*, c.Memberid as customer_id " +
                    "FROM tblMember m " +
                    "JOIN tblCustomer c ON m.id = c.Memberid " +
                    "WHERE m.username = ? AND m.password = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setPassword(rs.getString("password"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setEmail(rs.getString("email"));
                customer.setDateOfBirth(rs.getString("dateOfBirth"));
                customer.setAddress(rs.getString("address"));
                customer.setCustomerId(rs.getInt("customer_id"));
                return customer;
            }
        } catch (SQLException e) {
            logger.severe("Error during customer login: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Đăng ký khách hàng mới
     */
    public boolean register(Customer customer) {
        Connection conn = null;
        try {
            conn = con;
            conn.setAutoCommit(false);
            
            // Thêm vào tblMember
            String memberSql = "INSERT INTO tblMember (username, password, name, phoneNumber, email, dateOfBirth, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement memberPs = conn.prepareStatement(memberSql, Statement.RETURN_GENERATED_KEYS);
            memberPs.setString(1, customer.getUsername());
            memberPs.setString(2, customer.getPassword());
            memberPs.setString(3, customer.getName());
            memberPs.setString(4, customer.getPhoneNumber());
            memberPs.setString(5, customer.getEmail());
            memberPs.setString(6, customer.getDateOfBirth());
            memberPs.setString(7, customer.getAddress());
            
            int memberRows = memberPs.executeUpdate();
            if (memberRows <= 0) {
                conn.rollback();
                return false;
            }
            
            ResultSet generatedKeys = memberPs.getGeneratedKeys();
            int memberId = 0;
            if (generatedKeys.next()) {
                memberId = generatedKeys.getInt(1);
            }
            
            // Thêm vào tblCustomer
            String customerSql = "INSERT INTO tblCustomer (Memberid) VALUES (?)";
            PreparedStatement customerPs = conn.prepareStatement(customerSql);
            customerPs.setInt(1, memberId);
            
            int customerRows = customerPs.executeUpdate();
            if (customerRows <= 0) {
                conn.rollback();
                return false;
            }
            
            conn.commit();
            customer.setId(memberId);
            return true;
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                logger.severe("Error during rollback: " + rollbackEx.getMessage());
            }
            logger.severe("Error during customer registration: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException e) {
                logger.severe("Error resetting auto commit: " + e.getMessage());
            }
        }
        
        return false;
    }
    
    /**
     * Lấy thông tin khách hàng theo ID
     */
    public Customer getCustomerById(int id) {
        String sql = "SELECT m.*, c.Memberid as customer_id " +
                    "FROM tblMember m " +
                    "JOIN tblCustomer c ON m.id = c.Memberid " +
                    "WHERE m.id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setUsername(rs.getString("username"));
                customer.setPassword(rs.getString("password"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setEmail(rs.getString("email"));
                customer.setDateOfBirth(rs.getString("dateOfBirth"));
                customer.setAddress(rs.getString("address"));
                customer.setCustomerId(rs.getInt("customer_id"));
                return customer;
            }
        } catch (SQLException e) {
            logger.severe("Error getting customer by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Kiểm tra username đã tồn tại chưa
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM tblMember WHERE username = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            logger.severe("Error checking username existence: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}
