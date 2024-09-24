package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Recipe;
import com.mgilhespy.tastycreations.services.ApiService;
import com.mgilhespy.tastycreations.services.RatingService;
import com.spoonacular.client.ApiException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class RecipeController {
    private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);

    @Autowired
    private ApiService apiService;

    @Autowired
    RatingService ratingService;

    @Autowired
    private CacheManager cacheManager;  // Inject Spring's CacheManager

    // Handles the /recipes/dashboard route
    @GetMapping("/recipes/dashboard")
    public String showDashboard(Model model) {
        // Default ingredients for displaying on the dashboard (or you can customize this section)
        String defaultIngredients = "apples,flour,sugar";

        // Check if the value is already in the cache for default ingredients
        Cache cache = cacheManager.getCache("recipes");
        Cache.ValueWrapper cachedValue = cache.get(defaultIngredients);

        if (cachedValue != null) {
            logger.info("Cache hit for default ingredients: {}", defaultIngredients);
            model.addAttribute("response", cachedValue.get());
        } else {
            logger.info("Cache miss for default ingredients: {}", defaultIngredients);
            try {
                Object response = apiService.getRecipesByIngredients(defaultIngredients);
                model.addAttribute("response", response);
            } catch (ApiException e) {
                logger.error("Error fetching recipes for default ingredients: {}", defaultIngredients, e);
                model.addAttribute("response", "Error fetching recipes.");
            }
        }

        return "dashboard";  // Render the dashboard.jsp
    }

    // Handles the /recipes/search route
    @GetMapping("/recipes/search")
    public String getRecipesByIngredients(
            @RequestParam(value = "ingredients", required = false) String ingredients,
            Model model) {

        // Use default ingredients if none are provided in the search
        if (ingredients == null || ingredients.isEmpty()) {
            ingredients = "apples,flour,sugar";
        }

        // Check if the value is already in the cache for the searched ingredients
        Cache cache = cacheManager.getCache("recipes");
        Cache.ValueWrapper cachedValue = cache.get(ingredients);

        if (cachedValue != null) {
            logger.info("Cache hit for ingredients: {}", ingredients);
            model.addAttribute("response", cachedValue.get());
        } else {
            logger.info("Cache miss for ingredients: {}", ingredients);
            try {
                Object response = apiService.getRecipesByIngredients(ingredients);
                model.addAttribute("response", response);
            } catch (ApiException e) {
                logger.error("Error fetching recipes for ingredients: {}", ingredients, e);
                model.addAttribute("response", "Error fetching recipes.");
            }
        }

        return "ingredient-search-results";  // Render the ingredient-search-results.jsp
    }

    @GetMapping("/recipes/complex-search")
    public String getRecipes(
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "cuisine", required = false) String cuisine,
            @RequestParam(value = "diet", required = false) String diet,
            @RequestParam(value = "intolerances", required = false) String intolerances,
            @RequestParam(value = "exclude-ingredients", required = false) String excludeIngredients,
            Model model) {


        Cache cache = cacheManager.getCache("recipes");
        Cache.ValueWrapper cachedValue = cache.get(query);

        if (cachedValue != null) {
            logger.info("Cache hit for query: {}", query);
            model.addAttribute("response", cachedValue.get());
        } else {
            logger.info("Cache miss for query: {}", query);
            try {
                Object response = apiService.getRecipes(query, cuisine, excludeIngredients, diet, intolerances);

                Map<String, Object> responseMap = (Map<String, Object>) response;
                List<Map<String, Object>> resultsList = (List<Map<String, Object>>) responseMap.get("results");

                List<Recipe> recipes = new ArrayList<>();
                for (Map<String, Object> result : resultsList) {
                    Recipe recipe = new Recipe();
                    recipe.setTitle((String) result.get("title"));
                    recipe.setImage((String) result.get("image"));
                    recipe.setSourceUrl((String) result.get("sourceUrl"));
                    recipe.setReadyInMinutes((Double) result.get("readyInMinutes"));
                    recipe.setServings((Double) result.get("servings"));
                    recipe.setId((Double) result.get("id"));
                    recipes.add(recipe);
                }

                model.addAttribute("response", recipes);
                cache.put(query, recipes); // Store the response in the cache
            } catch (ApiException e) {
                logger.error("Error fetching recipes for query: {}", query, e);
                model.addAttribute("response", "Error fetching recipes.");
            }
        }
        return "complex-search-results";
    }


        // Endpoint to get detailed recipe information by ID
    @GetMapping("/recipes/{recipeId}/information")
    public String getRecipeInformation(@PathVariable("recipeId") String recipeIdString, Model model, HttpSession session) {
        try {
            // Convert recipeIdString (e.g., "632660.0") to long by splitting at the decimal point and parsing the integer part
            long recipeId = Long.parseLong(recipeIdString.split("\\.")[0]);



            Object recipeInfo = apiService.getRecipeInformation(recipeId, false);
            System.out.println(recipeInfo);
            model.addAttribute("recipeInfo", recipeInfo);

            Double averageRating = ratingService.getAverageRating((double) recipeId);
            model.addAttribute("averageRating", averageRating != null ? averageRating : "No ratings yet");

            Long currentUserId = (Long) session.getAttribute("userId");
            model.addAttribute("raterId", currentUserId);



        } catch (ApiException e) {
            model.addAttribute("error", "Error fetching recipe information: " + e.getMessage());
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Invalid recipe ID format: " + recipeIdString);
        }

        return "recipe-details";
    }
}
