package com.restman.entity;

/**
 * Entity class đại diện cho nhân viên kho
 */
public class WarehouseStaff extends Staff {
    
    // Constructors
    public WarehouseStaff() {}
    
    public WarehouseStaff(int id, String username, String password, String name, 
                         String phoneNumber, String email, String dateOfBirth, String address,
                         int staffId, String position) {
        super(id, username, password, name, phoneNumber, email, dateOfBirth, address, staffId, position);
    }
    
    @Override
    public String toString() {
        return "WarehouseStaff{" + super.toString() + '}';
    }
}
