package com.carcon.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.carcon.dao.Bid;

@Repository
public interface BidRepository extends JpaRepository<Bid, Long> {
    // Method to find all bids for a specific car sale
    List<Bid> findByCarSaleId(Long carSaleId);
    void deleteAllByUserId(Long userId);

}
