package com.example.checkstylepocproject.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ExampleConfig {
  @Bean
  public Object exampleBean(){
    return new Object();
  }
}
