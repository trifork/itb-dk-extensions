package com.trifork.ihexdsapi.service;

import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;

/**
 * The registry's answer to an ITI-41 plus the identifiers this service assigned to the entry, which
 * a later ITI-57 needs: the entry UUID and the type code of the document that was sent.
 */
public record SubmissionResult(
        Response response, String entryUuid, String typeCode, String typeScheme) {}
