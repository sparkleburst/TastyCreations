package com.mgilhespy.tastycreations;

import org.springframework.cache.annotation.EnableCaching;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableCaching
public class TastyCreationsApplication {

	public static void main(String[] args) {
		SpringApplication.run(TastyCreationsApplication.class, args);
	}

}
