package com.trifork.ihexdsapi.gitb;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.apache.cxf.binding.soap.SoapFault;
import org.junit.jupiter.api.Test;

class SoapFaultDiagnosticsTest {
    static final String RESPONSE =
            """
            <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
                xmlns:medcom="http://www.medcom.dk/dgws/2006/04/dgws-1.0.xsd"
                xmlns:wsa="http://www.w3.org/2005/08/addressing"
                xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"
                xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
              <soap:Header>
                <wsse:Security><wsu:Timestamp><wsu:Created>2026-10-26T19:34:10Z</wsu:Created></wsu:Timestamp>
                  <wsse:BinarySecurityToken>SECRET-TOKEN</wsse:BinarySecurityToken>
                  <Assertion><MessageID>SECRET-ASSERTION</MessageID></Assertion>
                </wsse:Security>
                <medcom:Header><medcom:Linking>
                  <medcom:FlowID>flow-123</medcom:FlowID><medcom:MessageID>dgws-456</medcom:MessageID>
                  <medcom:InResponseToMessageID>request-789</medcom:InResponseToMessageID>
                </medcom:Linking></medcom:Header>
                <wsa:MessageID>urn:uuid:response-123</wsa:MessageID>
                <wsa:RelatesTo>urn:uuid:request-456</wsa:RelatesTo>
              </soap:Header>
              <soap:Body><soap:Fault>
                <faultcode>soap:Server</faultcode><faultstring>internal_error_minlog</faultstring>
                <detail><medcom:FaultCode>internal</medcom:FaultCode><private>SECRET-DETAIL</private></detail>
              </soap:Fault></soap:Body>
            </soap:Envelope>
            """;

    @Test
    void extractsOnlyFaultAndCorrelationFieldsFromCachedResponse() {
        String result =
                SoapFaultDiagnostics.describe(
                        new IllegalStateException("SECRET-EXCEPTION"),
                        "Response-Code: 500\nHeaders: SECRET-COOKIE\nPayload: "
                                + RESPONSE
                                + "\n--------------------------------------");
        for (String expected :
                new String[] {
                    "faultcode=soap:Server",
                    "faultstring=internal_error_minlog",
                    "responseTimestamp=2026-10-26T19:34:10Z",
                    "DGWS FlowID=flow-123",
                    "DGWS MessageID=dgws-456",
                    "DGWS InResponseToMessageID=request-789",
                    "WS-Addressing MessageID=urn:uuid:response-123",
                    "WS-Addressing RelatesTo=urn:uuid:request-456"
                }) assertTrue(result.contains(expected), result);
        assertFalse(result.contains("SECRET"));
        assertFalse(result.contains("Envelope"));
    }

    @Test
    void malformedNonFaultAndExternalEntityResponsesAreIgnored() {
        for (String response :
                new String[] {
                    "",
                    "not XML",
                    "<wrong/>",
                    RESPONSE.replace("soap:Fault", "soap:Result"),
                    "<!DOCTYPE x [<!ENTITY ext SYSTEM 'file:///etc/passwd'>]>"
                            + RESPONSE.replace("internal_error_minlog", "&ext;"),
                    "x".repeat(65537)
                })
            assertEquals(
                    "",
                    SoapFaultDiagnostics.describe(
                            new IllegalArgumentException("SECRET"), response));
        assertEquals("", SoapFaultDiagnostics.describe(null, null));
    }

    @Test
    void typedFaultFallbackIsBoundedAndCannotEmbedXmlOrLogLines() {
        var fault =
                new SoapFault(
                        "internal_error_minlog\n" + "x".repeat(700), SoapFault.FAULT_CODE_SERVER);
        String message =
                SoapFaultDiagnostics.describe(new RuntimeException("SECRET", fault), "bad XML");
        assertTrue(message.contains("faultcode="));
        assertTrue(message.contains("faultstring=internal_error_minlog "));
        assertFalse(message.contains("\n"));
        assertTrue(message.length() < 700);
        assertTrue(
                SoapFaultDiagnostics.describe(
                                new SoapFault(
                                        "<Assertion>SECRET</Assertion>",
                                        SoapFault.FAULT_CODE_CLIENT),
                                "")
                        .contains("[non-text content omitted]"));
        var soap = mock(jakarta.xml.soap.SOAPFault.class);
        when(soap.getFaultCode()).thenReturn("soap:Client");
        when(soap.getFaultString()).thenReturn("plain reason");
        assertTrue(
                SoapFaultDiagnostics.describe(new jakarta.xml.ws.soap.SOAPFaultException(soap), "")
                        .contains("faultstring=plain reason"));
    }

    @Test
    void soap12AndMissingOrNestedHeadersAreHandled() {
        String soap12 =
                """
                <s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope"><s:Body><s:Fault>
                <s:Code><s:Value>s:Receiver</s:Value></s:Code>
                <s:Reason><s:Text xml:lang="en">service unavailable</s:Text></s:Reason>
                </s:Fault></s:Body></s:Envelope>
                """;
        assertTrue(SoapFaultDiagnostics.describe(null, soap12).contains("faultcode=s:Receiver"));
        assertTrue(
                SoapFaultDiagnostics.describe(null, soap12)
                        .contains("faultstring=service unavailable"));
        String nested = RESPONSE.replace("flow-123", "<private>SECRET-NESTED</private>");
        assertFalse(SoapFaultDiagnostics.describe(null, nested).contains("DGWS FlowID"));
        assertFalse(SoapFaultDiagnostics.describe(null, nested).contains("SECRET"));
    }
}
