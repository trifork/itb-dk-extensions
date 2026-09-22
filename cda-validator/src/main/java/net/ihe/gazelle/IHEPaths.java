package net.ihe.gazelle;

public class IHEPaths {
    final String cdaXsd;

    public String getCdaXsd() {
        return cdaXsd;
    }

    public String getValueSetRepo() {
        return valueSetRepo;
    }

    public String getCdaXsl() {
        return cdaXsl;
    }

    final String valueSetRepo;
    final String cdaXsl;

    public IHEPaths(final String cdaXsd, final String valueSetRepo, final String cdaXsl) {
        super();
        this.cdaXsd = cdaXsd;
        this.valueSetRepo = valueSetRepo;
        this.cdaXsl = cdaXsl;
    }
}
