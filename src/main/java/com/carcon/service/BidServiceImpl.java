package com.carcon.service;

import java.util.List;
import org.springframework.stereotype.Service;

import com.carcon.dao.Bid;
import com.carcon.repository.BidRepository;

@Service
public class BidServiceImpl implements BidService {
    private final BidRepository bidRepository;
    

    public BidServiceImpl(BidRepository bidRepository) {
        this.bidRepository = bidRepository;
    }

    @Override
    public List<Bid> getBidHistoryForCarSale(Long carSaleId) {
        return bidRepository.findByCarSaleId(carSaleId);
    }
    
    @Override
    public Bid addBid(Bid bid) {
        // Perform any business logic or validation here
        return bidRepository.save(bid);
    }
    
    public void saveBid(Bid bid) {
        bidRepository.save(bid);
    }


}

