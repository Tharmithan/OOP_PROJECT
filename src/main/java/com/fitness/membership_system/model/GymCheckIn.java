package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public class GymCheckIn extends CheckIn {
    public GymCheckIn(int checkInId, String userId, LocalDateTime checkInDate) {
        super(checkInId, userId, "Gym", checkInDate);
    }

    @Override
    public String logCheckIn() {
        return getCheckInId() + "|" + getUserId() + "|" + getType() + "|" + getCheckInDate().toString().replace("T", " ") + "|";
    }
}