package com.mgilhespy.tastycreations.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "recipes", uniqueConstraints = {@UniqueConstraint(columnNames = {"apiId"})})  // Mapping to the "recipes" table with unique apiId
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // Internal DB ID

    @Column(unique = true)
    private Long apiId; // ID from the API (Spoonacular)

    private String title; // The title of the recipe fetched from the API

    private String image; // The image of the recipe fetched from the API

    private String sourceUrl; // The URL where the original recipe is located (Spoonacular)

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "recipes_users_likes",
            joinColumns = @JoinColumn(name = "recipe_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> likedByUsers = new ArrayList<>();  // Initialize with an empty ArrayList;

    @OneToMany(mappedBy = "recipe", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Rating> ratings;

    @OneToMany(mappedBy = "recipe", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Comment> comments;


}