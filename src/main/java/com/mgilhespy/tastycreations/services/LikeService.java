package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Like;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.repositories.LikeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LikeService {

    @Autowired
    private LikeRepository likeRepository;

    @Autowired
    private UserService userService;

    // Add a like to a recipe
    public Like addLike(double recipeId, Long userId) {
        Optional<Like> existingLike = likeRepository.findByRecipeIdAndLikerId(recipeId, userId);
        if (existingLike.isEmpty()) {
            Like newLike = new Like();
            newLike.setRecipeId(recipeId);
            User user = userService.findUserById(userId);
            newLike.setLiker(user);
            return likeRepository.save(newLike);
        }
        return existingLike.get();
    }

    // Remove a like from a recipe
    public void removeLike(double recipeId, Long userId) {
        Optional<Like> existingLike = likeRepository.findByRecipeIdAndLikerId(recipeId, userId);
        existingLike.ifPresent(likeRepository::delete);
    }

    // Get the total number of likes for a recipe
    public Long getLikeCountForRecipe(double recipeId) {
        return likeRepository.countLikesByRecipeId(recipeId);
    }

    // Check if the user has liked the recipe
    public boolean hasUserLikedRecipe(double recipeId, Long userId) {
        return likeRepository.findByRecipeIdAndLikerId(recipeId, userId).isPresent();
    }
}
