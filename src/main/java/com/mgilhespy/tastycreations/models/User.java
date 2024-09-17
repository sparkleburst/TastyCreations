package com.mgilhespy.tastycreations.models;

import com.mgilhespy.tastycreations.constraints.AgeLimit;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty(message = "First Name is required!")
    @Size(min = 3, max = 30, message = "First Name must be between 3 and 20 characters")
    private String firstName;

    @NotEmpty(message = "Last Name is required!")
    @Size(min = 3, max = 30, message = "Last Name must be between 3 and 20 characters")
    private String lastName;

    @NotEmpty(message = "Email is required!")
    @Email(regexp = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$", message="Please enter a valid email!")
    private String email;


    @NotNull(message = "The date of birth is required.")
    @Past(message = "The date of birth must be in the past.")
    @AgeLimit(minimumAge = 10, message = "The minimum age to join is 10.")
    private LocalDate birthDate;

    @NotEmpty(message="Password is required!")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,128}$", message = "Needs 1 of each: lowercase, uppercase, number, and special Character")
    private String password;

    @Transient
    @NotEmpty(message="Confirm Password is required!")
    @Size(min = 8, max=20, message = "Confirm password must be between 8 and 20 characters")
    private String confirmPassword;

    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;

    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}
