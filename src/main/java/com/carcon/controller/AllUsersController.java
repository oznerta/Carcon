package com.carcon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.carcon.dao.User;
import com.carcon.service.UserService;


@Controller
public class AllUsersController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/registered-users")
	public String showAllUsers(Model model) {
		 // Use your method to get the current user
	    User currentUser = userService.getCurrentUser();
	    
	    // Add the current user to the model
	    model.addAttribute("user", currentUser);
	    
	    // Fetch all users from the UserService and add them to the model
        List<User> allUsers = userService.getAllUsers(); 
        
        // Filter out the current user's account from the list of users
        allUsers.removeIf(user -> user.getId().equals(currentUser.getId()));

        // Add the filtered list of users to the model
        model.addAttribute("users", allUsers);
	    
		return "registered-users";
	}
}
