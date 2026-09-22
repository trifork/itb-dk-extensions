package com.trifork.ihexdsapi.gitb;

import com.trifork.ihexdsapi.service.XdsOperations;
import jakarta.xml.ws.Endpoint;
import java.time.*;
import org.apache.cxf.Bus;
import org.apache.cxf.bus.spring.SpringBus;
import org.apache.cxf.jaxws.EndpointImpl;
import org.apache.cxf.transport.servlet.CXFServlet;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.*;

@Configuration
public class GitbConfiguration {
    // CXF bypasses DispatcherServlet, so expose request scope for shared diagnostic IDs.
    @Bean
    public org.springframework.boot.web.servlet.FilterRegistrationBean<
                    org.springframework.web.filter.RequestContextFilter>
            gitbRequestContext() {
        var filter =
                new org.springframework.boot.web.servlet.FilterRegistrationBean<>(
                        new org.springframework.web.filter.RequestContextFilter());
        filter.addUrlPatterns("/processing", "/processing/*");
        return filter;
    }

    @Bean(name = Bus.DEFAULT_BUS_ID)
    public SpringBus cxfBus() {
        return new SpringBus();
    }

    @Bean
    public ServletRegistrationBean<CXFServlet> gitbServlet() {
        return new ServletRegistrationBean<>(new CXFServlet(), "/processing", "/processing/*");
    }

    @Bean(destroyMethod = "close")
    GitbXdsAccess gitbAccess(
            XdsOperations operations, @Value("${XDS_TIMEOUT_SECONDS:45}") long timeout) {
        if (timeout < 1 || timeout > 300)
            throw new IllegalArgumentException("XDS_TIMEOUT_SECONDS must be between 1 and 300");
        return new GitbXdsAccess(operations, Duration.ofSeconds(timeout));
    }

    @Bean
    XdsProcessingService gitbService(
            GitbXdsAccess access,
            @Value("${XDS_ROLE:Læge}") String role,
            @Value("${XDS_AUTHORIZATION_CODE:}") String authorization) {
        return new XdsProcessingService(access, role, authorization, Clock.systemUTC());
    }

    @Bean(destroyMethod = "stop")
    Endpoint gitbEndpoint(Bus bus, XdsProcessingService service) {
        var endpoint = new EndpointImpl(bus, service);
        endpoint.publish("/");
        return endpoint;
    }
}
