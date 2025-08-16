package com.model;

public class ItemModel {
    private int inventoryId;
    private String itemName;
    private String description;
    private double price;
    private int quantity;
    private int status;
    private String imgURL;

    // Constructor
    public ItemModel() {
        // Default constructor
    }

    public ItemModel(int inventoryId, String itemName, String description, double price, int quantity, int status, String imgURL) {
        this.inventoryId = inventoryId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.status = status;
        this.imgURL = imgURL;
    }

    // Getters and Setters
    public int getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

    // toString method for easy representation
    @Override
    public String toString() {
        return "ItemModel [inventoryId=" + inventoryId + ", itemName=" + itemName + ", description=" + description
                + ", price=" + price + ", quantity=" + quantity + ", status=" + status + ", imgURL=" + imgURL + "]";
    }
}
