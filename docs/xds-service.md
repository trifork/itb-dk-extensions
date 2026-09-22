# XDS architecture and compatibility

The independent [xds-service project](../xds-service/README.md) runs on Java 25.
One Spring Boot application exposes the search/retrieval REST API and GITB SOAP processing
service. Compose builds one `xds-api` container; the CDA plugin stays independent.
See [XDS setup](xds.md) for credentials, TEST1 endpoints and repository labels.

The service owns its source, Maven build, Dockerfile, configuration and test
support under `xds-service/`. Runtime defaults are in `application.properties`;
ignored `local/` holds overrides and signing material. Compose mounts these
read-only, and `.dockerignore` keeps them out of images. Production packages are
under `com.trifork.ihexdsapi`. The former API repository is no longer a build or
deployment dependency; its imported implementation and license remain here.

## Shared services

GITB calls `XdsOperations` in process. Its implementation uses the same credential,
code, DGWS, ITI-18 and ITI-43 services as the REST controllers. It neither calls the
REST controllers nor serialises requests over HTTP. IPF supplies query/response
models, transformers, `ErrorCode`/`ErrorInfo`, and CXF clients. SEAL and the DOM-based
`HsuidHeaderBuilder` retain the Danish authentication implementation.

ITI-41 submission, upload-metadata generation and submission-repository discovery
have been removed from the REST API and OpenAPI schema. Their SOAP clients,
custom outbound attachment serializer and CDA metadata builder dependency are
also removed. Local file uploads in ITB still go directly to CDA validation.
The credential API remains: search and retrieval require signing identities and STS.

`RegistryRouting` holds immutable per-registry bundles of DGWS/STS, ITI-18 and
ITI-43 clients. Both REST and GITB select from this operator-owned catalogue;
request input never changes client endpoint addresses. GITB saves the registry ID
with search context and uses it for retrieval, including after repository filtering.
Unknown IDs are rejected before authentication. The legacy configuration remains
available when no named bundles exist. See [registry configuration](xds.md#multiple-registries).

ITI-18 returns IPF `QueryResponse`. ITI-43 returns `RetrievedBytes`, with original
bytes and typed IPF findings. `RestXdsResponses` translates these to the existing
REST metadata, flattened error and Base64/formatting contracts at the REST boundary.
GITB uses typed errors directly; readable explanations are keyed by IPF enums.
Unknown standard codes retain their opcode. Raw upstream error text is withheld.

The GITB QName remains `ProcessingServiceService` and the endpoint remains
`/processing?wsdl`. Transactions preserve opaque handles, label lookup maps,
repository filtering, bounded previews and original-byte report attachments.
REST retains original bytes in `responseBase64`, default formatted `response`,
and `includeFormattedResponse=false`. Formatting rejects DOCTYPE and external
DTD/stylesheet access. GITB receives unformatted bytes directly.

## Isolation and bounds

DGWS context is thread-local and cleared in `finally`. GITB serialises operations
within each session; independent sessions may run concurrently. Upstream work uses
a bounded eight-worker executor and a 32-request queue. Each operation has a deadline
(`XDS_TIMEOUT_SECONDS`, default 45, range 1–300); expiry cancels its future. STS and
CXF connection/read timeouts are also bounded. Request attributes propagate to the
worker for scoped diagnostic IDs and are cleared after every operation.

Cancellation interrupts work but does not guarantee an immediate stop in every
transport library; transport timeouts and the bounded queue limit lingering work.
The application rejects overload with a sanitised `XDS-BUSY` result. Retrieved
content is capped at 10 MiB. Search sessions expire after 30 minutes and are limited
to 256 sessions and 500 results each.

Credentials and SOAP records use bounded process-local stores. Named identities
reload from configured files; uploaded credentials and diagnostic references expire
and do not survive restart. Downloadable REST diagnostics contain complete SOAP
and must be treated as sensitive. The ITB Compose configuration suppresses process
logs; SOAP/tokens are never included in GITB error messages.

`/health/ready` checks local identities, code lists and the published SOAP endpoint.
It does not authenticate against STS or query DDS, and permits an empty credential
list so CI can check startup without live keys.

Standard Spring Boot Actuator and Micrometer expose `/actuator/health`,
`/actuator/info` (Git metadata) and `/actuator/prometheus` on container port 8081.
Compose does not publish that port; endpoint exposure is configured explicitly.
The former custom `application_information` metric is replaced by standard metrics.
Request logs retain `correlation-id`, using `X-REQUEST-ID` (or the `correlation_id`
configured header) when it contains 1–128 letters, digits or `._:-`; otherwise a
UUID is generated. Request context is restored even when processing fails.

## Contracts and verification

Run `mvn -f xds-service/pom.xml -Plint verify` on Java 25. Surefire runs unit and
REST/SOAP fixture tests; Failsafe boots full applications. Both contribute to JaCoCo.
Spotless, PMD and CPD are checked in the same build. JaCoCo fails verification
below 80% line or 60% branch coverage across handwritten production classes;
generated OpenAPI classes are excluded.

The reusable [quality workflow](../.github/workflows/xds-quality.yml) also runs
self-contained Sonar Java and symbolic-execution analysis. It requires zero findings
and zero failed analysis files, scans production and test sources, and excludes
generated sources. The analyzer version and SHA-256 are pinned in
[`sonar-analyzer.json`](../xds-service/scripts/sonar-analyzer.json), downloaded from
the official [SonarSource release](https://github.com/SonarSource/sonarlint-vscode/releases/tag/5.10.0%2B80769).
This is a local Sonar engine gate, without a hosted SonarQube server or dashboard.

Both pull-request integration and image publication depend on the same quality
workflow. Tests, lint, coverage and Sonar reports are uploaded even on failure.
Configure the resulting quality check as required in GitHub branch protection if
merges must also be blocked; workflow dependencies already block image publication.

- `XdsRestContractTest` protects REST filters, metadata, inline/MTOM original bytes,
  registry findings, faults and authentication errors through real IPF/CXF transport.
- Registry configuration, REST and GITB tests cover independent endpoint bundles,
  unknown-ID rejection, selection persistence and registry names in reports.
  `RegistryConfigurationTest` sends real CXF requests to distinct loopback paths.
- `GitbApplicationIT` exercises HTTP GITB → shared Java services → IPF/CXF → local
  SOAP fixtures, including typed registry errors and concurrent patient isolation.
- GITB tests cover selection/filtering, byte preservation, expired/cross-session
  handles, safe errors, cancellation and worker context cleanup.
- `ApplicationIT` checks service configuration, credentials and the retained REST endpoints.
- Credential and signature tests cover named configuration, key matching, public
  metadata, certificate classification and STS signing/trust verification.
- [XDS CI](../.github/workflows/xds-integration.yml) builds the production image,
  checks startup without live credentials and runs the real ITB interactions using
  a separate image with synthetic in-process operations from test sources.

Java tests are in `src/test/java/`; Compose overrides and readiness/bootstrap
scripts are in `tests/`, relative to `xds-service/`. The opt-in `itb-it` Failsafe
profile runs `ItbFlowIT` against that stack. Root `tests/` retains shared ITB suite
packaging and session-catalogue checks. Surefire/Failsafe reports are in the
project's `target/`; stack diagnostics are in repository-root `test-results/xds/`.

The fixture application and Java test classes are absent from the production
jar/image. Tests do not establish live TEST1 availability or complete DDS-01.
