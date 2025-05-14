package com.fitness.membership_system.model;

public class RegularMember extends User {
    public RegularMember(String id, String username, String password, String email, String phone) {
        super(id, username, password, email, phone, "Regular");
    }

    @Override
    public String getRole() {
        return "Member";
    }
}