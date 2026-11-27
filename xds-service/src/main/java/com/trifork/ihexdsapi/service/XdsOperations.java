package com.trifork.ihexdsapi.service;

import java.util.List;
import org.openapitools.model.*;
import org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse;

/** In-process API. Findings remain IPF objects; retrieved bytes have never been formatted. */
public interface XdsOperations {
    List<RegistryRouting.Choice> registries();

    List<CredentialInfoResponse> identities();

    List<Code> codes(boolean format);

    QueryResponse search(Iti18Request request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException;

    RetrievedBytes retrieve(Iti43Request request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException;

    /** ITI-41: stores and registers a CDA. Findings are returned, never thrown. */
    SubmissionResult submit(SubmitRequest request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException;

    /** ITI-57: marks one registered entry as deprecated. */
    org.openehealth.ipf.commons.ihe.xds.core.responses.Response deprecate(DeprecateRequest request)
            throws com.trifork.ihexdsapi.dgws.DgwsSecurityException,
                    com.trifork.ihexdsapi.dgws.ItiException;
}
