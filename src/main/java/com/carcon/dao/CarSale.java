package com.carcon.dao;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.*;

@Entity
@Table(name = "car_sale")
public class CarSale {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "make", nullable = false)
    private String make;

    @Column(name = "model", nullable = false)
    private String model;

    @Column(name = "registration", nullable = false)
    private String registration;

    @Column(name = "bidding", nullable = false)
    private Double bidding;

    // Many-to-One relationship with User
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @OneToMany(mappedBy = "carSale", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Image> photos = new HashSet<>();
    
    // Status enum
    public enum Status {
        OPEN,
        CLOSED
    }

    // Status field
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private Status status = Status.OPEN; // Default is OPEN
    
    private LocalDateTime bidStartTime;
    private LocalDateTime bidEndTime;
    
    public LocalDateTime getBidStartTime() {
        return bidStartTime;
    }

    public void setBidStartTime(LocalDateTime bidStartTime) {
        this.bidStartTime = bidStartTime;
    }

    public LocalDateTime getBidEndTime() {
        return bidEndTime;
    }

    public void setBidEndTime(LocalDateTime bidEndTime) {
        this.bidEndTime = bidEndTime;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    // Additional fields and methods remain unchanged

    // Default constructor
    public CarSale() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    public Double getBidding() {
        return bidding;
    }

    public void setBidding(Double bidding) {
        this.bidding = bidding;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setPhotos(Set<Image> photos) {
        this.photos = photos;
        for (Image photo : photos) {
            photo.setCarSale(this);
        }
    }

    public Set<Image> getPhotos() {
        return photos;
    }

    public void addPhoto(Image image) {
        photos.add(image);
        image.setCarSale(this);
    }

    public void removePhoto(Image image) {
        photos.remove(image);
        image.setCarSale(null);
    }

    private Double highestBidAmount;

    // Getter and Setter for highestBidAmount
    public Double getHighestBidAmount() {
        return highestBidAmount;
    }

    public void setHighestBidAmount(Double highestBidAmount) {
        this.highestBidAmount = highestBidAmount;
    }
}

