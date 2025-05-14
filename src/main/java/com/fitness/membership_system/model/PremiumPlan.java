package com.fitness.membership_system.model;

public class PremiumPlan extends MembershipPlan {
    public PremiumPlan(String id, double price, int durationMonths) {
        super(id, "Premium", price, durationMonths, "Full Access");
    }

    @Override
    public String getBenefits() {
        return "Full access including personal training and premium facilities.";
    }
}