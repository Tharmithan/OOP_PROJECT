package com.fitness.membership_system.model;

public class Admin extends User {
    private boolean isSuperAdmin;

    public Admin(String id, String username, String password, String email, String phone, boolean isSuperAdmin) {
        super(id, username, password, email, phone, "Admin");
        this.isSuperAdmin = isSuperAdmin;
    }

    public boolean isSuperAdmin() { return isSuperAdmin; }
    public void setSuperAdmin(boolean superAdmin) { isSuperAdmin = superAdmin; }

    @Override
    public String getRole() {
        return isSuperAdmin ? "SuperAdmin" : "Admin";
    }
}