package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSoapDecorator;
import com.trifork.ihexdsapi.service.Iti57Service;
import org.apache.cxf.frontend.ClientProxy;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.EbXMLFactory;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLFactory30;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLRegistryResponse30;
import org.openehealth.ipf.commons.ihe.xds.core.requests.RegisterDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.Response;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.RegisterDocumentSetTransformer;
import org.openehealth.ipf.commons.ihe.xds.core.transform.responses.ResponseTransformer;
import org.openehealth.ipf.commons.ihe.xds.iti57.Iti57PortType;

public class Iti57ServiceImpl implements Iti57Service {
    private static final EbXMLFactory FACTORY = new EbXMLFactory30();
    private final Iti57PortType port;
    private final DgwsSoapDecorator decorator = new DgwsSoapDecorator();

    public Iti57ServiceImpl(Iti57PortType port) {
        this.port = port;
        ClientProxy.getClient(port).getOutInterceptors().add(decorator);
    }

    @Override
    public Response update(RegisterDocumentSet request, DgwsClientInfo clientInfo) {
        // DROS takes no HSUID header (the original ihe-xds-api sent none with ITI-41 either).
        decorator.setDgwsClientInfo(clientInfo, false);
        try {
            var wire = new RegisterDocumentSetTransformer(FACTORY).toEbXML(request);
            var response = port.documentRegistryUpdateDocumentSet(wire.getInternal());
            return new ResponseTransformer(FACTORY)
                    .fromEbXML(new EbXMLRegistryResponse30(response));
        } finally {
            decorator.clearSDgwsClientInfo();
        }
    }
}
