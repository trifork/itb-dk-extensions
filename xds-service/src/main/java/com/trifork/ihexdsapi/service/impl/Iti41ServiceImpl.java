package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSoapDecorator;
import com.trifork.ihexdsapi.service.Iti41Service;
import org.apache.cxf.frontend.ClientProxy;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.EbXMLFactory;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLFactory30;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLRegistryResponse30;
import org.openehealth.ipf.commons.ihe.xds.core.requests.ProvideAndRegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.ProvideAndRegisterDocumentSetTransformer;
import org.openehealth.ipf.commons.ihe.xds.core.transform.responses.ResponseTransformer;
import org.openehealth.ipf.commons.ihe.xds.iti41.Iti41PortType;

public class Iti41ServiceImpl implements Iti41Service {
    private static final EbXMLFactory FACTORY = new EbXMLFactory30();
    private final Iti41PortType port;
    private final DgwsSoapDecorator decorator = new DgwsSoapDecorator();

    public Iti41ServiceImpl(Iti41PortType port) {
        this.port = port;
        ClientProxy.getClient(port).getOutInterceptors().add(decorator);
    }

    @Override
    public Response submit(ProvideAndRegisterDocumentSet request, DgwsClientInfo clientInfo) {
        decorator.setDgwsClientInfo(clientInfo, !clientInfo.isSystemIdentity());
        try {
            var wire = new ProvideAndRegisterDocumentSetTransformer(FACTORY).toEbXML(request);
            var response =
                    port.documentRepositoryProvideAndRegisterDocumentSetB(wire.getInternal());
            return new ResponseTransformer(FACTORY)
                    .fromEbXML(new EbXMLRegistryResponse30(response));
        } finally {
            decorator.clearSDgwsClientInfo();
        }
    }
}
