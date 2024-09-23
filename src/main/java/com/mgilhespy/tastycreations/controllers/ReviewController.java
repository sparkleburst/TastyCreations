package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.services.ReviewService;
import com.mgilhespy.tastycreations.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @Autowired
    UserService userService;







}
