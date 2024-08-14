package com.carcon.service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;


import com.carcon.dao.Role;
import com.carcon.dao.User;
import com.carcon.repository.BidRepository;
import com.carcon.repository.CarSaleRepository;
import com.carcon.repository.RoleRepository;
import com.carcon.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {

	@Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository; // New dependency for role

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private CarSaleRepository carSaleRepository;
    
    // Inject the UserRepository via constructor
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void registerUser(User user) {
        // Encrypt the user's password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // Load the "Users" role from the database
        Role userRole = roleRepository.findByName("User");

        // If the role exists, assign it to the user
        if (userRole != null) {
            user.setRoles(Collections.singleton(userRole)); // Set the user's roles
        } else {
            throw new RuntimeException("Role 'Users' not found in the database");
        }

        // Save the user in the repository
        userRepository.save(user);
    }
    
    public void save(User user) {
        // Save user to the database
        userRepository.save(user);
    }
    
    public boolean authenticate(String email, String password) {
        // Look up the user by email
        User user = userRepository.findByEmail(email);
        
        // Check if the user exists and verify the password using the PasswordEncoder
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return true; // Authentication successful
        }
        return false; // Authentication failed
    }
    
    public User getCurrentUser() {
        // Get the authentication object from the security context
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        
        if (authentication != null && authentication.isAuthenticated()) {
            // Get the username (or principal) from the authentication object
            String username = authentication.getName();
            
            User user = userRepository.findByUserName(username);
            if (user != null) {
                return user;
            }
        }
        
        // Return null if there's no authenticated user
        return null;
    }
    
    public List<User> getAllUsers() {
        // Use the repository method findAll() to fetch all users
        return userRepository.findAll();
    }
    
    public boolean changeUserRole(Long userId, String newRole) {
        // Find the user by ID
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            
            // Find the role by name
            Role role = roleRepository.findByName(newRole);
            if (role != null) {
                // Set the new role to the user
                user.setRoles(Collections.singleton(role));
                userRepository.save(user);
                return true; // Role change successful
            }
        }
        return false; // Role change failed
    }

    @Transactional
    public boolean deleteUser(Long userId) {
        // Delete all Bids associated with the user
        bidRepository.deleteAllByUserId(userId);

        // Delete all CarSales associated with the user
        carSaleRepository.deleteAllByUserId(userId);

        // Finally, delete the user itself
        try {
            userRepository.deleteById(userId);
            return true; // Return true if deletion is successful
        } catch (Exception e) {
            // Log the exception (use a proper logging mechanism)
            System.err.println("Failed to delete user: " + e.getMessage());
            return false; // Return false if there was an error
        }
    }
    
    // Method to check if a username exists
    public boolean isUsernameExists(String userName) {
        return userRepository.existsByUserName(userName);
    }

    // Method to check if an email exists
    public boolean isEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }




}
