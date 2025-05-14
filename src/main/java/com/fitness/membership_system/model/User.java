package com.fitness.membership_system.model;

public abstract class User {
    private String id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String membershipType;

    public User(String id, String username, String password, String email, String phone, String membershipType) {
        this.id = id;
        this.username = username;
        this.password = password; // In production, hash passwords
        this.email = email;
        this.phone = phone;
        this.membershipType = membershipType;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getMembershipType() { return membershipType; }
    public void setMembershipType(String membershipType) { this.membershipType = membershipType; }
    public String getName() { return getUsername(); }

    public abstract String getRole();
}