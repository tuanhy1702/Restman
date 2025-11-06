package com.restman.entity;

/**
 * Entity class đại diện cho nhân viên quản lý
 */
public class Manager extends Staff {
    
    // Constructors
    public Manager() {}
    
    public Manager(int id, String username, String password, String name, 
                   String phoneNumber, String email, String dateOfBirth, String address,
                   int staffId, String position) {
        super(id, username, password, name, phoneNumber, email, dateOfBirth, address, staffId, position);
    }
    
    @Override
    public String toString() {
        return "Manager{" + super.toString() + '}';
    }
}
