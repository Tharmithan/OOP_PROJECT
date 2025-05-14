package com.fitness.membership_system.model;

public class BasicPlan extends MembershipPlan {
    public BasicPlan(String id, double price, int durationMonths) {
        super(id, "Basic", price, durationMonths, "Gym Access");
    }

    @Override
    public String getBenefits() {
        return "Access to gym facilities during regular hours.";
    }
}