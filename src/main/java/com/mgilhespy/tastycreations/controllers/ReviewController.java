package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Review;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.ReviewService;
import com.mgilhespy.tastycreations.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @Autowired
    UserService userService;

    @PostMapping("recipes/{recipeId}/reviews/create")
    public String createReview(@PathVariable double recipeId, @ModelAttribute("review") Review review, BindingResult result, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/login";
        }
        reviewService.createReview(review);
        return "redirect:/recipes/" + recipeId + "/information";
    }







}
