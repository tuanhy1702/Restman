package com.restman.entity;

/**
 * Entity class đại diện cho nhân viên bán hàng
 */
public class SaleStaff extends Staff {
    private int membershipCardId;
    
    // Constructors
    public SaleStaff() {}
    
    public SaleStaff(int id, String username, String password, String name, 
                     String phoneNumber, String email, String dateOfBirth, String address,
                     int staffId, String position, int membershipCardId) {
        super(id, username, password, name, phoneNumber, email, dateOfBirth, address, staffId, position);
        this.membershipCardId = membershipCardId;
    }
    
    // Getters and Setters
    public int getMembershipCardId() {
        return membershipCardId;
    }
    
    public void setMembershipCardId(int membershipCardId) {
        this.membershipCardId = membershipCardId;
    }
    
    @Override
    public String toString() {
        return "SaleStaff{" +
                "membershipCardId=" + membershipCardId +
                ", " + super.toString() +
                '}';
    }
}
