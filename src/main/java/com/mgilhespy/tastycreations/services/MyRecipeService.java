package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.MyRecipe;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.repositories.MyRecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MyRecipeService {
    @Autowired
    MyRecipeRepository myRecipeRepository;

    public List<MyRecipe> getSavedRecipesByUser(User user) {
        return myRecipeRepository.findByUser(user);
    }

    public MyRecipe saveRecipe(MyRecipe myRecipe){
        return myRecipeRepository.save(myRecipe);

    }

    public boolean isRecipeAlreadySavedByUser(User user, double recipeId) {
        return myRecipeRepository.findByUserAndRecipeId(user, recipeId).isPresent();
    }

    public void deleteByUserAndRecipeId(User user, double recipeId) {
        Optional<MyRecipe> myRecipe = myRecipeRepository.findByUserAndRecipeId(user, recipeId);
        myRecipe.ifPresent(myRecipeRepository::delete);
    }
}
