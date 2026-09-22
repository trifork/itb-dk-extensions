package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;

import com.trifork.ihexdsapi.service.impl.IDContextServiceImpl;
import java.util.Map;
import org.junit.jupiter.api.Test;

class IDContextServiceTest {
    @Test
    void requestAndResponseIdsCanBeReadAsAMap() {
        IDContextService context = new IDContextServiceImpl();
        context.updateId("tempReq", "request-1");
        context.updateId("tempRes", "response-1");
        var snapshot = context.getIds();
        assertEquals(Map.of("tempReq", "request-1", "tempRes", "response-1"), snapshot);
        context.updateId("tempReq", "request-2");
        assertEquals("request-1", snapshot.get("tempReq"));
        assertEquals("request-2", context.getId("tempReq"));
    }
}
