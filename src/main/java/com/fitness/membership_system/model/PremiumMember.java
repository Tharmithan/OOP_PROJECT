package com.fitness.membership_system.model;

public class PremiumMember extends User {
    public PremiumMember(String id, String username, String password, String email, String phone) {
        super(id, username, password, email, phone, "Premium");
    }

    @Override
    public String getRole() {
        return "Member";
    }
}