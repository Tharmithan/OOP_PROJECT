package com.fitness.membership_system.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fitness.membership_system.model.Admin;
import com.fitness.membership_system.model.FacilityReview;
import com.fitness.membership_system.model.Review;
import com.fitness.membership_system.model.TrainerReview;
import com.fitness.membership_system.model.User;
import com.fitness.membership_system.service.ReviewService;
import com.fitness.membership_system.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {
    private static final Logger LOGGER = Logger.getLogger(ReviewController.class.getName());

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;

    @GetMapping("/submit")
    public String showReviewSubmission(@RequestParam(value = "userId", required = false) String userId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            LOGGER.warning("Unauthorized access to /review/submit - User not logged in");
            return "redirect:/users/login";
        }
        model.addAttribute("userId", user.getId());
        return "review-submit";
    }

    @PostMapping("/submit")
    public String submitReview(@RequestParam("userId") String userId,
            @RequestParam("type") String type,
            @RequestParam("content") String content,
            @RequestParam("rating") int rating,
            @RequestParam(value = "trainerName", required = false) String trainerName,
            @RequestParam(value = "facilityArea", required = false) String facilityArea,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws IOException {
        
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getId().equals(userId)) {
            LOGGER.warning("Unauthorized review submission attempt - User: " + (user != null ? user.getId() : "null") + ", Requested User ID: " + userId);
            return "redirect:/users/login";
        }

        // Server-side validation
        if (rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5");
            return "redirect:/review/submit?userId=" + userId;
        }
        if ("Trainer".equals(type) && (trainerName == null || trainerName.trim().isEmpty())) {
            redirectAttributes.addFlashAttribute("error", "Trainer name is required for trainer reviews");
            return "redirect:/review/submit?userId=" + userId;
        }
        if ("Facility".equals(type) && (facilityArea == null || facilityArea.trim().isEmpty())) {
            redirectAttributes.addFlashAttribute("error", "Facility area is required for facility reviews");
            return "redirect:/review/submit?userId=" + userId;
        }

        LOGGER.info("Received review submission - User ID: " + userId);
        LOGGER.info("Review Type: " + type);
        LOGGER.info("Content: " + content);
        LOGGER.info("Rating: " + rating);
        
        int reviewId = reviewService.getNextReviewId();
        LOGGER.info("Generated Review ID: " + reviewId);
        
        LocalDateTime submissionDate = LocalDateTime.now();
        Review review;
        if ("Trainer".equals(type)) {
            review = new TrainerReview(reviewId, userId, content, submissionDate, rating, trainerName);
            LOGGER.info("Created Trainer Review for trainer: " + trainerName);
        } else {
            review = new FacilityReview(reviewId, userId, content, submissionDate, rating, facilityArea);
            LOGGER.info("Created Facility Review for area: " + facilityArea);
        }
        
        reviewService.submitReview(review);
        LOGGER.info("Review submitted successfully");
        
        redirectAttributes.addFlashAttribute("message", "Review submitted successfully!");
        return "redirect:/review/submit?userId=" + userId;
    }

    @GetMapping("/view")
    public String showReviews(@RequestParam(value = "userId", required = false) String userId, HttpSession session, Model model) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            LOGGER.warning("Unauthorized access to /review/view - User not logged in");
            return "redirect:/users/login";
        }
        if (userId != null && !user.getId().equals(userId)) {
            LOGGER.warning("Unauthorized review view attempt - User: " + user.getId() + ", Requested User ID: " + userId);
            return "redirect:/users/login";
        }
        List<Review> reviews = reviewService.getAllReviews().stream()
                .filter(review -> review.getUserId().equals(user.getId()))
                .collect(Collectors.toList());
        model.addAttribute("reviews", reviews);
        model.addAttribute("userId", user.getId());
        model.addAttribute("userName", user.getUsername());
        return "reviews";
    }

    @GetMapping("/admin")
    public String showAdminModeration(HttpSession session, Model model) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            LOGGER.warning("Unauthorized access to /review/admin - User: " + (user != null ? user.getId() : "null"));
            return "redirect:/users/admin/login";
        }
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        return "admin-moderation";
    }

    @PostMapping("/admin")
    public String handleAdminActions(@RequestParam("action") String action,
            @RequestParam(value = "reviewId", required = false) Integer reviewId,
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "rating", required = false) Integer rating,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "trainerName", required = false) String trainerName,
            @RequestParam(value = "facilityArea", required = false) String facilityArea,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            LOGGER.warning("Unauthorized admin action - User: " + (user != null ? user.getId() : "null"));
            return "redirect:/users/admin/login";
        }
        if ("update".equals(action) && reviewId != null) {
            if (rating == null || rating < 1 || rating > 5) {
                redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5");
                return "redirect:/review/admin";
            }
            if (userId == null || content == null || type == null) {
                redirectAttributes.addFlashAttribute("error", "Missing required fields for update");
                return "redirect:/review/admin";
            }
            LocalDateTime submissionDate = LocalDateTime.now();
            Review updatedReview;
            if ("Trainer".equals(type)) {
                if (trainerName == null || trainerName.trim().isEmpty()) {
                    redirectAttributes.addFlashAttribute("error", "Trainer name is required for trainer reviews");
                    return "redirect:/review/admin";
                }
                updatedReview = new TrainerReview(reviewId, userId, content, submissionDate, rating, trainerName);
            } else {
                if (facilityArea == null || facilityArea.trim().isEmpty()) {
                    redirectAttributes.addFlashAttribute("error", "Facility area is required for facility reviews");
                    return "redirect:/review/admin";
                }
                updatedReview = new FacilityReview(reviewId, userId, content, submissionDate, rating, facilityArea);
            }
            reviewService.updateReview(reviewId, updatedReview);
            redirectAttributes.addFlashAttribute("message", "Review updated successfully!");
        } else if ("delete".equals(action) && reviewId != null) {
            reviewService.deleteReview(reviewId);
            redirectAttributes.addFlashAttribute("message", "Review deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid action or missing review ID");
        }
        return "redirect:/review/admin";
    }

    @PostMapping("/update")
    public String updateUserReview(@RequestParam("reviewId") int reviewId,
            @RequestParam("content") String content,
            @RequestParam("rating") int rating,
            @RequestParam("type") String type,
            @RequestParam(value = "trainerName", required = false) String trainerName,
            @RequestParam(value = "facilityArea", required = false) String facilityArea,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            LOGGER.warning("Unauthorized access to /review/update - User not logged in");
            return "redirect:/users/login";
        }

        // Fetch the existing review to preserve its original submission date and user ID
        Review existingReview = reviewService.getReviewById(reviewId);
        if (existingReview == null || !existingReview.getUserId().equals(user.getId())) {
            redirectAttributes.addFlashAttribute("error", "You are not authorized to update this review!");
            return "redirect:/review/view?userId=" + user.getId();
        }

        // Validate rating
        if (rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("error", "Rating must be between 1 and 5");
            return "redirect:/review/view?userId=" + user.getId();
        }

        // Validate trainerName or facilityArea based on type
        if ("Trainer".equals(type) && (trainerName == null || trainerName.trim().isEmpty())) {
            redirectAttributes.addFlashAttribute("error", "Trainer name is required for trainer reviews");
            return "redirect:/review/view?userId=" + user.getId();
        }
        if ("Facility".equals(type) && (facilityArea == null || facilityArea.trim().isEmpty())) {
            redirectAttributes.addFlashAttribute("error", "Facility area is required for facility reviews");
            return "redirect:/review/view?userId=" + user.getId();
        }

        // Update only the modifiable fields, preserving the original submission date
        existingReview.setContent(content);
        existingReview.setRating(rating);
        if ("Trainer".equals(type)) {
            ((TrainerReview) existingReview).setTrainerName(trainerName);
        } else {
            ((FacilityReview) existingReview).setFacilityArea(facilityArea);
        }

        reviewService.updateReview(reviewId, existingReview);
        redirectAttributes.addFlashAttribute("message", "Review updated successfully!");
        return "redirect:/review/view?userId=" + user.getId();
    }
}