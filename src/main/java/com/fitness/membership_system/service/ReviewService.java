package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.FacilityReview;
import com.fitness.membership_system.model.Review;
import com.fitness.membership_system.model.TrainerReview;

@Service
public class ReviewService {

    private static final Logger LOGGER = Logger.getLogger(ReviewService.class.getName());

    @Value("${file.reviews.path}")
    private String reviewsFilePath;

    private File getReviewsFile() throws IOException {
        // Get the absolute path of the project directory
        String projectDir = System.getProperty("user.dir");
        File file = new File(projectDir, reviewsFilePath);
        
        LOGGER.info("Reviews file path: " + file.getAbsolutePath());
        
        if (!file.exists()) {
            LOGGER.info("Creating new reviews file at: " + file.getAbsolutePath());
            file.getParentFile().mkdirs(); // Create parent directories if they don't exist
            file.createNewFile();
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                writer.write("Review ID|User ID|Type|Content|Submission Date|Rating|Trainer/Facility\n");
            }
        }
        return file;
    }

    public void submitReview(Review review) throws IOException {
        File file = getReviewsFile();
        LOGGER.info("Submitting review to file: " + file.getAbsolutePath());
        
        synchronized (file) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                String reviewLine = review.getReviewId() + "|" + review.getUserId() + "|" + review.getType() + "|" + review.getContent() + "|" +
                        review.getSubmissionDate().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "|"
                        + review.getRating()
                        + "|" +
                        (review instanceof TrainerReview ? ((TrainerReview) review).getTrainerName()
                                : ((FacilityReview) review).getFacilityArea());
                writer.write(reviewLine);
                writer.newLine();
                LOGGER.info("Successfully wrote review: " + reviewLine);
            } catch (IOException e) {
                LOGGER.severe("Failed to submit review: " + e.getMessage());
                throw e;
            }
        }
    }

    public List<Review> getAllReviews() throws IOException {
        List<Review> reviews = new ArrayList<>();
        File file = getReviewsFile();

        synchronized (file) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                reader.readLine(); // Skip header
                while ((line = reader.readLine()) != null) {
                    if (line.trim().isEmpty())
                        continue; // Skip blank lines
                    String[] parts = line.split("\\|");
                    if (parts.length != 7) {
                        LOGGER.warning("Skipping malformed review line: " + line);
                        continue; // Skip malformed lines
                    }
                    int reviewId = Integer.parseInt(parts[0].trim());
                    String userId = parts[1].trim();
                    String type = parts[2].trim();
                    String content = parts[3].trim();
                    LocalDateTime submissionDate = LocalDateTime.parse(parts[4].trim(),
                            DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                    int rating = Integer.parseInt(parts[5].trim());
                    String extraField = parts[6].trim();

                    Review review;
                    if ("Trainer".equalsIgnoreCase(type)) {
                        review = new TrainerReview(reviewId, userId, content, submissionDate, rating, extraField);
                    } else {
                        review = new FacilityReview(reviewId, userId, content, submissionDate, rating, extraField);
                    }
                    reviews.add(review);
                }
            } catch (IOException e) {
                LOGGER.severe("Failed to read reviews: " + e.getMessage());
                throw e;
            }
        }
        return reviews;
    }

    public Review getReviewById(int reviewId) throws IOException {
        return getAllReviews().stream()
                .filter(r -> r.getReviewId() == reviewId)
                .findFirst()
                .orElse(null);
    }

    public void updateReview(int reviewId, Review updatedReview) throws IOException {
        File file = getReviewsFile();
        List<Review> reviews = getAllReviews();
        boolean updated = false;

        synchronized (file) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                writer.write("Review ID|User ID|Type|Content|Submission Date|Rating|Trainer/Facility\n");
                for (Review review : reviews) {
                    if (review.getReviewId() == reviewId) {
                        // Preserve original submission date and create a new instance of the correct
                        // type
                        Review updatedInstance;
                        if (review instanceof TrainerReview) {
                            updatedInstance = new TrainerReview(
                                    reviewId,
                                    updatedReview.getUserId(),
                                    updatedReview.getContent(),
                                    review.getSubmissionDate(), // Preserve original date
                                    updatedReview.getRating(),
                                    ((TrainerReview) updatedReview).getTrainerName());
                        } else {
                            updatedInstance = new FacilityReview(
                                    reviewId,
                                    updatedReview.getUserId(),
                                    updatedReview.getContent(),
                                    review.getSubmissionDate(), // Preserve original date
                                    updatedReview.getRating(),
                                    ((FacilityReview) updatedReview).getFacilityArea());
                        }
                        writer.write(formatReviewForFile(updatedInstance));
                        updated = true;
                    } else {
                        writer.write(formatReviewForFile(review));
                    }
                    writer.newLine();
                }
                if (!updated) {
                    LOGGER.warning("Review with ID " + reviewId + " not found for update");
                }
            } catch (IOException e) {
                LOGGER.severe("Failed to update review: " + e.getMessage());
                throw e;
            }
        }
    }

    public void deleteReview(int reviewId) throws IOException {
        File file = getReviewsFile();
        List<Review> reviews = getAllReviews();

        synchronized (file) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                writer.write("Review ID|User ID|Type|Content|Submission Date|Rating|Trainer/Facility\n");
                boolean deleted = false;
                for (Review review : reviews) {
                    if (review.getReviewId() != reviewId) {
                        writer.write(formatReviewForFile(review));
                        writer.newLine();
                    } else {
                        deleted = true;
                    }
                }
                if (!deleted) {
                    LOGGER.warning("Review with ID " + reviewId + " not found for deletion");
                }
            } catch (IOException e) {
                LOGGER.severe("Failed to delete review: " + e.getMessage());
                throw e;
            }
        }
    }

    private String formatReviewForFile(Review review) {
        return review.getReviewId() + "|" + review.getUserId() + "|" + review.getType() + "|" +
                review.getContent() + "|" +
                review.getSubmissionDate().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + "|" + review.getRating()
                + "|" +
                (review instanceof TrainerReview ? ((TrainerReview) review).getTrainerName()
                        : ((FacilityReview) review).getFacilityArea());
    }

    public int getNextReviewId() throws IOException {
        List<Review> reviews = getAllReviews();
        return reviews.isEmpty() ? 1 : reviews.get(reviews.size() - 1).getReviewId() + 1;
    }
}