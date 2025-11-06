package com.restman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

/**
 * Base DAO class để quản lý kết nối database
 */
public class DAO {
    private static final Logger logger = Logger.getLogger(DAO.class.getName());
    protected Connection con;
    
    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restman_db?useSSL=false&serverTimezone=UTC&characterEncoding=utf8";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456789";
    
    public DAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            logger.info("Database connection established successfully");
        } catch (ClassNotFoundException | SQLException e) {
            logger.severe("Error establishing database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Đóng kết nối database
     */
    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                logger.info("Database connection closed");
            }
        } catch (SQLException e) {
            logger.severe("Error closing database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Lấy kết nối database
     */
    public Connection getConnection() {
        return con;
    }
}
