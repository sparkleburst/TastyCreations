package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.services.ApiService;
import com.spoonacular.client.ApiException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RecipeController {
    @Autowired
    private ApiService apiService;



    @GetMapping("/recipes/dashboard")
    public String index(Model model) throws ApiException {
        String ingredients = "apples,flour,sugar";
        Object response = apiService.getRecipesByIngredients(ingredients);
        model.addAttribute("response", response);

        return "dashboard";
    }
}
