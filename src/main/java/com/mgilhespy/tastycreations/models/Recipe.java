package com.mgilhespy.tastycreations.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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


}
