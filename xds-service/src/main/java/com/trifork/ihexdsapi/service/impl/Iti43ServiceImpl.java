package com.trifork.ihexdsapi.service.impl;

import com.trifork.ihexdsapi.dgws.DgwsClientInfo;
import com.trifork.ihexdsapi.dgws.DgwsSoapDecorator;
import com.trifork.ihexdsapi.dgws.ItiException;
import com.trifork.ihexdsapi.service.Iti43Service;
import java.io.IOException;
import org.apache.cxf.frontend.ClientProxy;
import org.openapitools.model.Iti43QueryParameter;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.EbXMLFactory;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLFactory30;
import org.openehealth.ipf.commons.ihe.xds.core.ebxml.ebxml30.EbXMLRetrieveDocumentSetResponse30;
import org.openehealth.ipf.commons.ihe.xds.core.requests.DocumentReference;
import org.openehealth.ipf.commons.ihe.xds.core.requests.RetrieveDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.responses.RetrievedDocumentSet;
import org.openehealth.ipf.commons.ihe.xds.core.transform.requests.RetrieveDocumentSetRequestTransformer;
import org.openehealth.ipf.commons.ihe.xds.core.transform.responses.RetrieveDocumentSetResponseTransformer;
import org.openehealth.ipf.commons.ihe.xds.iti43.Iti43PortType;

public class Iti43ServiceImpl implements Iti43Service {
    private final Iti43PortType iti43PortType;
    private final DgwsSoapDecorator dgwsSoapDecorator = new DgwsSoapDecorator();
    private static final EbXMLFactory ebXMLFactory = new EbXMLFactory30();

    public Iti43ServiceImpl(Iti43PortType iti43PortType) {
        this.iti43PortType = iti43PortType;
        ClientProxy.getClient(iti43PortType).getOutInterceptors().add(dgwsSoapDecorator);
    }

    @Override
    public com.trifork.ihexdsapi.service.RetrievedBytes getDocument(
            Iti43QueryParameter query, DgwsClientInfo clientInfo) throws ItiException {
        if (query.getDocumentId().isEmpty()) {
            throw new ItiException(1000, "Document unique ID is empty", null);
        }
        if (query.getRepositoryId().isEmpty()) {
            throw new ItiException(1000, "Repository ID is empty", null);
        }
        dgwsSoapDecorator.setDgwsClientInfo(clientInfo, true);
        try {
            RetrievedDocumentSet documents =
                    fetchDocument(query.getDocumentId(), query.getRepositoryId());
            byte[] bytes = null;
            if (!documents.getDocuments().isEmpty()) {
                try (var stream =
                        documents.getDocuments().get(0).getDataHandler().getInputStream()) {
                    bytes = stream.readNBytes(10 * 1024 * 1024 + 1);
                    if (bytes.length > 10 * 1024 * 1024)
                        throw new IOException("Retrieved document exceeds the 10 MiB limit");
                } catch (IOException e) {
                    throw new IllegalStateException(e);
                }
            }
            return new com.trifork.ihexdsapi.service.RetrievedBytes(bytes, documents.getErrors());
        } finally {
            dgwsSoapDecorator.clearSDgwsClientInfo();
        }
    }

    private RetrievedDocumentSet fetchDocument(String documentId, String repositoryId) {
        RetrieveDocumentSet request = new RetrieveDocumentSet();
        request.getDocuments().add(new DocumentReference(repositoryId, documentId, null));
        var wireRequest = new RetrieveDocumentSetRequestTransformer(ebXMLFactory).toEbXML(request);
        var wireResponse =
                iti43PortType.documentRepositoryRetrieveDocumentSet(wireRequest.getInternal());
        return new RetrieveDocumentSetResponseTransformer(ebXMLFactory)
                .fromEbXML(new EbXMLRetrieveDocumentSetResponse30(wireResponse));
    }
}
