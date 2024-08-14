package com.carcon.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.carcon.dao.CarSale;
import com.carcon.dao.User;

@Repository
public interface CarSaleRepository extends JpaRepository<CarSale, Long> {
	List<CarSale> findByMakeContainingIgnoreCaseOrModelContainingIgnoreCaseOrRegistrationContainingIgnoreCase(String make, String model, String registration);
	List<CarSale> findByUser(User user);
	public void deleteById(Long id);
	void deleteAllByUserId(Long userId);
}