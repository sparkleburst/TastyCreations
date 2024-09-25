package com.mgilhespy.tastycreations.models;

import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Recipe {
    private double id;
    private String title;
    private String image;
    private String sourceUrl;
    private double readyInMinutes;
    private double servings;

    @Transient
    private int usedIngredientCount;   // For the count of used ingredients

    @Transient
    private int missedIngredientCount; // For the count of missing ingredients

    @Transient
    private List<Ingredient> usedIngredients;  // List of used ingredients

    @Transient
    private List<Ingredient> missedIngredients;  // List of missed ingredients

    @Transient
    private List<Ingredient> extendedIngredients; // List of ingredients for the recipe

    @Transient
    private String instructions;  // Add the instructions field
}
