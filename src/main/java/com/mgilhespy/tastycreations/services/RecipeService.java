package com.mgilhespy.tastycreations.services;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.mgilhespy.tastycreations.models.Recipe;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.repositories.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecipeService {
    private final Logger logger = LoggerFactory.getLogger(RecipeService.class); // Initialize logger

    @Autowired
    private RecipeRepository recipeRepository;

    public void likeRecipe(Recipe recipe, User user) {


        if (!recipe.getLikedByUsers().contains(user)) {
            recipe.getLikedByUsers().add(user);
            recipeRepository.save(recipe);
            logger.info("User {} added to liked users for recipe {}", user.getId(), recipe.getId());
        } else {
            logger.info("User {} already liked recipe {}", user.getId(), recipe.getId());
        }
    }

    public void unlikeRecipe(Recipe recipe, User user) {
        if (recipe.getLikedByUsers().contains(user)) {
            recipe.getLikedByUsers().remove(user);
            recipeRepository.save(recipe);
            logger.info("User {} removed from liked users for recipe {}", user.getId(), recipe.getId());
        } else {
            logger.info("User {} had not liked recipe {}", user.getId(), recipe.getId());
        }
    }
}
