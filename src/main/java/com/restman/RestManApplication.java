package com.restman;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages = "com.restman.servlet")
public class RestManApplication {
    public static void main(String[] args) {
        SpringApplication.run(RestManApplication.class, args);
    }
}


