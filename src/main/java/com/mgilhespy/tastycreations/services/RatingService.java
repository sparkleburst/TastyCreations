package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Rating;
import com.mgilhespy.tastycreations.repositories.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RatingService {

    @Autowired
    private RatingRepository ratingRepo;

    // Create or update a rating
    public Rating addRating(Rating rating) {
        // Check if the user has already rated this recipe
        Optional<Rating> existingRating = ratingRepo.findByRecipeIdAndRaterId(rating.getRecipeId(), rating.getRater().getId());

        if (existingRating.isPresent()) {
            throw new IllegalStateException("User has already rated this recipe");
        }
       return ratingRepo.save(rating);
    }

    // Get all ratings for a specific recipe
    public List<Rating> findRatingsByRecipeId(double recipeId) {
        return ratingRepo.findByRecipeId(recipeId);
    }

    public Double getAverageRating(double recipeId) {
        return ratingRepo.findAverageScoreByRecipeId(recipeId).orElse(null);
    }

    public boolean hasUserRatedRecipe(double recipeId, Long raterId) {
        return ratingRepo.findByRecipeIdAndRaterId(recipeId, raterId).isPresent();
    }

}
