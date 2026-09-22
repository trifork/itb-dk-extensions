package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSecurityException;
import com.trifork.ihexdsapi.dgws.DgwsSoapDecorator;
import com.trifork.ihexdsapi.dgws.ItiException;
import com.trifork.ihexdsapi.service.Iti18Service;
import jakarta.xml.ws.WebServiceException;
import jakarta.xml.ws.soap.SOAPFaultException;
import org.apache.cxf.binding.soap.SoapFault;
import org.apache.cxf.frontend.ClientProxy;
import org.openapitools.model.Iti18QueryParameter;
import org.openapitools.model.Iti18RequestUnique;
import org.openehealth.ipf.commons.ihe.xds.core.stub.ebrs30.query.AdhocQueryRequest;
import org.openehealth.ipf.commons.ihe.xds.core.stub.ebrs30.query.AdhocQueryResponse;
import org.openehealth.ipf.commons.ihe.xds.iti18.Iti18PortType;

public class Iti18ServiceImpl implements Iti18Service {
    private static final String MINLOG_FAULT = "internal_error_minlog";
    private final Iti18PortType iti18PortType;
    private final DgwsSoapDecorator dgwsSoapDecorator = new DgwsSoapDecorator();
    private final Iti18Mapper mapper = new Iti18Mapper();

    public Iti18ServiceImpl(Iti18PortType iti18PortType) {
        this.iti18PortType = iti18PortType;
        ClientProxy.getClient(iti18PortType).getOutInterceptors().add(dgwsSoapDecorator);
    }

    @Override
    public org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse queryForDocument(
            Iti18QueryParameter query, DgwsClientInfo clientInfo)
            throws DgwsSecurityException, ItiException {
        var response = execute(mapper.createQuery(query), clientInfo);
        return decode(response);
    }

    @Override
    public org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse queryForDocument(
            Iti18RequestUnique request, DgwsClientInfo clientInfo) throws DgwsSecurityException {
        var query =
                java.util.Objects.requireNonNull(
                        request.getQueryParameters(), "Query parameters are required");
        var response = execute(mapper.buildAdhocQueryRequest(query.getDocumentId()), clientInfo);
        return decode(response);
    }

    private static org.openehealth.ipf.commons.ihe.xds.core.responses.QueryResponse decode(
            AdhocQueryResponse response) {
        return new org.openehealth.ipf.commons.ihe.xds.core.transform.responses
                        .QueryResponseTransformer(
                        new org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLFactory30())
                .fromEbXML(
                        new org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30
                                .EbXMLQueryResponse30(response));
    }

    private static boolean isMinlogFault(WebServiceException fault) {
        if (fault instanceof SOAPFaultException soapFault) {
            return MINLOG_FAULT.equals(soapFault.getFault().getFaultString());
        }
        return fault.getCause() instanceof SoapFault soapFault
                && MINLOG_FAULT.equals(soapFault.getReason());
    }

    private AdhocQueryResponse execute(AdhocQueryRequest query, DgwsClientInfo clientInfo) {
        dgwsSoapDecorator.setDgwsClientInfo(clientInfo, true);
        try {
            return iti18PortType.documentRegistryRegistryStoredQuery(query);
        } catch (WebServiceException fault) {
            // Preserve the published REST error while letting CXF decode SOAP faults.
            if (isMinlogFault(fault)) {
                throw new IllegalStateException("ID does not exists", fault);
            }
            throw fault;
        } finally {
            dgwsSoapDecorator.clearSDgwsClientInfo();
        }
    }
}
