package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import javax.xml.parsers.DocumentBuilderFactory;
import org.apache.cxf.binding.soap.SoapMessage;
import org.junit.jupiter.api.Test;

class DgwsSoapDecoratorTest {
    @Test
    void concurrentRequestsKeepTheirOwnHsuidSetting() throws Exception {
        var factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        var document =
                factory.newDocumentBuilder()
                        .parse(
                                new ByteArrayInputStream(
                                        "<s:Envelope xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'><s:Header>  </s:Header><s:Body/></s:Envelope>"
                                                .getBytes(StandardCharsets.UTF_8)));
        var identity =
                new DgwsClientInfo(
                        document, "0101019999", "3001749995", "FT001", "123456789012345", false);
        var decorator = new DgwsSoapDecorator();
        var ready = new CountDownLatch(1);
        var proceed = new CountDownLatch(1);
        var executor = Executors.newSingleThreadExecutor();
        try {
            var withHsuid =
                    executor.submit(
                            () -> {
                                decorator.setDgwsClientInfo(identity, true);
                                ready.countDown();
                                try {
                                    assertTrue(proceed.await(5, TimeUnit.SECONDS));
                                    var message =
                                            new SoapMessage(
                                                    org.apache.cxf.binding.soap.Soap11
                                                            .getInstance());
                                    decorator.handleMessage(message);
                                    return message.getHeaders().size();
                                } finally {
                                    decorator.clearSDgwsClientInfo();
                                }
                            });
            assertTrue(ready.await(5, TimeUnit.SECONDS));
            decorator.setDgwsClientInfo(identity, false);
            try {
                var message = new SoapMessage(org.apache.cxf.binding.soap.Soap11.getInstance());
                decorator.handleMessage(message);
                assertEquals(0, message.getHeaders().size());
            } finally {
                decorator.clearSDgwsClientInfo();
                proceed.countDown();
            }
            assertEquals(1, withHsuid.get(5, TimeUnit.SECONDS));
        } finally {
            proceed.countDown();
            executor.shutdownNow();
        }
    }
}
