package com.restman.entity;

/**
 * Entity class đại diện cho mối quan hệ giữa Combo và Food
 * Chứa thông tin về số lượng món ăn trong combo
 */
public class ComboFood {
    private int id;
    private int comboId;
    private int foodId;
    private int quantity;
    
    // Thêm các object để dễ dàng truy cập thông tin
    private Combo combo;
    private Food food;
    
    // Constructors
    public ComboFood() {}
    
    public ComboFood(int id, int comboId, int foodId, int quantity) {
        this.id = id;
        this.comboId = comboId;
        this.foodId = foodId;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getComboId() {
        return comboId;
    }
    
    public void setComboId(int comboId) {
        this.comboId = comboId;
    }
    
    public int getFoodId() {
        return foodId;
    }
    
    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public Combo getCombo() {
        return combo;
    }
    
    public void setCombo(Combo combo) {
        this.combo = combo;
    }
    
    public Food getFood() {
        return food;
    }
    
    public void setFood(Food food) {
        this.food = food;
    }
    
    @Override
    public String toString() {
        return "ComboFood{" +
                "id=" + id +
                ", comboId=" + comboId +
                ", foodId=" + foodId +
                ", quantity=" + quantity +
                '}';
    }
}
