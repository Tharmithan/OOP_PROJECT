package com.fitness.membership_system.model;

import java.time.LocalDate;

public class RenewalRequest {
    private String requestId;
    private String userId;
    private String planId;
    private LocalDate requestDate;
    private LocalDate lastRenewalDate;
    private int priority;

    public RenewalRequest(String requestId, String userId, String planId, LocalDate requestDate, LocalDate lastRenewalDate, int priority) {
        this.requestId = requestId;
        this.userId = userId;
        this.planId = planId;
        this.requestDate = requestDate;
        this.lastRenewalDate = lastRenewalDate;
        this.priority = priority;
    }

    // Getters and Setters
    public String getRequestId() { return requestId; }
    public void setRequestId(String requestId) { this.requestId = requestId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getPlanId() { return planId; }
    public void setPlanId(String planId) { this.planId = planId; }
    public LocalDate getRequestDate() { return requestDate; }
    public void setRequestDate(LocalDate requestDate) { this.requestDate = requestDate; }
    public LocalDate getLastRenewalDate() { return lastRenewalDate; }
    public void setLastRenewalDate(LocalDate lastRenewalDate) { this.lastRenewalDate = lastRenewalDate; }
    public int getPriority() { return priority; }
    public void setPriority(int priority) { this.priority = priority; }
}