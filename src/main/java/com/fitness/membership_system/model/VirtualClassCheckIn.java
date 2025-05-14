package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public class VirtualClassCheckIn extends CheckIn {
    private int virtualClassId;

    public VirtualClassCheckIn(int checkInId, String userId, LocalDateTime checkInDate, int virtualClassId) {
        super(checkInId, userId, "Virtual", checkInDate);
        this.virtualClassId = virtualClassId;
    }

    public int getVirtualClassId() { return virtualClassId; }

    @Override
    public String logCheckIn() {
        return getCheckInId() + "|" + getUserId() + "|" + getType() + "|" + getCheckInDate().toString().replace("T", " ") + "|" + virtualClassId;
    }
}