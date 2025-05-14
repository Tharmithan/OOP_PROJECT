package com.fitness.membership_system.model;

public class CardioWorkout extends WorkoutPlan {
    public CardioWorkout(String id, String name, String description, int durationMinutes, String trainerId) {
        super(id, name, description, durationMinutes, trainerId);
    }

    @Override
    public String getType() {
        return "Cardio";
    }
}