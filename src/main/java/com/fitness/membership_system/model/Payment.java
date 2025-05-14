package com.fitness.membership_system.model;

public class Payment {
    private String paymentId;  // New unique identifier for each payment
    private String userId;
    private String username;
    private double amount;
    private String method;
    private String status;

    public Payment(String paymentId, String userId, String username, double amount, String method, String status) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.username = username;
        this.amount = amount;
        this.method = method;
        this.status = status;
    }

    // Getters and setters
    public String getId() {
        return paymentId;  // Now returns the unique paymentId
    }

    public void setId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}