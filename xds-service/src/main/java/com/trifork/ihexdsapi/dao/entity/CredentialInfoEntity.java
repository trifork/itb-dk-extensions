package com.trifork.ihexdsapi.dao.entity;

public class CredentialInfoEntity {

    private final String owner;
    private final String id;
    private final String displayName;
    private final String publicCertStr;

    private final String privateKeyStr;

    private final String serialNumber;
    private final String type;

    public CredentialInfoEntity(
            String owner,
            String id,
            String displayName,
            String publicCertStr,
            String privateKeyStr,
            String serialNumber,
            String type) {
        this.owner = owner;
        this.id = id;
        this.displayName = displayName;
        this.publicCertStr = publicCertStr;
        this.privateKeyStr = privateKeyStr;
        this.type = type;
        this.serialNumber = serialNumber;
    }

    public String getOwner() {
        return owner;
    }

    public String getId() {
        return id;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getPublicCertStr() {
        return publicCertStr;
    }

    public String getPrivateKeyStr() {
        return privateKeyStr;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public String getType() {
        return type;
    }
}
