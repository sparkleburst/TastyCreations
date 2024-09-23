package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Rating;
import com.mgilhespy.tastycreations.repositories.RatingRepository;

import java.util.List;

public class RatingService {

    private RatingRepository ratingRepo;

    // Create or update a rating
    public Rating addRating(Rating rating) {
        return ratingRepo.save(rating);
    }

    // Get all ratings for a specific recipe
    public List<Rating> findRatingsByRecipeId(double recipeId) {
        return ratingRepo.findByRecipeId(recipeId);
    }

    public Double getAverageRating(double recipeId) {
        return ratingRepo.findAverageScoreByRecipeId(recipeId);
    }

}
