package com.carcon.service;

import java.util.List;

import com.carcon.dao.Bid;

public interface BidService {
    // Method to fetch the bid history for a specific car sale
    List<Bid> getBidHistoryForCarSale(Long carSaleId);
    
    // Method to add a new bid
    Bid addBid(Bid bid);
    
    
    // Add the `saveBid` method to the interface
    void saveBid(Bid bid);
}
