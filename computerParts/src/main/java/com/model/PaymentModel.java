package com.model;


public class PaymentModel {
    private int paymentId;   // Payment ID
    private String cardNumber;   // Credit Card Number
    private String cvv;          // Card Verification Value
    private String expireDate;     // Expiration Date
    private int userUserId;      // User ID (foreign key)

    // Default constructor
    public PaymentModel() {
    }

    // Parameterized constructor
    public PaymentModel(int paymentId, String cardNumber, String cvv, String expireDate, int userUserId) {
        this.paymentId = paymentId;
        this.cardNumber = cardNumber;
        this.cvv = cvv;
        this.expireDate = expireDate;
        this.userUserId = userUserId;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(String expireDate) {
        this.expireDate = expireDate;
    }

    public int getUserUserId() {
        return userUserId;
    }

    public void setUserUserId(int userUserId) {
        this.userUserId = userUserId;
    }

    @Override
    public String toString() {
        return "PaymentModel{" +
                "paymentId='" + paymentId + '\'' +
                ", cardNumber='" + cardNumber + '\'' +
                ", cvv='" + cvv + '\'' +
                ", expireDate=" + expireDate +
                ", userUserId=" + userUserId +
                '}';
    }
}
