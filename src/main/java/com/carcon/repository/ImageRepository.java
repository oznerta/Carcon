package com.carcon.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.carcon.dao.Image;

@Repository
public interface ImageRepository extends JpaRepository<Image, Long> {
    // Define any custom query methods if needed
}
