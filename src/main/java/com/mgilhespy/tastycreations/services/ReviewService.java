package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Review;
import com.mgilhespy.tastycreations.repositories.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReviewService {
    @Autowired
    ReviewRepository reviewRepository;

    public Review createReview(Review review) {
        return reviewRepository.save(review);
    }
    public List<Review> getAllReviewsByRecipeId(double recipeId) {
        return reviewRepository.findAllReviewsByRecipeIdOrderByCreatedAtDesc(recipeId);
    }
    public Review getReviewById(Long reviewId) {
        Optional<Review> review = reviewRepository.findById(reviewId);
        return review.orElse(null);
    }
    public Review updateReview(Long reviewId, Review review) {
        Optional<Review> reviewOptional = reviewRepository.findById(reviewId);
        if (reviewOptional.isEmpty()) {
            return null;
        }
        Review reviewToUpdate = reviewOptional.get();
        reviewToUpdate.setContent(review.getContent());
        reviewToUpdate.setReviewer(review.getReviewer());
        reviewToUpdate.setRecipeId(review.getRecipeId());
        return reviewRepository.save(reviewToUpdate);

    }
    public boolean hasUserReviewedRecipe(double recipeId, Long userId) {
        return reviewRepository.findByRecipeIdAndReviewerId(recipeId, userId).isPresent();
    }

    public Review findByRecipeIdAndReviewerId(Long recipeId, Long reviewerId) {
        Optional<Review> reviewOptional = reviewRepository.findByRecipeIdAndReviewerId( recipeId, reviewerId);
        if (reviewOptional.isEmpty()) {
            return null;
        }
        Review review = reviewOptional.get();
        return review;
    }

    public List<Review> getReviewsByRecipeId(double recipeId) {
        return reviewRepository.findAllReviewsByRecipeIdOrderByCreatedAtDesc(recipeId);
    }

}
