package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe, Long> {
    // You can define custom query methods here if needed
    Optional<Recipe> findByApiId(Double apiId);

    // Other custom queries can be added as needed
}
