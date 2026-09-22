package com.trifork.ihexdsapi.configuration;

import com.trifork.ihexdsapi.dao.CacheRequestResponseHandle;
import com.trifork.ihexdsapi.dao.CredentialRepository;
import com.trifork.ihexdsapi.dgws.CredentialService;
import com.trifork.ihexdsapi.dgws.DgwsService;
import com.trifork.ihexdsapi.dgws.StsService;
import com.trifork.ihexdsapi.dgws.impl.CredentialServiceImpl;
import com.trifork.ihexdsapi.dgws.impl.StsServiceImpl;
import com.trifork.ihexdsapi.interceptors.CachedSoapLogSender;
import com.trifork.ihexdsapi.service.*;
import com.trifork.ihexdsapi.service.impl.*;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.ext.logging.LoggingFeature;
import org.apache.cxf.frontend.ClientProxy;
import org.openehealth.ipf.commons.ihe.ws.JaxWsClientFactory;
import org.openehealth.ipf.commons.ihe.xds.XDS;
import org.openehealth.ipf.commons.ihe.xds.iti18.Iti18PortType;
import org.openehealth.ipf.commons.ihe.xds.iti43.Iti43PortType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.web.context.annotation.RequestScope;

@Configuration
@Import(StorageConfiguration.class)
@org.springframework.boot.context.properties.EnableConfigurationProperties(RegistryProperties.class)
public class IheXdsConfiguration {
    @Value("${XDS_TIMEOUT_SECONDS:45}")
    private int timeoutSeconds = 45;

    private final java.util.List<Client> clients = new java.util.ArrayList<>();

    @jakarta.annotation.PreDestroy
    public void destroyClients() {
        clients.forEach(Client::destroy);
    }

    @Value("${STSURL}")
    private String stsUrl;

    private static Logger LOGGER = LoggerFactory.getLogger(IheXdsConfiguration.class);

    @Value("${xdsIti18Endpoint}")
    private String xdsIti18Endpoint;

    @Value("${xdsIti43Endpoint}")
    private String xdsIti43Endpoint;

    // Codes

    @Value("${type.code.scheme}")
    private String typeCodeScheme;

    @Value("${format.code.scheme}")
    private String formatCodeScheme;

    @Value("${event.code.scheme.codes}")
    private String eventCodeSchemeCodes;

    @Value("${event.code.scheme.names}")
    private String eventCodeSchemeNames;

    @Value("${healthcarefacilitytype.code.scheme}")
    private String healthcareFacilityTypeCodeScheme;

    @Value("${practicesetting.code.scheme}")
    private String practicesettingCodeScheme;

    @Value("${class.code.scheme}")
    private String classCodeScheme;

    // Dropdown lists

    @Value("${format.code.codes}")
    private String formatCodeCodes;

    @Value("${format.code.names}")
    private String formatCodeNames;

    @Value("${class.code.codes}")
    private String classCodeCodes;

    @Value("${class.code.names}")
    private String classCodeNames;

    @Value("${healthcarefacilitytype.code.codes}")
    private String healthcareFacilityTypeCodeCodes;

    @Value("${healthcarefacilitytype.code.names}")
    private String healthcareFacilityTypeCodeNames;

    @Value("${practicesetting.code.codes}")
    private String practiceSettingCodeCodes;

    @Value("${practicesetting.code.names}")
    private String practiceSettingCodeNames;

    @Value("${type.code.codes}")
    private String typeCodeCodes;

    @Value("${type.code.names}")
    private String typeCodeNames;

    @Bean
    public StsService stsService() {
        return new StsServiceImpl(stsUrl, Math.multiplyExact(timeoutSeconds, 1000));
    }

    @Bean
    public CredentialService credentialService(
            CredentialRepository credentialRepository,
            @Value("${xds.vault.password:}") String vaultPassword) {
        return new CredentialServiceImpl(credentialRepository, vaultPassword);
    }

    @Bean
    public DgwsService dgwsService(CredentialService credentialService, StsService stsService) {
        return new DgwsServiceImpl(stsService, credentialService);
    }

    @Bean
    public Iti18Service iti18Service(Iti18PortType iti18PortType) {
        return new Iti18ServiceImpl(iti18PortType);
    }

    @Bean
    @RequestScope
    public IDContextService idContextService() {
        return new IDContextServiceImpl();
    }

    @Bean
    public Iti18PortType getDocumentRegistryServiceIti18(
            CacheRequestResponseHandle cache, IDContextService ids) {
        return registryClient(xdsIti18Endpoint, cache, ids);
    }

    private Iti18PortType registryClient(
            String endpoint, CacheRequestResponseHandle cache, IDContextService ids) {
        LOGGER.info("Creating Iti18PortType for url: {}", endpoint);

        JaxWsClientFactory<?> xdsClientFactory = clientFactory(XDS.Interactions.ITI_18, endpoint);
        Iti18PortType client = (Iti18PortType) xdsClientFactory.getClient();
        clients.add(ClientProxy.getClient(client));
        var conduit =
                (org.apache.cxf.transport.http.HTTPConduit)
                        ClientProxy.getClient(client).getConduit();
        conduit.getClient().setConnectionTimeout(timeoutSeconds * 1000L);
        conduit.getClient().setReceiveTimeout(timeoutSeconds * 1000L);
        var logging = new LoggingFeature();
        logging.setLimit(-1); // Preserve complete downloadable ITI-18 messages.
        logging.setSender(new CachedSoapLogSender(cache, ids));
        logging.initialize(ClientProxy.getClient(client), ClientProxy.getClient(client).getBus());
        return client;
    }

    @Bean
    public Iti43PortType getDocumentRepositoryServiceIti43() {
        return retrievalClient(xdsIti43Endpoint);
    }

    private Iti43PortType retrievalClient(String endpoint) {
        LOGGER.info("Creating Iti43PortType for url: {}", endpoint);

        JaxWsClientFactory<?> xdsClientFactory = clientFactory(XDS.Interactions.ITI_43, endpoint);
        Iti43PortType client = (Iti43PortType) xdsClientFactory.getClient();
        clients.add(ClientProxy.getClient(client));
        var conduit =
                (org.apache.cxf.transport.http.HTTPConduit)
                        ClientProxy.getClient(client).getConduit();
        conduit.getClient().setConnectionTimeout(timeoutSeconds * 1000L);
        conduit.getClient().setReceiveTimeout(timeoutSeconds * 1000L);

        return client;
    }

    @Bean
    public Iti43Service iti43Service(Iti43PortType iti43PortType) {
        return new Iti43ServiceImpl(iti43PortType);
    }

    @Bean
    public RegistryRouting registryRouting(
            RegistryProperties properties,
            CredentialService credentials,
            DgwsService dgws,
            Iti18Service search,
            Iti43Service retrieval,
            CacheRequestResponseHandle cache,
            IDContextService ids) {
        if (properties.registries().isEmpty())
            return RegistryRouting.legacy(dgws, search, retrieval);
        var targets = new java.util.ArrayList<RegistryRouting.Target>();
        for (var registry : properties.registries()) {
            var sts =
                    new StsServiceImpl(
                            registry.stsEndpoint(), Math.multiplyExact(timeoutSeconds, 1000));
            targets.add(
                    new RegistryRouting.Target(
                            registry.id(),
                            registry.name(),
                            new DgwsServiceImpl(sts, credentials),
                            new Iti18ServiceImpl(
                                    registryClient(registry.iti18Endpoint(), cache, ids)),
                            new Iti43ServiceImpl(retrievalClient(registry.iti43Endpoint()))));
        }
        return new RegistryRouting(targets);
    }

    @Bean
    public CodesService codesService() throws CodesExecption {
        return new CodesServiceImpl(
                new CodesServiceImpl.CodeListDefinition(
                        typeCodeCodes, typeCodeNames, typeCodeScheme),
                new CodesServiceImpl.CodeListDefinition(
                        formatCodeCodes, formatCodeNames, formatCodeScheme),
                new CodesServiceImpl.CodeListDefinition(
                        eventCodeSchemeCodes, eventCodeSchemeNames, ""),
                new CodesServiceImpl.CodeListDefinition(
                        healthcareFacilityTypeCodeCodes,
                        healthcareFacilityTypeCodeNames,
                        healthcareFacilityTypeCodeScheme),
                new CodesServiceImpl.CodeListDefinition(
                        practiceSettingCodeCodes,
                        practiceSettingCodeNames,
                        practicesettingCodeScheme),
                new CodesServiceImpl.CodeListDefinition(
                        classCodeCodes, classCodeNames, classCodeScheme));
    }

    @Bean
    public ConfigsService configsService() {

        return new ConfigsServiceImpl(stsUrl, xdsIti18Endpoint, xdsIti43Endpoint);
    }

    private JaxWsClientFactory<?> clientFactory(XDS.Interactions interaction, String endpoint) {
        return new JaxWsClientFactory<>(
                interaction.getWsTransactionConfiguration(),
                endpoint,
                null,
                null,
                null,
                java.util.List.of(),
                java.util.Map.of(),
                null,
                null,
                null);
    }
}
