package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Like;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.List;

@Repository
public interface LikeRepository extends CrudRepository<Like, Long> {
    // Find all likes associated with a specific recipe ID
    List<Like> findByRecipeId(double recipeId);

    // Check if a like already exists for a given userId and recipeId
    Optional<Like> findByRecipeIdAndLikerId(double recipeId, Long likerId);

    // Count total likes for a specific recipe ID
    @Query("SELECT COUNT(l) FROM Like l WHERE l.recipeId = :recipeId")
    Long countLikesByRecipeId(double recipeId);
}
