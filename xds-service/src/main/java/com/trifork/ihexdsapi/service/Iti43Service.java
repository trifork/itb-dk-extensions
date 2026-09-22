package com.trifork.ihexdsapi.service;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.ItiException;
import org.openapitools.model.Iti43QueryParameter;

@FunctionalInterface
public interface Iti43Service {
    RetrievedBytes getDocument(Iti43QueryParameter queryParameter, DgwsClientInfo clientInfo)
            throws ItiException;
}
