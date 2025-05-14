package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public class Booking {
    private String id;
    private String userId;
    private String workoutId;
    private String trainerId;
    private LocalDateTime sessionTime;

    public Booking(String id, String userId, String workoutId, String trainerId, LocalDateTime sessionTime) {
        this.id = id;
        this.userId = userId;
        this.workoutId = workoutId;
        this.trainerId = trainerId;
        this.sessionTime = sessionTime;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getWorkoutId() {
        return workoutId;
    }

    public void setWorkoutId(String workoutId) {
        this.workoutId = workoutId;
    }

    public String getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(String trainerId) {
        this.trainerId = trainerId;
    }

    public LocalDateTime getSessionTime() {
        return sessionTime;
    }

    public void setSessionTime(LocalDateTime sessionTime) {
        this.sessionTime = sessionTime;
    }
}