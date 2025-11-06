package com.restman.dao;

import com.restman.entity.ComboFood;
import com.restman.entity.Food;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * DAO class để thao tác với bảng ComboFood
 */
public class ComboFoodDAO extends DAO {
    private static final Logger logger = Logger.getLogger(ComboFoodDAO.class.getName());
    
    public ComboFoodDAO() {
        super();
    }
    
    /**
     * Thêm món ăn vào combo
     */
    public boolean addFoodToCombo(int comboId, int foodId, int quantity) {
        String sql = "INSERT INTO tblComboFood (Comboid, Foodid, quantity) VALUES (?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            ps.setInt(2, foodId);
            ps.setInt(3, quantity);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            logger.severe("Error adding food to combo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Lấy danh sách món ăn trong combo
     */
    public List<ComboFood> getFoodsByComboId(int comboId) {
        List<ComboFood> comboFoods = new ArrayList<>();
        String sql = "SELECT cf.*, f.name as food_name, f.price as food_price, f.discription as food_description, f.category " +
                    "FROM tblComboFood cf " +
                    "JOIN tblFood f ON cf.Foodid = f.id " +
                    "WHERE cf.Comboid = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ComboFood comboFood = new ComboFood();
                comboFood.setId(rs.getInt("id"));
                comboFood.setComboId(rs.getInt("Comboid"));
                comboFood.setFoodId(rs.getInt("Foodid"));
                comboFood.setQuantity(rs.getInt("quantity"));
                
                // Tạo Food object
                Food food = new Food();
                food.setId(rs.getInt("Foodid"));
                food.setName(rs.getString("food_name"));
                food.setPrice(rs.getFloat("food_price"));
                food.setDescription(rs.getString("food_description"));
                food.setCategory(rs.getString("category"));
                comboFood.setFood(food);
                
                comboFoods.add(comboFood);
            }
        } catch (SQLException e) {
            logger.severe("Error getting foods by combo ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return comboFoods;
    }
    
    /**
     * Xóa món ăn khỏi combo
     */
    public boolean removeFoodFromCombo(int comboId, int foodId) {
        String sql = "DELETE FROM tblComboFood WHERE Comboid = ? AND Foodid = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            ps.setInt(2, foodId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            logger.severe("Error removing food from combo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Cập nhật số lượng món ăn trong combo
     */
    public boolean updateFoodQuantityInCombo(int comboId, int foodId, int quantity) {
        String sql = "UPDATE tblComboFood SET quantity = ? WHERE Comboid = ? AND Foodid = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, comboId);
            ps.setInt(3, foodId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            logger.severe("Error updating food quantity in combo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Xóa tất cả món ăn khỏi combo
     */
    public boolean removeAllFoodsFromCombo(int comboId) {
        String sql = "DELETE FROM tblComboFood WHERE Comboid = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, comboId);
            int affectedRows = ps.executeUpdate();
            return affectedRows >= 0; // >= 0 vì có thể combo chưa có món nào
        } catch (SQLException e) {
            logger.severe("Error removing all foods from combo: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}
