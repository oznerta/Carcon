package com.carcon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.carcon.dao.User;

@Controller
public class AuthenticationController {
    
	@GetMapping("/sigin")
    public String loginPage(Model model) {
        model.addAttribute("user", new User());
        return "sign-in";
    }
	

	@GetMapping("/signin_error")
	public String onLoginError(Model model) {
	    // Define the error message and type
	    String errorMessage = "Sign in failed. Please try again.";
	    String notificationType = "error"; // Define the type of the notification

	    // Add the error message and type to the model
	    model.addAttribute("notificationMessage", errorMessage);
	    model.addAttribute("notificationType", notificationType);

	    // Return the view name for the sign-in page
	    return "sign-in";
	}



    
    @GetMapping("/portal")
    public String signIn() {
        return "sign-in";
    }
}
