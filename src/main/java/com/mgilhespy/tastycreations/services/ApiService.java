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
    private MockApiService mockApiService;

    @Autowired
    private RestTemplate restTemplate;

    @Getter
    @Value("${api.key}")
    private String apiKey;

    // Flag to control whether to use the mock API or the real API
    private boolean useMockApi = true; // Set this to true to use mock data

    private final String BASE_URL = "https://api.spoonacular.com/recipes/";

    @Cacheable("recipes")
    public Object getRecipesByIngredients(String ingredients) throws ApiException {
        if (useMockApi) {
            logger.debug("** Mock API is being used for getRecipesByIngredients **");
            return mockApiService.getRecipesByIngredients(ingredients);
        }
        logger.debug("** Real API is being used for getRecipesByIngredients **");
        logger.debug("Fetching recipes with ingredients: {}", ingredients);

        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);
        Object result = null;

        BigDecimal number = BigDecimal.valueOf(10);
        Boolean limitLicense = true;
        BigDecimal ranking = BigDecimal.valueOf(1);
        Boolean ignorePantry = true;

        try {
            result = apiInstance.searchRecipesByIngredients(ingredients, number, limitLicense, ranking, ignorePantry);
            logger.debug("Recipes fetched successfully for ingredients: {}", ingredients);
            logger.debug("Response: {}", result);
        } catch (ApiException e) {
            logger.error("Exception when calling DefaultApi#searchRecipesByIngredients: {}", e.getResponseBody(), e);
        }
        return result;
    }

    @Cacheable("recipes")
    public Object getRecipes(String query, String cuisine, String diet, String intolerances, String excludeIngredients) throws ApiException {
        if (useMockApi) {
            logger.debug("** Mock API is being used for getRecipes **");
            return mockApiService.getRecipes(query, cuisine, diet, intolerances, excludeIngredients);
        }
        logger.debug("** Real API is being used for getRecipes **");
        logger.debug("Fetching recipes with query: {}", query);

        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);
        Object result = null;

        Boolean instructionsRequired = true;
        BigDecimal number = BigDecimal.valueOf(10);
        BigDecimal offset = BigDecimal.valueOf(0);
        Boolean limitLicense = true;

        try {
            result = apiInstance.searchRecipes(query, cuisine, diet, excludeIngredients, intolerances, offset, number, limitLicense, instructionsRequired);
            logger.debug("Recipes fetched successfully for query: {}", query);
            logger.debug("Response: {}", result);
        } catch (ApiException e) {
            logger.error("Exception when calling DefaultApi#searchRecipes: {}", e.getResponseBody(), e);
        }
        return result;
    }

    @Cacheable("recipes")
    public Object getRecipeInformation(long recipeId, boolean includeNutrition) throws ApiException {
        if (useMockApi) {
            logger.debug("** Mock API is being used for getRecipeInformation **");
            return mockApiService.getRecipeInformation(recipeId, includeNutrition);
        }
        logger.debug("** Real API is being used for getRecipeInformation **");

        String url = BASE_URL + recipeId + "/information?includeNutrition=" + includeNutrition + "&apiKey=" + apiKey;

        try {
            return restTemplate.getForObject(url, Object.class);
        } catch (Exception e) {
            logger.error("Exception when fetching recipe information", e);
            throw new ApiException();
        }
    }
}
