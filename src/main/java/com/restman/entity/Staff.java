package com.restman.entity;

/**
 * Entity class đại diện cho nhân viên
 */
public class Staff extends Member {
    private int staffId;
    private String position;
    
    // Constructors
    public Staff() {}
    
    public Staff(int id, String username, String password, String name, 
                 String phoneNumber, String email, String dateOfBirth, String address,
                 int staffId, String position) {
        super(id, username, password, name, phoneNumber, email, dateOfBirth, address);
        this.staffId = staffId;
        this.position = position;
    }
    
    // Getters and Setters
    public int getStaffId() {
        return staffId;
    }
    
    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }
    
    public String getPosition() {
        return position;
    }
    
    public void setPosition(String position) {
        this.position = position;
    }
    
    @Override
    public String toString() {
        return "Staff{" +
                "staffId=" + staffId +
                ", position='" + position + '\'' +
                ", " + super.toString() +
                '}';
    }
}
