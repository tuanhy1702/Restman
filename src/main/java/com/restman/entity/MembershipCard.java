package com.restman.entity;

/**
 * Entity class đại diện cho thẻ thành viên
 */
public class MembershipCard {
    private int id;
    private String name;
    private int points;
    private String date;
    private int customerMemberId;
    
    // Constructors
    public MembershipCard() {}
    
    public MembershipCard(int id, String name, int points, String date, int customerMemberId) {
        this.id = id;
        this.name = name;
        this.points = points;
        this.date = date;
        this.customerMemberId = customerMemberId;
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
    
    public int getPoints() {
        return points;
    }
    
    public void setPoints(int points) {
        this.points = points;
    }
    
    public String getDate() {
        return date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public int getCustomerMemberId() {
        return customerMemberId;
    }
    
    public void setCustomerMemberId(int customerMemberId) {
        this.customerMemberId = customerMemberId;
    }
    
    @Override
    public String toString() {
        return "MembershipCard{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", points=" + points +
                ", date='" + date + '\'' +
                ", customerMemberId=" + customerMemberId +
                '}';
    }
}
