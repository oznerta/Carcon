package com.carcon.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carcon.dao.User;
import com.carcon.service.UserService;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;
    
    

    @PostMapping("/signup")
    public String registerUser(@ModelAttribute User user) {
        // Check if the username or email already exists
        if (userService.isUsernameExists(user.getUserName())) {
            // Redirect to the signup error page with a message for the existing username
            return "redirect:/signup_error?message=Sign up Failed. Username already exists.";
        } else if (userService.isEmailExists(user.getEmail())) {
            // Redirect to the signup error page with a message for the existing email
            return "redirect:/signup_error?message=Sign up Failed. Email already exists.";
        }

        // Register the user if no conflicts found
        userService.registerUser(user);

        // Specify the path to the root directory
        String rootDirectoryPath = "D:\\STS WORKSPACE\\Carcon\\src\\main\\resources\\static\\UsersData";

        // Create a directory for the new user if it doesn't already exist
        File userDirectory = new File(rootDirectoryPath + "\\" + user.getUserName());
        if (!userDirectory.exists()) {
            userDirectory.mkdirs();
        }

        // Redirect the user to the home page
        return "redirect:/home";
    }

    @GetMapping("/signup_error")
    public String onSignupError(@RequestParam String message, Model model) {
        // Add the error message and type to the model
        model.addAttribute("notificationMessage", message);
        model.addAttribute("notificationType", "error");

        // Return the view name for the sign-up error page
        return "sign-in";
    }


}