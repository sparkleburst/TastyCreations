package com.mgilhespy.tastycreations.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String showHomePage() {
        return "index"; // This will resolve to src/main/webapp/WEB-INF/views/index.jsp
    }
}
