package com.trifork.ihexdsapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class IheXdsApiApplication {
    public static void main(String[] args) {
        com.trifork.ihexdsapi.dgws.DgwsSignaturePolicy.configure(
                Boolean.parseBoolean(System.getenv("ALLOW_TEST1_LEGACY_SHA1")));
        SpringApplication.run(IheXdsApiApplication.class, args);
    }
}
