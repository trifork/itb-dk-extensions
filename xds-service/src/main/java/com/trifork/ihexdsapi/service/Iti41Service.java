package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import org.openehealth.ipf.commons.ihe.xds.core.requests.ProvideAndRegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;

/** Provide and Register Document Set-b: stores one document in a repository and registers it. */
@FunctionalInterface
public interface Iti41Service {
    Response submit(ProvideAndRegisterDocumentSet request, DgwsClientInfo clientInfo);
}
