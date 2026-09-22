package com.trifork.ihexdsapi.configuration;

import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dao.CredentialRepository;
import com.trifork.ihexdsapi.dao.impl.CacheRequestResponseHandleImpl;
import com.trifork.ihexdsapi.dao.impl.CredentialRepositoryImpl;
import java.time.Clock;
import java.time.Duration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@Configuration
@EnableScheduling
public class StorageConfiguration {
    @Bean
    public CredentialRepository credentialRepository(
            @Value("${storage.credentials.ttl-ms:86400000}") long ttl,
            @Value("${storage.credentials.capacity:1000}") int capacity) {
        return new CredentialRepositoryImpl(Clock.systemUTC(), Duration.ofMillis(ttl), capacity);
    }

    @Bean
    public CacheRequestResponseHandle cacheRequestResponseHandle(
            @Value("${storage.logs.ttl-ms:7200000}") long ttl,
            @Value("${storage.logs.capacity:100}") int capacity) {
        return new CacheRequestResponseHandleImpl(
                Clock.systemUTC(), Duration.ofMillis(ttl), capacity);
    }
}
