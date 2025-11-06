package com.restman.entity;

/**
 * Entity class đại diện cho nhà cung cấp
 */
public class Supplier {
    private int id;
    private String name;
    private String address;
    
    // Constructors
    public Supplier() {}
    
    public Supplier(int id, String name, String address) {
        this.id = id;
        this.name = name;
        this.address = address;
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
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    @Override
    public String toString() {
        return "Supplier{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
