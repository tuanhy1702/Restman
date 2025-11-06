package com.restman.entity;

public class ImportBill {
    private int id;
    private String name;
    private int quantity;
    private  int price;
    private Supplier supplier;
    private String importDate;

    public ImportBill(Supplier supplier, String importDate, int id) {
        this.supplier = supplier;
        this.importDate = importDate;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public String getImportDate() {
        return importDate;
    }

    public void setImportDate(String importDate) {
        this.importDate = importDate;
    }
}
