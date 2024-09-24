package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Review;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.ApiService;
import com.mgilhespy.tastycreations.services.RatingService;
import com.mgilhespy.tastycreations.services.ReviewService;
import com.mgilhespy.tastycreations.services.UserService;
import com.spoonacular.client.ApiException;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;

    @Autowired
    private ApiService apiService;

    @Autowired
    private RatingService ratingService;

    @PostMapping("/recipes/{recipeId}/reviews/create")
    public String createReview(@PathVariable double recipeId, @Valid @ModelAttribute("review") Review review, BindingResult result, HttpSession session, Model model) throws ApiException {
        System.out.println("========Method was triggered=============");
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/login";
        }
        if(result.hasErrors()) {
            System.out.println("=================the form has errors====================");
            long recipeIdL = Double.valueOf(recipeId).longValue();

            Object recipeInfo = apiService.getRecipeInformation(recipeIdL, false);
            System.out.println(recipeInfo);
            model.addAttribute("recipeInfo", recipeInfo);

            Double averageRating = ratingService.getAverageRating((double) recipeId);
            model.addAttribute("averageRating", averageRating != null ? averageRating : "No ratings yet");

            User user= userService.findUserById(userId);
            model.addAttribute("user", user);;


            return "recipe-details";
        }
        System.out.println("===========Form does not have===============");
        reviewService.createReview(review);
        return "redirect:/recipes/" + recipeId + "/information";
    }







}
