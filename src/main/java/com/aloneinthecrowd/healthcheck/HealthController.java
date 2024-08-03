package com.aloneinthecrowd.healthcheck;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    public record Health(String status) {
    }

    @GetMapping("/health")
    public Health getHealth() {
        return new Health("OK");
    }
}