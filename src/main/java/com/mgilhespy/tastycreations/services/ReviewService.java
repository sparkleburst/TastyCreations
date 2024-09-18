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
    public List<Review> getAllReviewsByRecipeId(Long recipeId) {
        return reviewRepository.findAllReviewsByRecipeId(recipeId);
    }
    public Review getReviewById(Long reviewId) {
        Optional<Review> review = reviewRepository.findById(reviewId);
        return review.orElse(null);
    }
    public Review updateReview(Long id, Review review) {
        Optional<Review> reviewOptional = reviewRepository.findById(id);
        if (reviewOptional.isEmpty()) {
            return null;
        }
        Review reviewToUpdate = reviewOptional.get();
        reviewToUpdate.setContent(review.getContent());
        reviewToUpdate.setReviewer(review.getReviewer());
        reviewToUpdate.setRecipeId(review.getRecipeId());
        return reviewRepository.save(reviewToUpdate);

    }


}
