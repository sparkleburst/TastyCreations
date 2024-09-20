package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.LoginUser;
import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String index(@ModelAttribute("newUser") User newUser, @ModelAttribute("loginUser") LoginUser loginUser) {
        return "index";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
        User user = userService.register(newUser, result);

        if (result.hasErrors()) {
            model.addAttribute("loginUser", new LoginUser());
            model.addAttribute("savedDate", newUser.getBirthDate());
            return "index";
        }
        session.setAttribute("userId", user.getId());
        return "redirect:/recipes/dashboard";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("loginUser") LoginUser loginUser, BindingResult result, Model model, HttpSession session) {
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            model.addAttribute("loginUser", loginUser);
            return "index";
        }

        User potentialUser = this.userService.login(loginUser, result);
        if (potentialUser == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("loginUser", loginUser);
            return "index";
        }

        session.setAttribute("userId", potentialUser.getId());
        return "redirect:/recipes/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
