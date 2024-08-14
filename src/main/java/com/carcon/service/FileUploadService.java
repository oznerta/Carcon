package com.carcon.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.carcon.dao.CarSale;
import com.carcon.dao.Image;
import com.carcon.dao.User;
import com.carcon.repository.CarSaleRepository;
import com.carcon.repository.ImageRepository;

@Service
public class FileUploadService {

    private final CarSaleRepository carSaleRepository;
    private final ImageRepository imageRepository;

    // Inject repositories via constructor
    public FileUploadService(CarSaleRepository carSaleRepository, ImageRepository imageRepository) {
        this.carSaleRepository = carSaleRepository;
        this.imageRepository = imageRepository;
    }

    public void handleFileUpload(CarSale carSale, MultipartFile[] photos, User currentUser) throws IOException {
        // Save the CarSale entity first to make sure it exists in the database
        carSaleRepository.save(carSale);

        // Specify the root directory path
        String rootDirectoryPath = "D:\\STS WORKSPACE\\Carcon\\src\\main\\resources\\static\\UsersData";
        
        // Construct the user's directory path
        String userDirectoryPath = rootDirectoryPath + "\\" + currentUser.getUserName();
        
        // Create user's directory if it doesn't exist
        File userDirectory = new File(userDirectoryPath);
        if (!userDirectory.exists()) {
            userDirectory.mkdirs();
        }

        // Process each uploaded photo
        Set<Image> imageSet = new HashSet<>();
     // Loop through each photo and process it
        for (MultipartFile photo : photos) {
            if (!photo.isEmpty()) {
                // Generate a unique file name for the photo
                String fileName = System.currentTimeMillis() + "_" + photo.getOriginalFilename();
                
             // Define the file path
                Path filePath = Paths.get(userDirectoryPath, fileName);

                // Save the file to the user's directory
                Files.copy(photo.getInputStream(), filePath);

                // Normalize the file path to use forward slashes and ensure it starts with a forward slash
                String filePathString = filePath.toString().replace("\\", "/");
                if (!filePathString.startsWith("/")) {
                    filePathString = "/" + filePathString;
                }

                // Calculate the relative file path starting from "UsersData" and normalize it to use forward slashes
                String relativePath = filePathString.substring(filePathString.indexOf("/UsersData"));

                // Create an Image entity
                Image image = new Image();
                // Set the normalized relative file path for the image
                image.setFilePath(relativePath);

                // Associate the Image with the saved CarSale
                image.setCarSale(carSale);

                // Save the Image entity
                imageRepository.save(image);
            }
        }

        
        // Set the images for the CarSale
        carSale.setPhotos(imageSet);
        
        // Save the CarSale entity again with the images set (this might be unnecessary as the CarSale was already saved earlier)
        carSaleRepository.save(carSale);
    }

}
