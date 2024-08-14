package com.carcon.controller;

import java.io.IOException;
import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.carcon.dao.CarSale;
import com.carcon.dao.User;
import com.carcon.repository.CarSaleRepository;
import com.carcon.service.FileUploadService;
import com.carcon.service.UserService;


@Controller
public class SellCarController {
	
	@Autowired
	private UserService userService;
	
	
	@Autowired
	private CarSaleRepository carSaleRepository;

	@Autowired
	private FileUploadService fileUploadService;


    @GetMapping("/sell-a-car")
    public String showSellCarPage(Model model) {
    	// Use your method to get the current user
        User currentUser = userService.getCurrentUser();
        
        // Add the current user to the model
        model.addAttribute("user", currentUser);
        
        return "sell-a-car";
    }
    
    @PostMapping("/upload-car")
    public String uploadCar(
    	    @RequestParam("make") String make,
    	    @RequestParam("model") String carModel,
    	    @RequestParam("registration") String registration,
    	    @RequestParam("bidding") Double bidding,
    	    @RequestParam("photos") MultipartFile[] photos,
    	    Model uiModel) throws IOException {
    	    
    	    try {
    	    	
    	    	// Create a new CarSale entity
    	    	CarSale carSale = new CarSale();
        	    carSale.setMake(make);
        	    carSale.setModel(carModel);
        	    carSale.setRegistration(registration);
        	    carSale.setBidding(bidding);
        	    
        	    // Explicitly set the status of the car sale to "Open"
                carSale.setStatus(CarSale.Status.OPEN);
        	    
        	    // Initialize the photos collection if not already initialized
        	    if (carSale.getPhotos() == null) {
        	        carSale.setPhotos(new HashSet<>());
        	    }

        	    // Get the current user using UserService
        	    User currentUser = userService.getCurrentUser();
        	    carSale.setUser(currentUser);

        	    // Save the CarSale entity first
        	    carSaleRepository.save(carSale);

        	    // Handle file upload and save images
        	    fileUploadService.handleFileUpload(carSale, photos, currentUser);
        	    

        	    // Redirect to the home page or wherever you want
        	    return "redirect:/home";
        	    
    	    } catch (Exception e) {
    	    	return "redirect:/home";
    	    }
    	}




}
