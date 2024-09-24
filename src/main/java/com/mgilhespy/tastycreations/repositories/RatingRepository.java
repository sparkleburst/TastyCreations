package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Rating;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long> {
    // Automatically generate the query to find all ratings associated with a specific recipe ID.
    List<Rating> findByRecipeId(double recipeId);

    // Calculate the average score for a specific recipe ID
    @Query("SELECT AVG(r.score) FROM Rating r WHERE r.recipeId = :recipeId")
    Optional<Double> findAverageScoreByRecipeId(double recipeId);

    //this method is for checking if a rating already exists for a given userId and recipeId
    Optional<Rating> findByRecipeIdAndRaterId(double recipeId, Long raterId);
}

