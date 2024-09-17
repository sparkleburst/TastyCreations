package com.mgilhespy.tastycreations.models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginUser {

    @NotEmpty(message="Email is required!")
    @Email(message = "Please enter a valid email")
    private String loginEmail;

    @NotEmpty(message="Password is required!")
    @Size(min = 8, max=20, message = "Password must be between 8 and 20 characters")
    private String loginPassword;
}
