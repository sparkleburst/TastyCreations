package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Rating;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.RatingService;
import com.mgilhespy.tastycreations.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/ratings")
public class RatingController {

    @Autowired
    private RatingService ratingService;
    @Autowired
    private UserService userService;

    // Handle form submission to add a rating
    @PostMapping("/recipes/{recipeId}/rate")
    public String addRating(@PathVariable double recipeId, @RequestParam Long raterId, @ModelAttribute("rating") Rating rating) {
        // Check if the user has already rated this recipe
        if (ratingService.hasUserRatedRecipe(recipeId, raterId)) {
            return "redirect:/recipes/" + recipeId + "/information?error=alreadyRated";
        }

        // Fetch the user using the userId

        User rater = userService.findUserById(raterId);
        if (rater == null) {


            return "redirect:/recipes/" + recipeId + "?error=userNotFound";
        }

        // Set the rater and recipeId on the rating object
        rating.setRater(rater);
        rating.setRecipeId(recipeId);

        // Save the rating
        ratingService.addRating(rating);

        return "redirect:/recipes/" + recipeId + "/information";
    }

}
