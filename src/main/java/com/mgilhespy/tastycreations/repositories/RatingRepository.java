package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Rating;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long> {
    // Automatically generate the query to find all ratings associated with a specific recipe ID.
    List<Rating> findByRecipeId(int recipeId);
}
