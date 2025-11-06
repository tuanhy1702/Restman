package com.restman.entity;

/**
 * Entity class đại diện cho hóa đơn
 */
public class Bill {
    private int id;
    private String date;
    private float price;
    private String status;
    private int customerMemberId;
    private int saleStaffStaffId;
    private int saleStaffStaffMemberId;
    
    // Constructors
    public Bill() {}
    
    public Bill(int id, String date, float price, String status, 
                int customerMemberId, int saleStaffStaffId, int saleStaffStaffMemberId) {
        this.id = id;
        this.date = date;
        this.price = price;
        this.status = status;
        this.customerMemberId = customerMemberId;
        this.saleStaffStaffId = saleStaffStaffId;
        this.saleStaffStaffMemberId = saleStaffStaffMemberId;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getDate() {
        return date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public float getPrice() {
        return price;
    }
    
    public void setPrice(float price) {
        this.price = price;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public int getCustomerMemberId() {
        return customerMemberId;
    }
    
    public void setCustomerMemberId(int customerMemberId) {
        this.customerMemberId = customerMemberId;
    }
    
    public int getSaleStaffStaffId() {
        return saleStaffStaffId;
    }
    
    public void setSaleStaffStaffId(int saleStaffStaffId) {
        this.saleStaffStaffId = saleStaffStaffId;
    }
    
    public int getSaleStaffStaffMemberId() {
        return saleStaffStaffMemberId;
    }
    
    public void setSaleStaffStaffMemberId(int saleStaffStaffMemberId) {
        this.saleStaffStaffMemberId = saleStaffStaffMemberId;
    }
    
    @Override
    public String toString() {
        return "Bill{" +
                "id=" + id +
                ", date='" + date + '\'' +
                ", price=" + price +
                ", status='" + status + '\'' +
                ", customerMemberId=" + customerMemberId +
                ", saleStaffStaffId=" + saleStaffStaffId +
                '}';
    }
}
