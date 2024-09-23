package com.mgilhespy.tastycreations.services;

import com.spoonacular.DefaultApi;
import com.spoonacular.client.ApiClient;
import com.spoonacular.client.ApiException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.math.BigDecimal;

@Service
public class ApiService {
    // Create a logger instance for this class
    private static final Logger logger = LoggerFactory.getLogger(ApiService.class);

    @Autowired
    private RestTemplate restTemplate;

    @Getter
    @Value("${api.key}")
    private String apiKey;

    private final String BASE_URL = "https://api.spoonacular.com/recipes/";

    @Cacheable("recipes")
    public Object getRecipesByIngredients(String ingredients) throws ApiException {
        logger.debug("Fetching recipes with ingredients: {}", ingredients);

        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);
        Object result = null;

        BigDecimal number = BigDecimal.valueOf(10); // BigDecimal | The maximum number of recipes to return (between 1 and 100). Defaults to 10.
        Boolean limitLicense = true; // Boolean | Whether the recipes should have an open license that allows display with proper attribution.
        BigDecimal ranking = BigDecimal.valueOf(1); // BigDecimal | Whether to maximize used ingredients (1) or minimize missing ingredients (2) first.
        Boolean ignorePantry = true; // Boolean | Whether to ignore typical pantry items, such as water, salt, flour, etc.

        try {
            result = apiInstance.searchRecipesByIngredients(ingredients, number, limitLicense, ranking, ignorePantry);
            logger.debug("Recipes fetched successfully for ingredients: {}", ingredients);
            logger.debug("Response: {}", result);  // Logs the API response for debugging
//            System.out.println(result);
        } catch (ApiException e) {
            logger.error("Exception when calling DefaultApi#searchRecipesByIngredients: {}", e.getResponseBody(), e);
//            System.err.println("Exception when calling DefaultApi#searchRecipesByIngredients");
//            e.printStackTrace();
        }
        return result;
    }

    @Cacheable("recipes")
    public Object getRecipes(String query, String cuisine, String diet, String intolerances, String excludeIngredients) throws ApiException {
//        logger.debug("Fetching recipes with ingredients: {}", ingredients);

        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);
        Object result = null;

//        String query = "burger"; // String | The (natural language) search query.
//        String cuisine = "italian"; // String | The cuisine(s) of the recipes. One or more, comma separated (will be interpreted as 'OR'). See a full list of supported cuisines.
//        String diet = "vegetarian"; // String | The diet for which the recipes must be suitable. See a full list of supported diets.
//        String intolerances = "gluten"; // String | A comma-separated list of intolerances. All recipes returned must not contain ingredients that are not suitable for people with the intolerances entered. See a full list of supported intolerances.
//        String excludeIngredients = "eggs"; // String | A comma-separated list of ingredients or ingredient types that the recipes must not contain.

        Boolean instructionsRequired = true; // Boolean | Whether the recipes must have instructions.
        BigDecimal number = BigDecimal.valueOf(10); // BigDecimal | The number of results to return (between 1 and 100).
        BigDecimal offset = BigDecimal.valueOf(0); // BigDecimal | The number of results to skip (between 0 and 900).
        Boolean limitLicense = true; // Boolean | Whether the recipes should have an open license that allows display with proper attribution.


        try {
            result = apiInstance.searchRecipes(query, cuisine, diet, excludeIngredients, intolerances, offset, number, limitLicense, instructionsRequired);
//            logger.debug("Recipes fetched successfully for ingredients: {}", ingredients);
            logger.debug("Response: {}", result);  // Logs the API response for debugging
        } catch (ApiException e) {
            logger.error("Exception when calling DefaultApi#searchRecipes: {}", e.getResponseBody(), e);
        }
        return result;
    }

    @Cacheable("recipes")
    public Object getRecipeInformation(long recipeId, boolean includeNutrition) throws ApiException {
        String url = BASE_URL + recipeId + "/information?includeNutrition=" + includeNutrition + "&apiKey=" + apiKey;

        try {
            return restTemplate.getForObject(url, Object.class);  // Remember that you can map the response to a more specific object instead of Object.class
        } catch (Exception e) {
            throw new ApiException();
        }
    }

}
