package com.carcon.controller;

import com.carcon.dao.CarSale;
import com.carcon.dao.User;
import com.carcon.service.CarSaleService;
import com.carcon.service.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class CarListingController {

    private final CarSaleService carSaleService;
    private final UserService userService;

    public CarListingController(CarSaleService carSaleService, UserService userService) {
        this.carSaleService = carSaleService;
        this.userService = userService;
    }

    @GetMapping("/my-car-lists")
    public String viewMyCarListings(Model model) {
        // Obtain the current user from the user service
        User currentUser = userService.getCurrentUser();

        // Add the current user to the model
        model.addAttribute("user", currentUser);

        // Fetch car sales that belong to the current user
        List<CarSale> carSales = carSaleService.findCarSalesByUser(currentUser);

        // Add the list of car sales to the model
        model.addAttribute("carSales", carSales);

        // Return the view name
        return "view-listing";
    }
    
    @GetMapping("/all-car-listing")
    public String getAllCarLists(Model model) {
    	User currentUser = userService.getCurrentUser();

        // Add the current user to the model
        model.addAttribute("user", currentUser);
        
        // Retrieve all car sales from the database
        List<CarSale> allCarSales = carSaleService.getAllCarSales();

        // Add the list of all car sales to the model
        model.addAttribute("carSales", allCarSales);

        // Return the view name
        return "all-car-list";
    }

}
