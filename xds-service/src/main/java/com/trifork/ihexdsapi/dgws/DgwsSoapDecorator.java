package com.trifork.ihexdsapi.dgws;

import javax.xml.namespace.QName;
import javax.xml.parsers.ParserConfigurationException;
import org.apache.cxf.binding.soap.Soap11;
import org.apache.cxf.binding.soap.SoapMessage;
import org.apache.cxf.binding.soap.interceptor.AbstractSoapInterceptor;
import org.apache.cxf.headers.Header;
import org.apache.cxf.interceptor.Fault;
import org.apache.cxf.phase.Phase;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class DgwsSoapDecorator extends AbstractSoapInterceptor {

    private static final class RequestContext {
        final DgwsClientInfo clientInfo;
        final boolean enableHsuid;

        RequestContext(DgwsClientInfo clientInfo, boolean enableHsuid) {
            this.clientInfo = clientInfo;
            this.enableHsuid = enableHsuid;
        }
    }

    private final ThreadLocal<RequestContext> context = new ThreadLocal<>();

    public DgwsSoapDecorator() {
        super(Phase.PRE_STREAM);
    }

    public void setDgwsClientInfo(DgwsClientInfo dci, boolean enableHSUID) {
        context.set(new RequestContext(dci, enableHSUID));
    }

    public void clearSDgwsClientInfo() {
        context.remove();
    }

    @Override
    public void handleMessage(SoapMessage message) throws Fault {
        // DGWS is SOAP11
        message.setVersion(Soap11.getInstance());

        RequestContext current = context.get();
        DgwsClientInfo clientInfo = current.clientInfo;

        // Add the DGWS headers
        NodeList children =
                clientInfo.getSosi().getDocumentElement().getFirstChild().getChildNodes();
        for (int i = 0; i < children.getLength(); i++) {
            Node element = children.item(i);
            if (element.getNodeType() != Node.ELEMENT_NODE) continue;
            QName qname = new QName(element.getNamespaceURI(), element.getLocalName());
            Header dgwsHeader = new Header(qname, element);
            message.getHeaders().add(dgwsHeader);
        }

        // Add HSUID for type18 and 43

        if (current.enableHsuid) {
            try {
                message.getHeaders().add(getHsuid(clientInfo));
            } catch (ParserConfigurationException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private Header getHsuid(DgwsClientInfo clientInfo) throws ParserConfigurationException {
        var element = HsuidHeaderBuilder.build(clientInfo, java.time.Clock.systemUTC());
        return new Header(new QName(element.getNamespaceURI(), element.getLocalName()), element);
    }
}
