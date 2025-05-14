package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public class TrainerReview extends Review {
    private String trainerName;

    public TrainerReview(int reviewId, String userId, String content, LocalDateTime submissionDate, int rating,
            String trainerName) {
        super(reviewId, userId, content, submissionDate, rating);
        this.trainerName = trainerName;
    }

    public String getTrainerName() {
        return trainerName;
    }

    @Override
    public String displayReview() {
        return "Trainer: " + trainerName + ", Rating: " + getRating() + ", Feedback: " + getContent() +
                ", Date: " + getSubmissionDate().toString().replace("T", " ");
    }

    @Override
    public String getType() {
        return "Trainer";
    }
     public void setTrainerName(String trainerName) {
        this.trainerName = trainerName;
    }
}