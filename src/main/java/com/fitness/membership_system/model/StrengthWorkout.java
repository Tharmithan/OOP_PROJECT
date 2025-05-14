package com.fitness.membership_system.model;

public class StrengthWorkout extends WorkoutPlan {
    public StrengthWorkout(String id, String name, String description, int durationMinutes, String trainerId) {
        super(id, name, description, durationMinutes, trainerId);
    }

    @Override
    public String getType() {
        return "Strength";
    }
}