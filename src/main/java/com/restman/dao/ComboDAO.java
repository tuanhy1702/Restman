package com.restman.dao;

import com.restman.entity.Combo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * DAO class để thao tác với bảng Combo
 */
public class ComboDAO extends DAO {
    private static final Logger logger = Logger.getLogger(ComboDAO.class.getName());
    
    public ComboDAO() {
        super();
    }
    
    /**
     * Lấy tất cả combo
     */
    public List<Combo> getCombo() {
        List<Combo> combos = new ArrayList<>();
        String sql = "SELECT * FROM tblCombo ORDER BY name";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Combo combo = new Combo();
                combo.setId(rs.getInt("id"));
                combo.setName(rs.getString("name"));
                combo.setPrice(rs.getFloat("price"));
                combo.setDescription(rs.getString("discription"));
                combos.add(combo);
            }
        } catch (SQLException e) {
            logger.severe("Error getting all combos: " + e.getMessage());
            e.printStackTrace();
        }
        
        return combos;
    }
    
    /**
     * Lưu combo mới
     */
    public boolean setCombo(Combo combo) {
        String sql = "INSERT INTO tblCombo (name, price, discription) VALUES (?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, combo.getName());
            ps.setFloat(2, combo.getPrice());
            ps.setString(3, combo.getDescription());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    combo.setId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            logger.severe("Error adding combo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    

}
