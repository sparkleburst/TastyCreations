package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.MyRecipe;
import com.mgilhespy.tastycreations.models.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MyRecipeRepository extends CrudRepository<MyRecipe, Long> {

    List<MyRecipe> findByUser(User user);
    Optional<MyRecipe> findByUserAndRecipeId(User user, double recipeId);
}
