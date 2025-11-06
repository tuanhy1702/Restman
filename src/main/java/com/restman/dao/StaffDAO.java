package com.restman.dao;

import com.restman.entity.Manager;
import com.restman.entity.SaleStaff;
import com.restman.entity.WarehouseStaff;
import java.sql.*;
import java.util.logging.Logger;

/**
 * DAO class để thao tác với bảng Staff và các bảng con
 */
public class StaffDAO extends DAO {
    private static final Logger logger = Logger.getLogger(StaffDAO.class.getName());
    
    public StaffDAO() {
        super();
    }
    
    /**
     * Đăng nhập nhân viên quản lý
     */
    public Manager loginManager(String username, String password) {
        String sql = "SELECT m.*, s.id as staff_id, s.position " +
                    "FROM tblMember m " +
                    "JOIN tblStaff s ON m.id = s.Memberid " +
                    "JOIN tblManager mg ON s.id = mg.Staffid " +
                    "WHERE m.username = ? AND m.password = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Manager manager = new Manager();
                manager.setId(rs.getInt("id"));
                manager.setUsername(rs.getString("username"));
                manager.setPassword(rs.getString("password"));
                manager.setName(rs.getString("name"));
                manager.setPhoneNumber(rs.getString("phoneNumber"));
                manager.setEmail(rs.getString("email"));
                manager.setDateOfBirth(rs.getString("dateOfBirth"));
                manager.setAddress(rs.getString("address"));
                manager.setStaffId(rs.getInt("staff_id"));
                manager.setPosition(rs.getString("position"));
                return manager;
            }
        } catch (SQLException e) {
            logger.severe("Error during manager login: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Đăng nhập nhân viên bán hàng
     */
    public SaleStaff loginSaleStaff(String username, String password) {
        String sql = "SELECT m.*, s.id as staff_id, s.position, ss.MembershipCardid " +
                    "FROM tblMember m " +
                    "JOIN tblStaff s ON m.id = s.Memberid " +
                    "JOIN tblSaleStaff ss ON s.id = ss.Staffid " +
                    "WHERE m.username = ? AND m.password = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                SaleStaff saleStaff = new SaleStaff();
                saleStaff.setId(rs.getInt("id"));
                saleStaff.setUsername(rs.getString("username"));
                saleStaff.setPassword(rs.getString("password"));
                saleStaff.setName(rs.getString("name"));
                saleStaff.setPhoneNumber(rs.getString("phoneNumber"));
                saleStaff.setEmail(rs.getString("email"));
                saleStaff.setDateOfBirth(rs.getString("dateOfBirth"));
                saleStaff.setAddress(rs.getString("address"));
                saleStaff.setStaffId(rs.getInt("staff_id"));
                saleStaff.setPosition(rs.getString("position"));
                saleStaff.setMembershipCardId(rs.getInt("MembershipCardid"));
                return saleStaff;
            }
        } catch (SQLException e) {
            logger.severe("Error during sale staff login: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Đăng nhập nhân viên kho
     */
    public WarehouseStaff loginWarehouseStaff(String username, String password) {
        String sql = "SELECT m.*, s.id as staff_id, s.position " +
                    "FROM tblMember m " +
                    "JOIN tblStaff s ON m.id = s.Memberid " +
                    "JOIN tblWarehouseStaff ws ON s.id = ws.Staffid " +
                    "WHERE m.username = ? AND m.password = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                WarehouseStaff warehouseStaff = new WarehouseStaff();
                warehouseStaff.setId(rs.getInt("id"));
                warehouseStaff.setUsername(rs.getString("username"));
                warehouseStaff.setPassword(rs.getString("password"));
                warehouseStaff.setName(rs.getString("name"));
                warehouseStaff.setPhoneNumber(rs.getString("phoneNumber"));
                warehouseStaff.setEmail(rs.getString("email"));
                warehouseStaff.setDateOfBirth(rs.getString("dateOfBirth"));
                warehouseStaff.setAddress(rs.getString("address"));
                warehouseStaff.setStaffId(rs.getInt("staff_id"));
                warehouseStaff.setPosition(rs.getString("position"));
                return warehouseStaff;
            }
        } catch (SQLException e) {
            logger.severe("Error during warehouse staff login: " + e.getMessage());
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
