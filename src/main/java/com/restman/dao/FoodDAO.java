package com.restman.dao;

import com.restman.entity.Food;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * DAO class để thao tác với bảng Food
 */
public class FoodDAO extends DAO {
    private static final Logger logger = Logger.getLogger(FoodDAO.class.getName());
    
    public FoodDAO() {
        super();
    }
    
    /**
     * Tìm kiếm món ăn theo tên
     */
    public List<Food> searchFoodByName(String name) {
        List<Food> foods = new ArrayList<>();
        String sql = "SELECT * FROM tblFood WHERE name LIKE ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Food food = new Food();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setDescription(rs.getString("discription"));
                food.setCategory(rs.getString("category"));
                foods.add(food);
            }
        } catch (SQLException e) {
            logger.severe("Error searching food by name: " + e.getMessage());
            e.printStackTrace();
        }
        
        return foods;
    }
    
    /**
     * Tìm kiếm món ăn theo thể loại
     */
    public List<Food> searchFoodByCategory(String category) {
        List<Food> foods = new ArrayList<>();
        String sql = "SELECT * FROM tblFood WHERE category LIKE ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + category + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Food food = new Food();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setDescription(rs.getString("discription"));
                food.setCategory(rs.getString("category"));
                foods.add(food);
            }
        } catch (SQLException e) {
            logger.severe("Error searching food by category: " + e.getMessage());
            e.printStackTrace();
        }
        
        return foods;
    }

    
    
    /**
     * Lấy tất cả món ăn
     */
    public List<Food> getAllFoods() {
        List<Food> foods = new ArrayList<>();
        String sql = "SELECT * FROM tblFood ORDER BY name";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Food food = new Food();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setDescription(rs.getString("discription"));
                food.setCategory(rs.getString("category"));
                foods.add(food);
            }
        } catch (SQLException e) {
            logger.severe("Error getting all foods: " + e.getMessage());
            e.printStackTrace();
        }
        
        return foods;
    }
    
    /**
     * Lấy món ăn theo ID
     */
    public Food getFoodById(int id) {
        String sql = "SELECT * FROM tblFood WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Food food = new Food();
                food.setId(rs.getInt("id"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getFloat("price"));
                food.setDescription(rs.getString("discription"));
                food.setCategory(rs.getString("category"));
                return food;
            }
        } catch (SQLException e) {
            logger.severe("Error getting food by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    
    
    
    
    
}
