package com.carcon.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.carcon.dao.User;


@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	
    User findByUserName(String userName);
    User findByEmail(String email);
	boolean existsByUserName(String userName);
	boolean existsByEmail(String email);
 
}
