package com.trifork.ihexdsapi.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.dgws.*;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.openapitools.model.*;

class RegistryRoutingTest {
    private static RegistryRouting.Target target(String id) {
        return new RegistryRouting.Target(
                id,
                "DDS " + id,
                mock(DgwsService.class),
                mock(Iti18Service.class),
                mock(Iti43Service.class));
    }

    @Test
    void routesSearchAndRetrievalThroughTheirOwnAuthenticationAndServices() throws Exception {
        var one = target("one");
        var two = target("two");
        var routing = new RegistryRouting(List.of(one, two));
        var operations =
                new DefaultXdsOperations(
                        mock(CredentialService.class), mock(CodesService.class), routing);
        assertEquals(
                List.of(
                        new RegistryRouting.Choice("one", "DDS one"),
                        new RegistryRouting.Choice("two", "DDS two")),
                operations.registries());
        var query =
                new Iti18Request()
                        .registryId("two")
                        .credentialId("employee")
                        .queryParameters(new Iti18QueryParameter().patientId("2512489996"));
        operations.search(query);
        verify(two.dgws()).getHealthCareProfessionalClientInfo("2512489996", "employee", null);
        verify(two.search()).queryForDocument(query.getQueryParameters(), null);
        var retrieve =
                new Iti43Request()
                        .registryId("two")
                        .credentialId("employee")
                        .queryParameters(new Iti43QueryParameter().patientId("2512489996"));
        operations.retrieve(retrieve);
        verify(two.dgws(), times(2))
                .getHealthCareProfessionalClientInfo("2512489996", "employee", null);
        verify(two.retrieval()).getDocument(retrieve.getQueryParameters(), null);
        verifyNoInteractions(one.dgws(), one.search(), one.retrieval());
        operations.search(query.registryId(null));
        verify(one.search()).queryForDocument(query.getQueryParameters(), null);
        assertSame(one, routing.target(" "));
        assertSame(one, routing.target("one"));
        clearInvocations(one.dgws(), two.dgws());
        query.registryId("unknown");
        assertThrows(IllegalArgumentException.class, () -> operations.search(query));
        retrieve.registryId("https://untrusted.invalid");
        assertThrows(IllegalArgumentException.class, () -> operations.retrieve(retrieve));
        verifyNoInteractions(one.dgws(), two.dgws());
        assertThrows(IllegalArgumentException.class, () -> new RegistryRouting(List.of()));
    }
}
