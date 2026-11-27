package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import org.openehealth.ipf.commons.ihe.xds.core.requests.RegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;

/** Update Document Set: changes registry metadata such as a document's availability status. */
@FunctionalInterface
public interface Iti57Service {
    Response update(RegisterDocumentSet request, DgwsClientInfo clientInfo);
}
