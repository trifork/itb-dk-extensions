package com.trifork.ihexdsapi.interceptors;

import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dao.entity.LogEntry;
import com.trifork.ihexdsapi.service.IDContextService;
import java.util.UUID;
import org.apache.cxf.ext.logging.event.LogEvent;
import org.apache.cxf.ext.logging.event.LogEventSender;

/** Stores ITI-18 diagnostics for the download API without sending SOAP payloads to SLF4J. */
public final class CachedSoapLogSender implements LogEventSender {
    private final CacheRequestResponseHandle cache;
    private final IDContextService ids;

    public CachedSoapLogSender(CacheRequestResponseHandle cache, IDContextService ids) {
        this.cache = cache;
        this.ids = ids;
    }

    @Override
    public void send(LogEvent event) {
        switch (event.getType()) {
            case REQ_OUT -> save(event, "Req:", "tempReq", "Outbound Message");
            case RESP_IN, FAULT_IN -> save(event, "Res:", "tempRes", "Inbound Message");
            default ->
                    throw new IllegalArgumentException(
                            "Expected a client request or response event");
        }
    }

    private void save(LogEvent event, String prefix, String key, String heading) {
        String id = prefix + UUID.randomUUID();
        String payload =
                heading
                        + "\nID: "
                        + event.getExchangeId()
                        + "\nAddress: "
                        + event.getAddress()
                        + "\nResponse-Code: "
                        + event.getResponseCode()
                        + "\nEncoding: "
                        + event.getEncoding()
                        + "\nHttp-Method: "
                        + event.getHttpMethod()
                        + "\nContent-Type: "
                        + event.getContentType()
                        + "\nHeaders: "
                        + event.getHeaders()
                        + "\nPayload: "
                        + event.getPayload()
                        + "\n--------------------------------------";
        cache.saveRequestAndResponse(id, new LogEntry(id, payload));
        ids.updateId(key, id);
    }
}
