package com.restman.entity;

/**
 * Entity class đại diện cho khách hàng
 */
public class Customer extends Member {
    private int customerId;
    
    // Constructors
    public Customer() {}
    
    public Customer(int id, String username, String password, String name, 
                    String phoneNumber, String email, String dateOfBirth, String address,
                    int customerId) {
        super(id, username, password, name, phoneNumber, email, dateOfBirth, address);
        this.customerId = customerId;
    }
    
    // Getters and Setters
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerId +
                ", " + super.toString() +
                '}';
    }
}
