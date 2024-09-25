package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.MyRecipe;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.ApiService;
import com.mgilhespy.tastycreations.services.MyRecipeService;
import com.mgilhespy.tastycreations.services.UserService;
import com.spoonacular.client.ApiException;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
class MyRecipeController {
    @Autowired
    MyRecipeService myRecipeService;

    @Autowired
    UserService userService;

    @Autowired
    ApiService apiService;

    @GetMapping("/recipes/{userId}")
    public String getMyRecipes(@PathVariable Long userId, Model model) {
        User user = userService.findUserById(userId);

        if (user != null) {
            List<MyRecipe> savedRecipes = myRecipeService.getSavedRecipesByUser(user);
            List<Object> enrichedRecipes = new ArrayList<>(); // This list will hold detailed recipe information

            // Fetch details from the API for each saved recipe
            for (MyRecipe myRecipe : savedRecipes) {
                try {
                    // Fetch recipe information from API using the recipeId
                    Object recipeInfo = apiService.getRecipeInformation((long)myRecipe.getRecipeId(), false);
                    enrichedRecipes.add(recipeInfo); // Add the detailed Recipe object to the list

                } catch (ApiException e) {
                    e.printStackTrace();
                }
            }

            model.addAttribute("savedRecipes", enrichedRecipes);
            model.addAttribute("user", user );// Pass the detailed recipes to the view
            model.addAttribute("userId", userId);
        } else {
            model.addAttribute("savedRecipes", null);
        }

        return "my-recipes"; // The view name to display the recipes



//        if (user != null) {
//            model.addAttribute("savedRecipes", myRecipeService.getSavedRecipesByUser(user));
//        } else {
//            model.addAttribute("savedRecipes", null);
//        }
//        return "my-recipes";
    }

//    @PostMapping("/recipes/{recipeId}/save")
//    public String saveMyRecipe(@PathVariable Long recipeId, @Valid @ModelAttribute("myRecipe") MyRecipe myRecipe, Model model, HttpSession session ) {}
//
@PostMapping("/recipes/{recipeId}/save")
public String saveRecipe(@PathVariable double recipeId, HttpSession session, RedirectAttributes redirectAttributes) {
    // Fetch the logged-in user from the session
    Long userId = (Long) session.getAttribute("userId");
    if (userId != null) {
        User user = userService.findUserById(userId);

        // Check if the recipe is already saved
        boolean alreadySaved = myRecipeService.isRecipeAlreadySavedByUser(user, recipeId);
        if (alreadySaved) {
            redirectAttributes.addFlashAttribute("error", "Recipe is already saved.");
            return "redirect:/recipes/" + userId ;
        }

        // Create a new MyRecipe object and set the recipeId and user
        MyRecipe myRecipe = new MyRecipe();
        myRecipe.setRecipeId(recipeId);
        myRecipe.setUser(user);

        // Save the recipe
        myRecipeService.saveRecipe(myRecipe);

        redirectAttributes.addFlashAttribute("message", "Recipe saved successfully!");
    } else {
        redirectAttributes.addFlashAttribute("error", "You must be logged in to save a recipe.");
    }

    return "redirect:/recipes/" + userId; // Redirect back to the details page
}



}
