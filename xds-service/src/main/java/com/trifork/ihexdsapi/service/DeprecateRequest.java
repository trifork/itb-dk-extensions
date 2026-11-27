package com.trifork.ihexdsapi.service;

import org.openapitools.model.HealthcareProfessionalContext;

/** An ITI-57 availability change, from Approved to Deprecated, for one registered entry. */
public record DeprecateRequest(
        String registryId,
        String credentialId,
        HealthcareProfessionalContext context,
        String patientId,
        String entryUuid,
        String typeCode,
        String typeScheme) {}
