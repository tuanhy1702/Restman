package com.restman.entity;

public class DetailImportBill {
    private int id;
    private int quantity;
    private int price;
    private Ingredient ingredient;
    private ImportBill importBill;

    public DetailImportBill(ImportBill importBill, Ingredient ingredient, int price, int quantity, int id) {
        this.importBill = importBill;
        this.ingredient = ingredient;
        this.price = price;
        this.quantity = quantity;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public ImportBill getImportBill() {
        return importBill;
    }

    public void setImportBill(ImportBill importBill) {
        this.importBill = importBill;
    }
}
