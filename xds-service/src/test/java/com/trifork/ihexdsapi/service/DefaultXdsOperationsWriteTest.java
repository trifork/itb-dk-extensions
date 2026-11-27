package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.configuration.SubmissionProperties;
import com.trifork.ihexdsapi.dgws.*;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.openapitools.model.Code;
import org.openapitools.model.HealthcareProfessionalContext;
import org.openehealth.ipf.commons.ihe.xds.core.requests.ProvideAndRegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.requests.RegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Status;

class DefaultXdsOperationsWriteTest {
    private final DgwsService dgws = mock(DgwsService.class);
    private final Iti41Service submission = mock(Iti41Service.class);
    private final Iti57Service update = mock(Iti57Service.class);
    private final CodesService codes = mock(CodesService.class);
    private final HealthcareProfessionalContext context =
            new HealthcareProfessionalContext().role("Læge").consentOverride(false);
    private static final byte[] DOCUMENT =
            DocumentMetadataTest.HEADER.getBytes(StandardCharsets.UTF_8);

    private DefaultXdsOperations operations(boolean stamkort, boolean writable) {
        var target =
                new RegistryRouting.Target(
                        "test2",
                        "DDS TEST2",
                        dgws,
                        mock(Iti18Service.class),
                        mock(Iti43Service.class),
                        stamkort,
                        writable ? submission : null,
                        writable ? update : null);
        when(codes.getFormatCodesList())
                .thenReturn(
                        List.of(
                                new Code()
                                        .code("urn:ad:dk:medcom:qfdd-v1.2:full")
                                        .name("QFDD 1.2 format")
                                        .scheme("1.2.208.184.100.10")));
        return new DefaultXdsOperations(
                mock(CredentialService.class),
                codes,
                new RegistryRouting(List.of(target)),
                SubmissionProperties.defaults());
    }

    @Test
    void submitsAsTheCdaPatientWithTheChosenFormatAndReturnsTheRegistryResponse() throws Exception {
        var ops = operations(false, true);
        var info = mock(DgwsClientInfo.class);
        when(dgws.getStamkortClientInfo("0103660140", "me", context)).thenReturn(info);
        var accepted = new Response(Status.SUCCESS);
        when(submission.submit(any(), eq(info))).thenReturn(accepted);

        var result =
                ops.submit(
                        new SubmitRequest(
                                "test2",
                                "me",
                                context,
                                DOCUMENT,
                                DocumentMetadata.parse(DOCUMENT),
                                "urn:ad:dk:medcom:qfdd-v1.2:full"));

        assertSame(accepted, result.response());
        assertTrue(result.entryUuid().startsWith("urn:uuid:"));
        assertEquals("74468-0", result.typeCode());
        assertEquals("2.16.840.1.113883.6.1", result.typeScheme());
        var sent = org.mockito.ArgumentCaptor.forClass(ProvideAndRegisterDocumentSet.class);
        verify(submission).submit(sent.capture(), eq(info));
        var entry = sent.getValue().getDocuments().getFirst().getDocumentEntry();
        assertEquals("1.2.208.184.100.10", entry.getFormatCode().getSchemeName());
        assertEquals("QFDD 1.2 format", entry.getFormatCode().getDisplayName().getValue());
        assertEquals("0103660140", entry.getPatientId().getId());
    }

    @Test
    void refusesToWriteWhereWritingIsNotConfiguredOrTheFormatIsUnknown() throws Exception {
        var request =
                new SubmitRequest(
                        "test2",
                        "me",
                        context,
                        DOCUMENT,
                        DocumentMetadata.parse(DOCUMENT),
                        "urn:ad:dk:medcom:qfdd-v1.2:full");
        var readOnly = operations(false, false);
        assertThrows(IllegalArgumentException.class, () -> readOnly.submit(request));
        var stamkort = operations(true, true);
        assertThrows(IllegalArgumentException.class, () -> stamkort.submit(request));
        var writable = operations(false, true);
        var unknown =
                new SubmitRequest(
                        "test2", "me", context, DOCUMENT, DocumentMetadata.parse(DOCUMENT), "nope");
        assertThrows(IllegalArgumentException.class, () -> writable.submit(unknown));
        var noMetadata = new SubmitRequest("test2", "me", context, "<html/>".getBytes(), null, "x");
        assertThrows(IllegalArgumentException.class, () -> writable.submit(noMetadata));
        verifyNoInteractions(submission);
        verify(dgws, never()).getHealthCareProfessionalClientInfo(any(), any(), any());
    }

    @Test
    void deprecatesOneEntryForItsPatientOnlyWhereTheRegistryAllowsIt() throws Exception {
        var ops = operations(false, true);
        var info = mock(DgwsClientInfo.class);
        when(dgws.getStamkortClientInfo("0103660140", "me", context)).thenReturn(info);
        var accepted = new Response(Status.SUCCESS);
        when(update.update(any(), eq(info))).thenReturn(accepted);

        assertSame(
                accepted,
                ops.deprecate(
                        new DeprecateRequest(
                                "test2",
                                "me",
                                context,
                                "0103660140",
                                "urn:uuid:e",
                                "74468-0",
                                "2.16.1")));
        assertSame(
                accepted,
                ops.deprecate(
                        new DeprecateRequest(
                                "test2", "me", context, "0103660140", "urn:uuid:e", "", null)));
        var sent = org.mockito.ArgumentCaptor.forClass(RegisterDocumentSet.class);
        verify(update, times(2)).update(sent.capture(), eq(info));
        assertEquals(
                "74468-0",
                sent.getAllValues().get(0).getSubmissionSet().getContentTypeCode().getCode());
        assertEquals(
                "UPDATE",
                sent.getAllValues().get(1).getSubmissionSet().getContentTypeCode().getCode());

        var request =
                new DeprecateRequest(
                        "test2", "me", context, "0103660140", "urn:uuid:e", null, null);
        var readOnly = operations(false, false);
        assertThrows(IllegalArgumentException.class, () -> readOnly.deprecate(request));
        var stamkort = operations(true, true);
        assertThrows(IllegalArgumentException.class, () -> stamkort.deprecate(request));
    }

    @Test
    void choicesAdvertiseWhichWritesAreConfigured() {
        var choice = operations(false, true).registries().getFirst();
        assertTrue(choice.canSubmit());
        assertTrue(choice.canDeprecate());
        choice = operations(false, false).registries().getFirst();
        assertFalse(choice.canSubmit());
        assertFalse(choice.canDeprecate());
    }
}
