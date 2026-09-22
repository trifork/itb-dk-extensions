package com.trifork.ihexdsapi.dgws;

import java.time.Clock;
import java.time.temporal.ChronoUnit;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Element;

/** Builds the HSUID 1.1 wire header as DOM. */
final class HsuidHeaderBuilder {
    private static final String NAMESPACE = "http://www.nsi.dk/hsuid/2016/08/hsuid-1.1.xsd";

    private HsuidHeaderBuilder() {}

    static Element build(DgwsClientInfo context, Clock clock) throws ParserConfigurationException {
        var doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
        var header = doc.createElementNS(NAMESPACE, "HsuidHeader");
        doc.appendChild(header);
        var assertion = child(header, "Assertion", null);
        assertion.setAttribute(
                "IssueInstant", clock.instant().truncatedTo(ChronoUnit.MILLIS).toString());
        assertion.setAttribute("Version", "2.0");
        assertion.setAttribute("id", "HSUID");
        child(assertion, "Issuer", "Issuer");
        var attributes = child(assertion, "AttributeStatement", null);
        attributes.setAttribute("id", "HSUIDdata");
        attribute(attributes, "CitizenCivilRegistrationNumber", context.getPatientId());
        attribute(attributes, "UserType", "nsi:HealthcareProfessional");
        attribute(attributes, "ActingUserCivilRegistrationNumber", context.getCpr());
        attribute(attributes, "OrgUsingID", context.getOrganisationCode())
                .setAttribute("NameFormat", "nsi:sor");
        attribute(attributes, "SystemOwnerName", "Test");
        attribute(attributes, "SystemName", "Test");
        attribute(attributes, "SystemVersion", "1.0");
        attribute(attributes, "OrgResponsibleName", "TestOrg");
        if (Boolean.TRUE.equals(context.getConsentOverride()))
            attribute(attributes, "ConsentOverride", "true");
        attribute(attributes, "ResponsibleUserCivilRegistrationNumber", context.getCpr());
        if (context.getAuthorizationCode() != null)
            attribute(
                    attributes, "ResponsibleUserAuthorizationCode", context.getAuthorizationCode());
        return header;
    }

    private static Element attribute(Element parent, String name, String value) {
        var element = child(parent, "Attribute", null);
        element.setAttribute("Name", "nsi:" + name);
        child(element, "AttributeValue", value);
        return element;
    }

    private static Element child(Element parent, String name, String value) {
        var element = parent.getOwnerDocument().createElementNS(NAMESPACE, name);
        if (value != null) element.setTextContent(value);
        parent.appendChild(element);
        return element;
    }
}
