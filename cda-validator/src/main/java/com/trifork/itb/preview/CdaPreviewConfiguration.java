package com.trifork.itb.preview;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/** Loaded by the upstream application's PropertiesLauncher, outside the Gazelle class loader. */
@Configuration(proxyBeanMethods = false)
public class CdaPreviewConfiguration {
    @Bean
    public CdaPreviewController cdaPreviewController() throws Exception {
        return new CdaPreviewController(new CdaRenderer());
    }
}
