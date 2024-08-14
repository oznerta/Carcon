package com.carcon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.carcon.dao.CarSale;
import com.carcon.dao.Image;
import com.carcon.dao.User;
import com.carcon.repository.CarSaleRepository;
import com.carcon.repository.ImageRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class CarSaleService {

    @Autowired
    private CarSaleRepository carSaleRepository;

    @Autowired
    private ImageRepository imageRepository;

    // Method to save a CarSale entity
    public CarSale saveCarSale(CarSale carSale) {
        return carSaleRepository.save(carSale);
    }

    // Method to find all cars
    public List<CarSale> findAllCars() {
        return carSaleRepository.findAll();
    }

    // Method to add a photo to a car sale
    public CarSale addPhotoToCarSale(Long carSaleId, Image image) {
        // Fetch the CarSale entity
        CarSale carSale = carSaleRepository.findById(carSaleId)
            .orElseThrow(() -> new EntityNotFoundException("CarSale not found"));
        
        // Add the photo and save the image
        carSale.addPhoto(image);
        imageRepository.save(image);
        
        // Save the updated CarSale entity
        return carSaleRepository.save(carSale);
    }

    // Method to remove a photo from a car sale
    public CarSale removePhotoFromCarSale(Long carSaleId, Long imageId) {
        // Fetch the CarSale entity
        CarSale carSale = carSaleRepository.findById(carSaleId)
            .orElseThrow(() -> new EntityNotFoundException("CarSale not found"));
        
        // Fetch the Image entity
        Image image = imageRepository.findById(imageId)
            .orElseThrow(() -> new EntityNotFoundException("Image not found"));
        
        // Remove the photo and delete the image
        carSale.removePhoto(image);
        imageRepository.delete(image);
        
        // Save the updated CarSale entity
        return carSaleRepository.save(carSale);
    }

    // Method to search for cars
    public List<CarSale> searchCars(String query) {
        return carSaleRepository.findByMakeContainingIgnoreCaseOrModelContainingIgnoreCaseOrRegistrationContainingIgnoreCase(query, query, query);
    }

    // Method to find a car sale by ID
    public CarSale findById(Long carId) {
        return carSaleRepository.findById(carId)
            .orElseThrow(() -> new EntityNotFoundException("CarSale not found"));
    }

    // Method to find car sales by user
    public List<CarSale> findCarSalesByUser(User user) {
        return carSaleRepository.findByUser(user);
    }

    // Method to delete a car sale by ID
    public void deleteCarSaleById(Long id) {
        carSaleRepository.deleteById(id);
    }

    // Method to delete car sales by IDs
    public void deleteCarSalesByIds(List<Long> carSaleIds) {
        carSaleRepository.deleteAllById(carSaleIds);
    }

    // Method to delete a CarSale by entity
    public void deleteCarSale(CarSale carSale) {
        if (carSale != null) {
            carSaleRepository.delete(carSale);
        }
    }

    // Method to find CarSale entities by a list of IDs
    public List<CarSale> findAllById(List<Long> ids) {
        return carSaleRepository.findAllById(ids);
    }
    
    // Method to get all car sales
    public List<CarSale> getAllCarSales() {
        return carSaleRepository.findAll();
    }
}
