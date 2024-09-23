package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Review;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends CrudRepository<Review, Long> {
    List<Review> findAllReviewsByRecipeId(Long recipeId);

}
