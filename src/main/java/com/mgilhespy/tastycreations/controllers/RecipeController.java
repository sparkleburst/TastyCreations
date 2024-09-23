package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.Recipe;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.repositories.RecipeRepository;
import com.mgilhespy.tastycreations.services.ApiService;
import com.mgilhespy.tastycreations.services.RecipeService;
import com.spoonacular.client.ApiException;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class RecipeController {
    private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);

    @Autowired
    private ApiService apiService;

    @Autowired
    private CacheManager cacheManager;  // Inject Spring's CacheManager

    @Autowired
    private RecipeService recipeService;

    @Autowired
    private RecipeRepository recipeRepository;

    // Dashboard page
    @GetMapping("/recipes/dashboard")
    public String getDashboard(Model model) {
        return "dashboard";
    }

    // Search recipes
    @GetMapping("/recipes/search")
    public String searchRecipes(
            @RequestParam(value = "ingredients", required = false) String ingredients,
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "cuisine", required = false) String cuisine,
            @RequestParam(value = "diet", required = false) String diet,
            @RequestParam(value = "intolerances", required = false) String intolerances,
            @RequestParam(value = "excludeIngredients", required = false) String excludeIngredients,
            Model model) {

        // If no search parameters are provided, stay on the dashboard
        if ((ingredients == null || ingredients.trim().isEmpty()) &&
                (query == null || query.trim().isEmpty()) &&
                (cuisine == null || cuisine.trim().isEmpty()) &&
                (diet == null || diet.trim().isEmpty()) &&
                (intolerances == null || intolerances.trim().isEmpty()) &&
                (excludeIngredients == null || excludeIngredients.trim().isEmpty())) {
            logger.info("No search parameters provided. Displaying empty search page.");
            model.addAttribute("message", "Please enter search terms to find recipes.");
            return "dashboard";  // Render the dashboard without search results
        }

        // Construct a cache key based on the search parameters
        String cacheKey = String.join("-", ingredients, query, cuisine, diet, intolerances, excludeIngredients);
        Cache cache = cacheManager.getCache("recipes");
        Cache.ValueWrapper cachedValue = cache.get(cacheKey);

        if (cachedValue != null) {
            logger.info("Cache hit for search: {}", cacheKey);
            model.addAttribute("response", cachedValue.get());
            return "search-results";  // Goes to search results page when the data is from cache

        } else {
            logger.info("Cache miss for search: {}", cacheKey);
            try {
                Object response = apiService.searchRecipes(ingredients, query, cuisine, diet, intolerances, excludeIngredients);

                // Check if valid recipes are returned (Adjust validation based on the API response structure)
                if (response instanceof List && !((List<?>) response).isEmpty()) {
                    model.addAttribute("response", response);
                    cache.put(cacheKey, response);  // Store the response in the cache
                    return "search-results";  // Render the search-results.jsp if recipes are found
                } else {
                    logger.info("No recipes found for the search.");
                    model.addAttribute("message", "No recipes found. Please try different search terms.");
                    return "dashboard";  // Stay on the dashboard if no recipes are found
                }
            } catch (ApiException e) {
                logger.error("Error fetching recipes for search: {}", cacheKey, e);
                model.addAttribute("message", "Error fetching recipes. Please try again later.");
                return "dashboard";  // Stay on the dashboard if there's an error
            }
        }
    }

    // Recipe details page, retrieve recipe info, and avoid saving unnecessary details
    @GetMapping("/recipes/{id}/information")
    public String getRecipeInformation(@PathVariable("id") String recipeIdString, Model model) {
        try {
            // Convert the recipe ID from String to double (removing any decimal part if present)
            double apiIdDouble = Double.parseDouble(recipeIdString.split("\\.")[0]);

            // Cast or convert the double to long (since API expects long)
            long apiId = (long) apiIdDouble;

            // Fetch the recipe information from the Spoonacular API
            Object apiResponse = apiService.getRecipeInformation(apiId, false);

            if (apiResponse instanceof Map) {
                Map<String, Object> recipeData = (Map<String, Object>) apiResponse;

                // Directly pass the recipe data to the model
                model.addAttribute("recipeInfo", recipeData);
            } else {
                model.addAttribute("error", "Invalid response format from API.");
            }

            // Fetch the recipe from the database for likedByUsers
            Optional<Recipe> recipeOptional = recipeRepository.findByApiId(apiIdDouble);
            if (recipeOptional.isPresent()) {
                Recipe recipe = recipeOptional.get();  // Extract Recipe from Optional
                model.addAttribute("likedByUsers", recipe.getLikedByUsers());
                model.addAttribute("likeCount", recipe.getLikedByUsers().size());  // Pass the like count
            } else {
                model.addAttribute("likedByUsers", List.of());  // Empty list if the recipe is not in the database yet
                model.addAttribute("likeCount", 0);  // Set like count to 0 if the recipe isn't in the database yet
            }

        } catch (ApiException e) {
            model.addAttribute("error", "Error fetching recipe information: " + e.getMessage());
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Invalid recipe ID format: " + recipeIdString);
        }

        return "recipe-details";
    }

    // Like/Unlike a recipe
    @PostMapping("/recipes/{recipeId}/like")
    public String toggleLikeRecipe(@PathVariable("recipeId") Long recipeId,
                                   HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);  // Check if user is logged in
        if (user == null) {
            return "redirect:/login";  // Redirect to login if not logged in
        }

        // Check if the recipe already exists in the local database
        Optional<Recipe> existingRecipe = recipeRepository.findByApiId(recipeId.doubleValue());

        Recipe recipe;
        if (existingRecipe.isPresent()) {
            recipe = existingRecipe.get();
        } else {
            try {
                // Fetch the recipe from the Spoonacular API
                Object apiResponse = apiService.getRecipeInformation(recipeId, false);

                if (apiResponse instanceof Map) {
                    Map<String, Object> recipeData = (Map<String, Object>) apiResponse;

                    if (recipeData != null) {
                        // Create a new recipe and save it locally
                        recipe = new Recipe();
                        recipe.setApiId(((Number) recipeData.get("id")).longValue());  // Extract the API ID
                        recipe.setTitle((String) recipeData.get("title"));
                        recipe.setImage((String) recipeData.get("image"));
                        recipe.setSourceUrl((String) recipeData.get("sourceUrl"));

                        // Save the new recipe to the local database
                        recipe = recipeRepository.save(recipe);
                    } else {
                        // Handle the case where the API response does not contain valid recipe data
                        redirectAttributes.addFlashAttribute("error", "Invalid recipe data received from API.");
                        return "redirect:/recipes";
                    }
                } else {
                    // Log an error if the response is not in the expected format
                    redirectAttributes.addFlashAttribute("error", "Failed to retrieve recipe information from the API.");
                    return "redirect:/recipes";  // Redirect back to recipe listing
                }
            } catch (ApiException e) {
                redirectAttributes.addFlashAttribute("error", "Error fetching recipe from API: " + e.getMessage());
                return "redirect:/recipes";
            }
        }

        // Now that we have the recipe (either from DB or API), handle the like/unlike functionality
        if (recipe.getLikedByUsers().contains(user)) {
            // If the user already liked the recipe, unlike it
            recipeService.unlikeRecipe(recipe, user);
            logger.info("User {} removed from liked users for recipe {}", user.getId(), recipe.getId());
        } else {
            // If the user hasn't liked the recipe yet, like it
            recipeService.likeRecipe(recipe, user);
            logger.info("User {} added to liked users for recipe {}", user.getId(), recipe.getId());
        }

        // Save the updated recipe
        recipeRepository.save(recipe);

        // Redirect back to the recipe details page using the API ID
        return "redirect:/recipes/" + recipe.getApiId() + "/information";  // Using recipe.getApiId() instead of apiId
    }

    private User getLoggedInUser(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser != null) {
            System.out.println("Logged in user: " + loggedInUser.getId() + ", " + loggedInUser.getEmail());
        } else {
            System.out.println("No logged in user found in session.");
        }

        return loggedInUser;
    }
}
