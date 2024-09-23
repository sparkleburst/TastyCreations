package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.LoginUser;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.repositories.UserRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepo;

    public UserService(UserRepository userRepository) {
        this.userRepo = userRepository;
    }

    public User register(User user, BindingResult bindingResult) {
        Optional<User> optionalUser = this.userRepo.findByEmail(user.getEmail());

        if (optionalUser.isPresent()) {
            bindingResult.rejectValue("email", "email.exists", "Email already exists.");
        }

        if (!user.getPassword().equals(user.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "password.not.match", "Passwords do not match.");
        }

        if (bindingResult.hasErrors()) {
            return null;
        }

        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        return this.userRepo.save(user);
    }

    public User login(LoginUser loginUser, BindingResult result) {
        Optional<User> potentialUser = userRepo.findByEmail(loginUser.getLoginEmail());

        // Check if user exists
        if(potentialUser.isEmpty()) {
            result.rejectValue("loginEmail", "email.not-found", "Email does not exist!");
            return null;
        }

        User user = potentialUser.get();

        // Check if password matches
        if (!BCrypt.checkpw(loginUser.getLoginPassword(), user.getPassword())) {
            result.rejectValue("loginPassword", "Matches", "Invalid Password!");
            return null;
        }

        // Check for any errors
        if (result.hasErrors()) {
            return null;
        }

        return user;
    }

    public User findUserById(Long id) {
        Optional<User> optionalUser = this.userRepo.findById(id);
        return optionalUser.orElse(null);
    }
}
