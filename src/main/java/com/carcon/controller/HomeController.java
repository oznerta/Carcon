package com.carcon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carcon.dao.Bid;
import com.carcon.dao.CarSale;
import com.carcon.dao.User;
import com.carcon.service.BidService;
import com.carcon.service.CarSaleService;
import com.carcon.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
    private CarSaleService carSaleService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BidService bidService;


	@GetMapping("/home")
	public String showCars(Model model) {
	    // Use your method to get the current user
	    User currentUser = userService.getCurrentUser();
	    
	    // Add the current user to the model
	    model.addAttribute("user", currentUser);
	    
	    // Get the list of cars
	    List<CarSale> cars = carSaleService.findAllCars();

	    // Calculate the highest bid amount for each car sale and set it in the car sale object
	    for (CarSale car : cars) {
	        List<Bid> bidHistory = bidService.getBidHistoryForCarSale(car.getId());

	        // Calculate the highest bid amount
	        Double highestBidAmount = bidHistory.stream()
	            .map(Bid::getAmount)
	            .max(Double::compare)
	            .orElse(car.getBidding()); // Use the initial bidding amount if no bids are present

	        // Set the highest bid amount in the CarSale object
	        car.setHighestBidAmount(highestBidAmount);
	    }

	    // Add the list of cars with the highest bid amount set in each car sale to the model
	    model.addAttribute("cars", cars);
	    
	    // Return the view name
	    return "browse-cars";
	}

	
	 
	
	 
	 @GetMapping("/home/search")
	    public String searchCars(@RequestParam String query, Model model) {
	        // Fetch the filtered list of cars based on the search query
	        List<CarSale> filteredCars = carSaleService.searchCars(query);
	        
	        // Add the filtered list of cars to the model
	        model.addAttribute("cars", filteredCars);
	        
	        // Add the search query to the model to use it in the view
	        model.addAttribute("searchQuery", query);

	        // Return the view name (home page with the search results)
	        return "browse-cars";
	}


    @GetMapping("/sign-up")
    public String signUp() {
        return "sign-up";
    }
    
    
}
