package com.fitness.membership_system.model;

public abstract class WorkoutPlan {
    private String id;
    private String name;
    private String description;
    private int durationMinutes;
    private String trainerId;

    public WorkoutPlan(String id, String name, String description, int durationMinutes, String trainerId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.durationMinutes = durationMinutes;
        this.trainerId = trainerId;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public String getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(String trainerId) {
        this.trainerId = trainerId;
    }

    public abstract String getType();
}