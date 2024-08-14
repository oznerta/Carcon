package com.carcon.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig{
	
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http	
        	.csrf(
        			csrf -> csrf.disable()
        	)
        	.authorizeRequests( auth -> {
                auth.requestMatchers("/").permitAll();
                auth.requestMatchers("/portal").permitAll();
                auth.requestMatchers("/signin").permitAll();
                auth.requestMatchers("/home","/cars/{carId}","/sell-a-car","/my-car-lists","/settings").hasAnyRole("User", "Admin");

        	})
            .formLogin(
                        form -> form
                                .loginPage("/portal")
                                .loginProcessingUrl("/signin")
                                .failureUrl("/signin_error")
                                .defaultSuccessUrl("/home")
                                .permitAll()
             )
             .logout(
                        logout -> logout
                                .logoutRequestMatcher(new AntPathRequestMatcher("/signout"))
                                .permitAll()

              );
        return http.build();
    }

}

