package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Rating;
import com.mgilhespy.tastycreations.services.RatingService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/ratings")
public class RatingController {

    private RatingService ratingService;

    // Handle form submission to add a rating
    @PostMapping("/recipes/recipeId/rate")
    public String addRating(@ModelAttribute("rating") Rating rating) {
        ratingService.addRating(rating);
        return "redirect:/ratings";
    }

}
