package com.fitness.membership_system.model;

public class StandardPlan extends MembershipPlan {
    public StandardPlan(String id, double price, int durationMonths) {
        super(id, "Standard", price, durationMonths, "Gym + Classes");
    }

    @Override
    public String getBenefits() {
        return "Access to gym and group classes.";
    }
}