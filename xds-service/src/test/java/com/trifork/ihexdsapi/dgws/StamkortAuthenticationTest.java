package com.trifork.ihexdsapi.dgws;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import com.trifork.ihexdsapi.service.impl.DgwsServiceImpl;
import org.junit.jupiter.api.Test;
import org.openapitools.model.HealthcareProfessionalContext;

class StamkortAuthenticationTest {
    @Test
    void systemAndEmployeeCertificatesUseTheirOwnIdCards() throws Exception {
        var credentials = mock(CredentialService.class);
        var sts = mock(StsService.class);
        var service = new DgwsServiceImpl(sts, credentials);
        var system = mock(CredentialInfo.class);
        var employee = mock(CredentialInfo.class);
        when(credentials.getType("system")).thenReturn(CredentialInfo.SYSTEM);
        when(credentials.getCredentialInfoFromId("system")).thenReturn(system);
        when(credentials.getCredentialInfoFromId("employee")).thenReturn(employee);
        var systemCard = new DgwsClientInfo(null);
        var employeeCard =
                new DgwsClientInfo(null, "0101019999", "2512489996", "test", "123", false);
        var context = new HealthcareProfessionalContext().role("Læge");
        when(sts.getDgwsClientInfoForSystem(system)).thenReturn(systemCard);
        when(sts.getDgwsClientInfoForSystem(employee, "2512489996", context))
                .thenReturn(employeeCard);
        assertSame(systemCard, service.getStamkortClientInfo("2512489996", "system", context));
        assertTrue(systemCard.isSystemIdentity());
        assertSame(employeeCard, service.getStamkortClientInfo("2512489996", "employee", context));
        assertFalse(employeeCard.isSystemIdentity());
        verify(sts, never()).getDgwsClientInfoForSystem(system, "2512489996", context);
        assertThrows(
                DgwsSecurityException.class,
                () -> service.getStamkortClientInfo("2512489996", "missing", context));
    }
}
