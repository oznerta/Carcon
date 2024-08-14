package com.carcon.controller;


import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.carcon.dao.Bid;
import com.carcon.dao.CarSale;
import com.carcon.dao.Image;
import com.carcon.dao.User;
import com.carcon.service.BidService;
import com.carcon.service.CarSaleService;
import com.carcon.service.UserService;
import jakarta.servlet.http.HttpServletRequest;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


@Controller
@RequestMapping("/cars")
public class CarController {

	private final CarSaleService carSaleService;
    private final BidService bidService;
    private final UserService userService;

    public CarController(CarSaleService carSaleService, BidService bidService, UserService userService) {
        this.carSaleService = carSaleService;
        this.bidService = bidService;
        this.userService = userService;
    }

    @GetMapping("/{carId}")
    public String viewCarDetails(@PathVariable("carId") Long carId, Model model) {
        // Get the current user
        User currentUser = userService.getCurrentUser();
        model.addAttribute("user", currentUser);

        // Get the car details and bid history
        CarSale car = carSaleService.findById(carId);
        List<Bid> bidHistory = bidService.getBidHistoryForCarSale(carId);

        // Determine if the current user is the owner of the car sale
        boolean isOwner = currentUser != null && car.getUser() != null && currentUser.getId().equals(car.getUser().getId());
        model.addAttribute("isOwner", isOwner);

        // Add the seller's user object to the model
        User seller = car.getUser();
        model.addAttribute("seller", seller);

        // Format bid history date and time
        DateTimeFormatter bidFormatter = DateTimeFormatter.ofPattern("MM-dd-yy hh:mm a");
        for (Bid bid : bidHistory) {
            LocalDateTime localDateTime = bid.getDateTime();
            String formattedDateTime = localDateTime.format(bidFormatter);
            bid.setFormattedDateTime(formattedDateTime);
        }

        // Add car and bid history to the model
        model.addAttribute("car", car);
        model.addAttribute("bidHistory", bidHistory);

        // Format `bidEndTime` and calculate remaining time
        if (car.getBidEndTime() != null) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime bidEndTime = car.getBidEndTime();

            // Calculate remaining time
            Duration remainingDuration = Duration.between(now, bidEndTime);
            long days = remainingDuration.toDaysPart();
            long hours = remainingDuration.toHoursPart();
            long minutes = remainingDuration.toMinutesPart();

            // Pass the remaining time as attributes to the model
            model.addAttribute("remainingDays", days);
            model.addAttribute("remainingHours", hours);
            model.addAttribute("remainingMinutes", minutes);

            // Format bid end time using ISO local date-time standard
            DateTimeFormatter isoFormatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
            String formattedBidEndTime = bidEndTime.format(isoFormatter);
            model.addAttribute("bidEndTime", formattedBidEndTime);
        }

        // Return the view name
        return "view-more-details";
    }



    @PostMapping("/{carId}/submit-bid")
    public String submitBid(@PathVariable("carId") Long carId,
                            @RequestParam("bidAmount") Double bidAmount,
                            HttpServletRequest request, Model model) {

    	// Get the current user
        User currentUser = userService.getCurrentUser();

        // Fetch the car sale and check for its existence
        CarSale carSale = carSaleService.findById(carId);
        if (carSale == null) {
            model.addAttribute("error", "Car not found.");
            return "redirect:/cars/" + carId;
        }

        // Check if it's the first bid
        if (carSale.getBidStartTime() == null) {
            // Set bid start time to now
            carSale.setBidStartTime(LocalDateTime.now());

            // Calculate and set bid end time (e.g., 7 days from start time)
            carSale.setBidEndTime(carSale.getBidStartTime().plusDays(7));

            // Save the updated car sale
            carSaleService.saveCarSale(carSale);
        }

        // Create a new bid
        Bid newBid = new Bid();
        newBid.setCarSale(carSale);
        newBid.setUser(currentUser);
        newBid.setAmount(bidAmount);
        // Set the current date and time for the bid
        newBid.setDateTime(LocalDateTime.now());

        // Save the bid using the BidService
        bidService.saveBid(newBid);

        // Redirect the user back to the car details page
        return "redirect:/cars/" + carId;
    }


    @PostMapping("/{carId}/close-bidding")
    public ResponseEntity<String> closeBidding(@PathVariable("carId") Long carId) {
        // Fetch the car sale
        CarSale carSale = carSaleService.findById(carId);
        if (carSale == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Car not found.");
        }

        // Close the bidding by setting the status to "CLOSED"
        carSale.setStatus(CarSale.Status.CLOSED);

        // Save the updated car sale
        carSaleService.saveCarSale(carSale);

        // Return a success response
        return ResponseEntity.ok("Bidding closed.");
    }
    
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<?> deleteCarSales(@RequestBody List<Long> carSaleIds) {
        try {
            // Retrieve car sales to be deleted
            List<CarSale> carSalesToDelete = carSaleService.findAllById(carSaleIds);

            for (CarSale carSale : carSalesToDelete) {
                // Delete the images associated with each car sale
                Set<Image> images = carSale.getPhotos();
                for (Image image : images) {
                    // Delete the image file from the file system
                    Path imagePath = Paths.get(image.getFilePath());
                    Files.deleteIfExists(imagePath);
                }

                // Delete the car sale from the database
                carSaleService.deleteCarSale(carSale);
            }

            // Return a success response
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            // Handle any errors that may occur during deletion
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to delete car sales.");
        }
    }


}
