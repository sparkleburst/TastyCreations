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

    @Cacheable("recipes")
    public Object getRandomFoodJoke() throws ApiException {
        logger.debug("Attempting to fetch a random food joke");

        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);

        Object result = null;
        try {
            result = apiInstance.getARandomFoodJoke();
            logger.debug("Random food joke received: {}", result);
//            System.out.println(result);
        } catch (ApiException e) {
            logger.error("Error fetching random food joke: {}", e.getResponseBody(), e);
//            System.err.println(e.getResponseBody());
//            e.printStackTrace();
        }
        return result;
    }

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

}
