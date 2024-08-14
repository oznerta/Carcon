package com.carcon.dao;

import jakarta.persistence.*;

@Entity
@Table(name = "image")
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "file_path", nullable = false)
    private String filePath;

    @ManyToOne
    @JoinColumn(name = "car_sale_id", nullable = false)
    private CarSale carSale;

    // Default constructor
    public Image() {}

    // Getters and setters
    // Include other necessary methods for the class

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public CarSale getCarSale() {
        return carSale;
    }

    public void setCarSale(CarSale carSale) {
        this.carSale = carSale;
    }
}
