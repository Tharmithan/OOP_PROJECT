package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public abstract class CheckIn {
    private int checkInId;
    private String userId;  // Matches User model's UUID
    private String type;
    private LocalDateTime checkInDate;

    public CheckIn(int checkInId, String userId, String type, LocalDateTime checkInDate) {
        this.checkInId = checkInId;
        this.userId = userId;
        this.type = type;
        this.checkInDate = checkInDate;
    }

    public int getCheckInId() { return checkInId; }
    public String getUserId() { return userId; }
    public String getType() { return type; }
    public LocalDateTime getCheckInDate() { return checkInDate; }

    public abstract String logCheckIn();
}