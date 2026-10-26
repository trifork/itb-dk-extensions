package com.trifork.ihexdsapi.dgws;

import org.w3c.dom.Document;

public class DgwsClientInfo {

    private Document sosi;
    private String patientId;
    private boolean consentOverride = false;
    private String authorizationCode;
    private String organisationCode;
    private String organisationNameFormat;

    private String cpr;

    public DgwsClientInfo(
            Document sosi,
            String cpr,
            String patientId,
            String authorizationCode,
            String organisationCode,
            boolean consentOverride) {
        this(sosi, cpr, patientId, authorizationCode, organisationCode, "nsi:sor", consentOverride);
    }

    public DgwsClientInfo(
            Document sosi,
            String cpr,
            String patientId,
            String authorizationCode,
            String organisationCode,
            String organisationNameFormat,
            boolean consentOverride) {
        this.organisationNameFormat = organisationNameFormat;
        this.sosi = sosi;
        this.cpr = cpr;
        this.patientId = patientId;
        this.authorizationCode = authorizationCode;
        this.organisationCode = organisationCode;
        this.consentOverride = consentOverride;
    }

    public DgwsClientInfo(Document systemCardDocument) {
        this.sosi = systemCardDocument;
    }

    public Document getSosi() {
        return sosi;
    }

    public void setSosi(Document sosi) {
        this.sosi = sosi;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public boolean getConsentOverride() {
        return consentOverride;
    }

    public void setConsentOverride(boolean consentOverride) {
        this.consentOverride = consentOverride;
    }

    public String getCpr() {
        return cpr;
    }

    public String getAuthorizationCode() {
        return this.authorizationCode;
    }

    public String getOrganisationNameFormat() {
        return organisationNameFormat;
    }

    public String getOrganisationCode() {
        return this.organisationCode;
    }
}
