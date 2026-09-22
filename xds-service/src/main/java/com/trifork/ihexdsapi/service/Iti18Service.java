package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.dgws.ItiException;
import org.openapitools.model.Iti18QueryParameter;
import org.openapitools.model.Iti18RequestUnique;
import org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse;

public interface Iti18Service {

    QueryResponse queryForDocument(Iti18QueryParameter iti18Request, DgwsClientInfo dgwsClientInfo)
            throws DgwsSecurityException, ItiException;

    QueryResponse queryForDocument(
            Iti18RequestUnique iti18RequestUnique, DgwsClientInfo dgwsClientInfo)
            throws DgwsSecurityException;
}
