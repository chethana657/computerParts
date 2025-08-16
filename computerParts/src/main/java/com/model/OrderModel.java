package com.model;

import java.util.Date;

public class OrderModel {
    private int orderId;                // Order ID
    private Date date;                  // Order Date
    private int status;                 // Order Status
    private int userUserId;             // User ID (foreign key)
    private int inventoryInventoryId;   // Inventory ID (foreign key)
    private String address;             // Address
    private String email;               // Email
    private String mobile;              // Mobile Number
    private int quantity;               // Quantity of items ordered
    private double totalPrice;          // Total price of the order

    // Default constructor
    public OrderModel() {
    }

    // Parameterized constructor
    public OrderModel(int orderId, Date date, int status, int userUserId, int inventoryInventoryId, 
                      String address, String email, String mobile, int quantity, double totalPrice) {
        this.orderId = orderId;
        this.date = date;
        this.status = status;
        this.userUserId = userUserId;
        this.inventoryInventoryId = inventoryInventoryId;
        this.address = address;
        this.email = email;
        this.mobile = mobile;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserUserId() {
        return userUserId;
    }

    public void setUserUserId(int userUserId) {
        this.userUserId = userUserId;
    }

    public int getInventoryInventoryId() {
        return inventoryInventoryId;
    }

    public void setInventoryInventoryId(int inventoryInventoryId) {
        this.inventoryInventoryId = inventoryInventoryId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "OrderModel{" +
                "orderId=" + orderId +
                ", date=" + date +
                ", status=" + status +
                ", userUserId=" + userUserId +
                ", inventoryInventoryId=" + inventoryInventoryId +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", mobile='" + mobile + '\'' +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                '}';
    }
}
