package com.restman.entity;

/**
 * Entity class đại diện cho bàn ăn
 */
public class Table {
    private int id;
    private String name;
    private int numberOfSeats;
    private String status;
    private int billId;
    
    // Constructors
    public Table() {}
    
    public Table(int id, String name, int numberOfSeats, String status, int billId) {
        this.id = id;
        this.name = name;
        this.numberOfSeats = numberOfSeats;
        this.status = status;
        this.billId = billId;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getNumberOfSeats() {
        return numberOfSeats;
    }
    
    public void setNumberOfSeats(int numberOfSeats) {
        this.numberOfSeats = numberOfSeats;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getBillId() {
        return billId;
    }
    
    public void setBillId(int billId) {
        this.billId = billId;
    }
    
    @Override
    public String toString() {
        return "Table{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", numberOfSeats=" + numberOfSeats +
                ", status='" + status + '\'' +
                ", billId=" + billId +
                '}';
    }
}
