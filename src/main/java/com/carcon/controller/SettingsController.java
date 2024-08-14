package com.carcon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carcon.dao.User;
import com.carcon.service.UserService;


@Controller
public class SettingsController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public SettingsController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/settings")
    public String showSettingsPage(Model model) {
        // Get the current user
        User currentUser = userService.getCurrentUser();

        // Add the user to the model
        model.addAttribute("user", currentUser);

        // Return the view name for the settings page
        return "settings";
    }

    @PostMapping("/settings")
    public String updateUserCredentials(@RequestParam("email") String email,
                                        @RequestParam("password") String password,
                                        Model model) {
        // Get the current user
        User currentUser = userService.getCurrentUser();

        // Update the user's email
        currentUser.setEmail(email);

        // Update the user's password if provided
        if (password != null && !password.isEmpty()) {
            // Encode the new password before saving
            currentUser.setPassword(passwordEncoder.encode(password));
        }

        // Save the updated user information
        userService.save(currentUser);

        // Optionally, you can add a success message to the model to be displayed in the view
        model.addAttribute("successMessage", "Settings updated successfully!");

        // Redirect back to the settings page
        return "redirect:/settings";
    }
}

