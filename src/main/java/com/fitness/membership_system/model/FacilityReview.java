package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public class FacilityReview extends Review {
    private String facilityArea;

    public FacilityReview(int reviewId, String userId, String content, LocalDateTime submissionDate, int rating,
            String facilityArea) {
        super(reviewId, userId, content, submissionDate, rating);
        this.facilityArea = facilityArea;
    }

    public String getFacilityArea() {
        return facilityArea;
    }

    @Override
    public String displayReview() {
        return "Facility: " + facilityArea + ", Rating: " + getRating() + ", Feedback: " + getContent() +
                ", Date: " + getSubmissionDate().toString().replace("T", " ");
    }

    @Override
    public String getType() {
        return "Facility";
    }

    public void setFacilityArea(String facilityArea) {
        this.facilityArea = facilityArea;
    }
}