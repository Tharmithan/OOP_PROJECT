package com.fitness.membership_system.model;

import java.time.LocalDateTime;

public abstract class Review {
    private int reviewId;
    private String userId;
    private String content;
    private LocalDateTime submissionDate;
    private int rating;

    public Review(int reviewId, String userId, String content, LocalDateTime submissionDate, int rating) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.content = content;
        this.submissionDate = submissionDate;
        this.rating = Math.max(1, Math.min(5, rating));
    }

    public int getReviewId() {
        return reviewId;
    }

    public String getUserId() {
        return userId;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getSubmissionDate() {
        return submissionDate;
    }

    public int getRating() {
        return rating;
    }

    public abstract String getType();

    public abstract String displayReview();

    public void setContent(String content) {
        this.content = content;
    }

    public void setRating(int rating) {
        this.rating = Math.max(1, Math.min(5, rating));
    }
}