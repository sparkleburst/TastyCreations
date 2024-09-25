package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Ingredient;
import com.mgilhespy.tastycreations.models.Recipe;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class MockApiService {

    // Create a hardcoded recipe
    public Recipe createMockRecipe() {
        // Mock list of used ingredients
        List<Ingredient> usedIngredients = Arrays.asList(
                new Ingredient("1 Tomato", "Tomato", "tomato.jpg"),
                new Ingredient("50g Cheese", "Cheese", "cheese.jpg")
        );

        // Mock list of missed ingredients
        List<Ingredient> missedIngredients = Arrays.asList(
                new Ingredient("1 Onion", "Onion", "onion.jpg")
        );

        // Mock list of extended ingredients (for detailed view)
        List<Ingredient> extendedIngredients = Arrays.asList(
                new Ingredient("400g Spaghetti", "Spaghetti", "spaghetti.jpg"),
                new Ingredient("250g Minced Meat", "Minced Meat", "minced_meat.jpg"),
                new Ingredient("2 Garlic Cloves", "Garlic", "garlic.jpg"),
                new Ingredient("1 can of Tomatoes", "Tomatoes", "tomatoes.jpg")
        );

        return new Recipe(
                1.0,  // Recipe ID
                "Mock Spaghetti Bolognese",  // Title
                "https://via.placeholder.com/150",  // Image
                "https://mockrecipeurl.com",  // Source URL
                30.0,  // Ready in minutes
                4.0,  // Servings
                usedIngredients.size(),  // Used ingredient count
                missedIngredients.size(),  // Missed ingredient count
                usedIngredients,  // Used ingredients list
                missedIngredients,  // Missed ingredients list
                extendedIngredients,  // Extended ingredients list
                "1. Boil the spaghetti.\n2. Fry the minced meat.\n3. Add tomatoes and garlic.\n4. Simmer for 15 minutes and serve." // Instructions
        );
    }

    public List<Recipe> getMockRecipes() {
        return Arrays.asList(createMockRecipe());
    }

    public List<Recipe> getRecipesByIngredients(String ingredients) {
        return Arrays.asList(createMockRecipe());
    }

    public List<Recipe> getRecipes(String query, String cuisine, String diet, String intolerances, String excludeIngredients) {
        return Arrays.asList(createMockRecipe());
    }

    public Recipe getRecipeInformation(long recipeId, boolean includeNutrition) {
        return createMockRecipe();
    }
}
