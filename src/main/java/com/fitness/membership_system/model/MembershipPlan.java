package com.fitness.membership_system.model;

public abstract class MembershipPlan {
    private String id;
    private String name;
    private double price;
    private int durationMonths;
    private String accessRights;

    public MembershipPlan(String id, String name, double price, int durationMonths, String accessRights) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.durationMonths = durationMonths;
        this.accessRights = accessRights;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getDurationMonths() { return durationMonths; }
    public void setDurationMonths(int durationMonths) { this.durationMonths = durationMonths; }
    public String getAccessRights() { return accessRights; }
    public void setAccessRights(String accessRights) { this.accessRights = accessRights; }

    public abstract String getBenefits();
}