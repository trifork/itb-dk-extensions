# Find CDA documents in DDS from ITB

Enable the optional XDS integration with:

```bash
ITB_ENABLE_XDS=true ./get-up-and-running/start.sh
```

This pulls the published combined Java 25 service from Docker Hub and deploys all
registered release tests. The `xds-api` container serves both REST and GITB SOAP;
the GITB adapter calls the shared XDS Java services directly. It uses process-local
storage and needs no Redis. ITB's own Redis service remains required.
Set `ITB_BUILD_FROM_SOURCE=true` to build the services from the checkout instead.
The CDA plugin and XDS service are independent Maven projects with separate POMs.
Each test offers **Local file upload** or **IHE XDS (DDS) retrieval**. These labels
also appear in the document-source step report. Both sources feed the same
exact release selector and XSD → Schematron → Gazelle validation chain.
The release in the test title remains authoritative: XDS metadata does not select
or prove a CDA profile release. All releases still have partial conformance coverage.

The default command without `ITB_ENABLE_XDS=true` deploys upload-only tests.
Switching modes creates replacement pending sessions for every registered profile/version. Previous sessions and results remain available with
their original definitions. Subsequent setup in the same mode reuses pending
sessions. For the local Docker engine, setup replaces sessions created before its
last restart: their saved dialogs can remain visible even though the in-memory
execution is gone. After restarting Docker/ITB, rerun the startup command and open
the new pending session. Remote installations can set `ITB_ENGINE_STARTED_AT` to
the engine's UTC startup timestamp. No ITB UI fork or browser extension is required.

## Multiple registries

Each named registry bundles an ITI-18 search endpoint, an ITI-43 retrieval gateway
and its own STS endpoint. The maintained `xds-service/application.properties`
offers **DDS TEST1** and **DDS TEST2**. TEST1 references the existing `STSURL`,
`xdsIti18Endpoint` and `xdsIti43Endpoint` settings, preserving their local overrides;
TEST2 has separate `XDS_TEST2_STS_URL`, `XDS_TEST2_REGISTRY_URL` and
`XDS_TEST2_REPOSITORY_URL` placeholders with published HTTPS defaults.

To replace this list (including reducing it to one registry), put complete entries
in the ignored `xds-service/local/application.properties`, which Compose mounts
at `/local/application.properties`. Spring configuration lists are replaced as a
whole by a higher-priority list; include every registry you want to offer. For example:

```properties
xds.registries[0].id=test1
xds.registries[0].name=DDS TEST1
xds.registries[0].iti18-endpoint=https://test1-cnsp.ekstern-test.nspop.dk:8443/ddsregistry
xds.registries[0].iti43-endpoint=https://test1-cnsp.ekstern-test.nspop.dk:8443/ddsrepository
xds.registries[0].sts-endpoint=https://test1.ekstern-test.nspop.dk:8443/sts/services/NewSecurityTokenService
xds.registries[1].id=test2
xds.registries[1].name=DDS TEST2
xds.registries[1].iti18-endpoint=https://test2-cnsp.ekstern-test.nspop.dk:8443/ddsregistry
xds.registries[1].iti43-endpoint=https://test2-cnsp.ekstern-test.nspop.dk:8443/ddsrepository
xds.registries[1].sts-endpoint=https://test2.ekstern-test.nspop.dk:8443/sts/services/NewSecurityTokenService
```

The example combines the [NSP external test hosts and HTTPS port](https://www.nspop.dk/spaces/Web3/pages/4839407/Endpoints%2Bfor%2Beksterne%2Btestmilj%C3%B8er)
with the [DDS service paths](https://www.nspop.dk/spaces/web/pages/102375271/DDS%2B-%2BGuide%2Btil%2Banvendere)
and the existing DGWS STS path. It is configuration guidance, not verification of
live access to either environment. The [2019 STS component page](https://www.nspop.dk/pages/viewpage.action?pageId=98466670)
contains internal deployment hosts rather than the external client addresses.
Check certificate trust and authorisation for each environment. Signing identities,
role/authorisation and metadata code lists remain shared; each selected STS
performs its own authentication. Current STS support uses the SOSI test federation.

Restart `xds-api` after changing configuration and start a new XDS session.
Registry IDs must be unique and stable (1–64 letters, digits, `_` or `-`); names
are user-facing. Invalid or incomplete entries fail startup. Endpoint URLs are
operator configuration and cannot be supplied through a user selection.

With no `xds.registries` entries, the existing `STSURL`, `xdsIti18Endpoint` and
`xdsIti43Endpoint` settings remain in use. A configured list replaces these for
search and retrieval. ITI-41 document submission and its upload-metadata preview
and repository-list endpoints have been removed. No ITI-41 endpoint setting is required.
The REST endpoint `GET /v1/registries` returns only IDs and names. Supply the same
optional top-level `registryId` to `POST /v1/iti18`, `/v1/iti18/uniqueID` and
`/v1/iti43`. Omission selects the first configured entry for REST compatibility;
unknown IDs are rejected. ITB requires an explicit choice when multiple entries
exist and holds that choice server-side with the results. Repository filtering
never changes it. **Search again** permits another registry and invalidates old
document selections. Existing saved test sessions retain their original TDL;
use newly deployed definitions for the registry selector.

## Searching and selecting

The **Load XDS identities and search codes** step report lists the available
signing identities, certificate types and validity dates, configured role/authorisation, and type/format codes with their
coding schemes. It also shows the search defaults and distinguishes loading local
configuration from the STS authentication and DDS access attempted by a search.

1. Choose **IHE XDS (DDS) retrieval**. If multiple registries are configured, choose
   the **Registry** first. With one registry this step is skipped. Then enter a ten-digit **test CPR** and select a configured
   **Signing identity**. The selector includes employee and system certificates,
   prefixed with **MOCES**, **FOCES**, or **VOCES**, followed by their expiry date
   in UTC. Expired certificates show **EXPIRED**; future certificates show
   **NOT YET VALID**. Unclassified legacy system certificates use **SYSTEM**.
   Expired and system identities remain inspectable, but this DDS search flow
   requires a current employee identity. Selecting an ineligible certificate gives
   a specific explanation before contacting DDS. Credentials come from the backend;
   ITB receives no keys.
2. Optionally filter by one or more type codes, one or more format codes, exact document Unique ID, and
   service start/stop ranges. Dates must include a timezone, for example
   `2026-01-01T00:00:00Z`. Search requests use **Approved**, **Stable**, and
   `consentOverride=false`. Unique ID filters the returned results locally.
   Multiple codes within one field use **OR**; type, format and date filters use
   **AND**. Leave a code selection empty for **Any**, or select **Any** on its own.
   Combining **Any** with specific codes is rejected to avoid silently broadening
   a search. Each filter accepts up to 50 selected codes.
   Date **From** bounds are inclusive and **To** bounds exclusive. Either can be
   omitted. For a complete UTC day, use midnight on that day as From and midnight
   on the next day as To. These filter service start/stop metadata; they are not
   document creation dates. The standard also supports creation-time filters,
   which this form does not currently expose.
3. Review the fetched/visible document count and current repository filter in
   **Search results**. Choose **View documents and choose one (N available)** to
   browse the results before selecting a document to validate. The count in this
   option reflects the current filter. This opens the **Select XDS document** form
   with a required **Document** selector, even when
   there is only one result. **Filter repositories** and **Search again** bypass
   document selection. Choose **Back to results** in the document selector to
   return without retrieving anything. Short labels show a
   stable result number, shortened Unique ID, repository name/environment (or
   unknown OID), document type and UTC start time, in that order. Search and filter reports contain
   counts, the selected registry and repository-filter summaries. The **Retrieve selected CDA document**
   report records the full ID, repository OID and both service dates of the selected
   document, including if retrieval fails. Unselected documents are not listed in
   report data.
   Choose **Filter repositories** to show **All repositories**, **Only selected
   repositories**, or **Exclude selected repositories**. Select multiple repositories
   if needed; the choices show document counts. An empty selection shows all results.
   The results summary names the included and excluded repositories for an active filter.
   Filtering uses the saved search results without another DDS request. It filters
   repositories identified by each document's `repositoryID`, not registry endpoints.
   If all documents are hidden, change the filter, choose **Show all repositories**,
   or **Search again**. Filtering and searching again require no document selection.
   A new search resets the repository filter. Stop the ITB session to cancel.
4. ITI-43 retrieves the selected document using the same patient/professional
   context and the retrieval gateway/STS belonging to the searched registry. The
   registry name appears in the session log and search/filter/retrieval reports.
   The session log shows a text preview between **BEGIN RETRIEVED DOCUMENT**
   and **END RETRIEVED DOCUMENT**, before any CDA-content failure is logged. The
   **Retrieve selected CDA document** step report includes **retrieved-document**
   with the complete original bytes for viewing/downloading. Text previews are capped
   at 64 KiB; XML encodings are respected where recognised and invalid XML control
   characters are escaped for display. These diagnostics remain available for
   malformed XML and non-CDA content. Original bytes go to the validator only after
   the CDA-content check passes. Review the usual validation report,
   including findings on the original document's line locations.

Search state expires after 30 minutes of inactivity and when retrieval finishes.
A search can fail with `XDS-NO-ACTIVE-REGISTRIES` when DDS returns
“Ingen aktive registries”. This means DDS reports no active registries for that
search; it does not establish a certificate problem or a CDA validation failure.
Start a new session and try **Type code: Any**, or check DDS availability for the
selected document type. The connector recognises this exact fault and displays a
fixed explanation; other backend error bodies remain hidden.

`XDS-REGISTRY` means DDS returned registry/repository errors, possibly alongside
documents. The session log and step report identify the operation (ITI-18 search
or ITI-43 retrieval), recognised XDS codes, fixed
explanations and suggested next steps. Search failures include the returned
document count when available, because results may be incomplete. Any non-warning
error stops processing; a consent-filter warning alone does not stop a search.

The adapter uses IPF `ErrorCode` enums and adds readable explanations for these codes from
[IHE ITI TF-3, Table 4.2.4.1-2](https://profiles.ihe.net/ITI/TF/Volume3/ch-4.2.html#4.2.4.1):

| Codes | Diagnostic / next step |
| --- | --- |
| `XDSUnavailableCommunity` | Required gateway unavailable; retry or contact the DDS operator. |
| `XDSUnknownCommunity`, `XDSUnknownRepositoryId` | Unrecognised community/repository; check routing and configuration. |
| `XDSMissingHomeCommunityId` | Required community ID missing; check the request. |
| `XDSDocumentUniqueIdError` | Document unavailable or access not authorised; check availability and access. |
| `XDSRegistryBusy`, `XDSRepositoryBusy` | Service busy; retry later. |
| `XDSRegistryOutOfResources`, `XDSRepositoryOutOfResources` | Service lacks resources; retry later. |
| `XDSRegistryNotAvailable` | Repository cannot access the registry; retry or contact the operator. |
| `XDSRegistryError`, `XDSRepositoryError` | Service reports an internal error; contact the operator if it persists. |
| `XDSRegistryMetadataError`, `XDSRepositoryMetadataError` | Invalid metadata; ask the operator to investigate. |
| `XDSResultNotSinglePatient` | Results span patients; processing stops. Check patient matching. |
| `XDSUnknownPatientId` | Patient unrecognised; check test CPR and registration. |
| `XDSUnknownStoredQuery`, `XDSStoredQueryMissingParam`, `XDSStoredQueryParamNumber` | Query contract problem; check the request/backend configuration. |
| `XDSTooManyResults` | Request/response too broad; narrow type, format or date filters. |

For example, a failed retrieval can now log:

```text
XDS-REGISTRY: DDS document retrieval (ITI-43) failed. DDS reported 1 registry error(s): XDSUnavailableCommunity: A required community or repository gateway is unavailable. Document retrieval stopped. Retry later; if the problem persists, contact the DDS operator. Selected repository: 1.2.208.176.43210.8.1.30 (KIH Repository, TEST1 / PRODTEST). CDA validation has not run.
```

The adapter receives typed IPF `ErrorInfo` values directly. It uses the enum's
opcode rather than parsing flattened REST errors or maintaining duplicate code
identifiers. Other standard IPF codes retain their opcode with a generic explanation.
Arbitrary prose, custom codes and SOAP/security content are never echoed. The
observed DDS extraction-error context retains its fixed explanation. Unknown
transport failures use `XDS-BACKEND`; authentication failures use `XDS-ACCESS`.
These describe DDS findings, not CDA validation findings. Existing REST error
representations remain compatible for REST clients.

Retrieval request failures also include **Selected repository**, taken from the
saved search result used for that request. This identifies the attempted target;
it does not imply that an access denial or every other retrieval error is an
outage. The diagnostic includes a bounded, syntactically valid numeric OID and,
for exact known matches, a repository name and documented environment. Unknown
OIDs remain visible with `name/environment unknown`; non-OID or oversized values
are withheld. The original identifier sent to the backend is unchanged.

The display-only catalogue in `XdsRepositories.java` uses MedCom's
[Kom godt igang med dokumentdeling v1.4, pp. 27–30](https://medcom.dk/wp-content/uploads/2023/01/Kom-godt-igang-med-dokumentdeling-1.4-interactive-1.pdf#page=27),
NSP's [repository OID directory, section 3.1](https://www.nspop.dk/pages/releaseview.action?pageId=102380360)
(updated 3 June 2026), and the pinned OpenXDS installation example below:

| Repository OID | Name | Documented environment | Source |
| --- | --- | --- | --- |
| `1.2.208.176.43210.8.10.11` | Aftale DRS | TEST1 | 27 |
| `1.2.208.176.43210.8.20.11` | Aftale DRS | TEST2 | 28 |
| `1.2.208.176.43210.8.1.29` | KIH Repository | TEST2 | 28 |
| `1.2.208.176.43210.8.30.11` | Aftale DRS | PRODTEST | 29 |
| `1.2.208.176.43210.8.1.30` | KIH Repository | TEST1 / PRODTEST | NSP directory §3.1; MedCom p. 29 for PRODTEST |
| `1.2.208.176.43210.8.40.11` | Aftale DRS | UDDANNELSE | 30 |
| `1.2.208.176.43210.8.1.31` | KIH Repository | UDDANNELSE | 30 |
| `1.2.208.176.43210.8.10.999` | Sandbox DROS | TEST1 | NSP directory §3.1 |
| `1.2.208.176.43210.8.20.999` | Sandbox DROS | TEST2 | NSP directory §3.1 |
| `1.2.208.176.43210.8.30.999` | Sandbox DROS | PRODTEST | NSP directory §3.1 |
| `1.2.208.176.43210.8.40.999` | Sandbox DROS | UDDANNELSE | NSP directory §3.1 |
| `1.3.6.1.4.1.21367.2010.1.2.1125` | OpenXDS / OpenText PoC | unknown | OpenXDS installation example |

These are reference labels, not a live routing/availability inventory. The older
MedCom guide lists KIH as unavailable in TEST1, but NSP's newer directory explicitly
lists the same KIH OID in both TEST1 and PRODTEST. The shared OID alone cannot identify
which environment served a result or establish the cause of a retrieval failure.
Names never select endpoints or change access or retrieval.
The catalogue deliberately excludes `homeCommunityId` values and inferred OID
families. Add mappings only with an explicit repository source; retain unknown
environments and qualify example/proof-of-concept identities.

The [DROS request configuration at `4fd67b9316d`](https://git.nspop.dk/projects/NT/repos/drg-data/browse/dros/valideringslibrary-test/dros.val.iti41.request.json?at=4fd67b9316da91f7ae78d301052821f7b00da11a)
labels `1.2.208.176.43210.8.10.999` and `…8.20.999` as TEST1/TEST2 sandbox
prefixes and links to the NSP directory, which explicitly confirms their role as
repository IDs and supplies the PRODTEST/UDDANNELSE entries. Prefix options alone
are not treated as proof of repository identity.

The [OpenXDS installation instructions at `e6df3fb88a2`](https://git.nspop.dk/projects/COM/repos/openxds/browse/compose/Installation%20af%20openxds-server.txt?at=e6df3fb88a2b7a6f59a3c4255dc1a25927335002)
give `1.3.6.1.4.1.21367.2010.1.2.1125` as an example of
`OPENXDS_UNIQUE_REPOSITORY_OID`, reusing the existing OpenText repository OID for
an OpenXDS proof of concept. The display label therefore includes both names and
the PoC qualification, without asserting a current implementation or environment.

NSP's [DDS driftsvejledning](https://www.nspop.dk/pages/releaseview.action?pageId=191500056)
contains `1.3.6.1.4.1.21367.2010.1.2.1125` as both a repository ID and a community ID
in sample audit logs, without establishing a repository name or environment. Its
catalogue label comes from the separate installation source above. The other OIDs on that page describe coding
schemes/identifier systems. Its linked DKS documentation describes service routing,
not a repository OID directory. The guide also documents `repositoryUniqueId` in
DDS's outgoing-retrieval SLA logs, which can help the operator trace a failed call.

Rebuild/restart the XDS service to apply diagnostic changes, then start a new test
session. Historical reports and logs retain their original messages.

A restarted XDS service also invalidates pending searches; start a new test session.
Search results are limited to 500 and retrieved documents to 10 MiB. Narrow the
filters when the limit is reached. Malformed XML and non-CDA content stop at the
retrieval step, before conformance validation.

## TEST1 access and configuration

The default endpoints are TEST1 STS, DDS registry and DDS repository. Live access
requires a current employee certificate and successful TEST1 search/retrieval.
The image contains no configured signing identities. Mock tests and successful
startup do not establish live access or complete DDS-01 coverage.

Place certificates, private keys and password files in ignored **`xds-service/local/`**,
mounted read-only as `/local`. Configure named entries in
`xds-service/local/application.properties`, for example:

```properties
xds.credentials.employee.pkcs12=/local/employee.p12
xds.credentials.employee.password-file=/local/certificate-password
xds.credentials.service.certificate=/local/service-cert.pem
xds.credentials.service.private-key=/local/service-key.pem
```

PEM and PKCS#12 identities can coexist. Add as many named entries as needed; there
are no numbered slots. Display names normally come from the certificate, with an
optional `display-name` override. The API supplies certificate type and validity
dates. These do not prove STS trust or DDS authorisation.

Set `XDS_VAULT_PASSWORD` in the process environment or ignored
`get-up-and-running/.itb.env`, or set `xds.vault.password` in
`xds-service/local/application.properties`. This password protects the in-memory
credential vault and is separate from a PKCS#12 bundle's password file. There is
no default: loading signing identities rejects a missing or blank vault password.
The service can start without it when no identities are configured.

Keep private keys and password files mode `0600`. In ignored
`get-up-and-running/.itb.env`, set `XDS_LOCAL_USER` to their owner's UID:GID when
necessary (for example `501:20` on macOS). The default runtime UID:GID is
`65532:65532`. Also configure the role and authorisation code for your test identity:

```bash
XDS_LOCAL_USER=501:20
ITB_ENABLE_XDS=true
XDS_ROLE=Læge
XDS_AUTHORIZATION_CODE=your-test-authorisation-code
```

Endpoint variables are `XDS_STS_URL`, `XDS_REGISTRY_URL` and `XDS_REPOSITORY_URL`.
The maintained defaults and code lists are in `xds-service/application.properties`;
`xds-service/local/application.properties` can override them. The format list supplies
published MedCom PHMR/QFDD/QRD formats, legacy PHMR, and `phmr-v2.1` observed in
TEST1. Use **Any** for unlisted formats. XDS format codes are not CDA releases.

The service runs on Java 25 with IPF 5.3 and SEAL 3. TEST1 still returns
RSA-SHA1-signed DGWS cards, so Compose enables `ALLOW_TEST1_LEGACY_SHA1`, retaining
signature and trust verification. Set `XDS_ALLOW_TEST1_LEGACY_SHA1=false` when the
STS uses modern signatures. The service's default outside this setup is strict.

XDS services publish no host ports. The connector exposes credential/code reads,
ITI-18 and ITI-43; registration, arbitrary retrieval IDs and consent override are
not exposed. Errors are sanitised, while the retrieved test document is included
in the session diagnostics. ITB stores test inputs and reports; use test data and
control access. Restarting the backend clears uploaded credentials and SOAP log
references; named credentials reload from their configured files.

## Build and upgrades

`xds-service/` owns the complete service, including the imported REST implementation,
GITB adapter, tests, Maven build and Dockerfile. It builds without a sibling
`ihe-xds-api` checkout or a published backend image. Successful default-branch
XDS integration runs publish `docker.io/trifork/itb-dk-extensions-xds` for amd64 and
arm64 with commit and current-head `latest` tags; bootstrap pulls published images.
The existing manual/`xds-v*` release workflow remains available. See
[container publishing](../README.md#published-container-images) for details.
See [service architecture](xds-service.md) and [build instructions](../xds-service/README.md).

When migrating an existing setup, remove legacy `COMPOSE_FILE` overrides from
`.itb.env` that select the retired separate backend jar or image; retain credential
and UID settings. Apply the combined service without restarting ITB:

```bash
docker compose --env-file get-up-and-running/.itb.env --profile xds up -d --build --no-deps --wait xds-api
ITB_ENABLE_XDS=true ITB_RUN_EXAMPLE=false ITB_FORCE_NEW_SESSION=true ./get-up-and-running/setup-itb.sh
```

Remove the old standalone `xds-connector` container after the new service is healthy.
The combined container retains that DNS alias for older definitions; newly registered
services use `http://xds-api:8080/processing?wsdl`. Restarting clears in-memory
searches, so use the new pending sessions. Previous sessions and reports are retained.

## Implementation and provenance

The REST API supports optional REST query arrays
`typeCodes` and `formatCodes`, each containing `{ "code": "...", "codeScheme": "..." }`
objects. The single-code `typeCode` and `formatCode` objects are also supported. When
both forms are supplied, their values are combined using OR and duplicates are
removed. Empty arrays add no restriction; malformed array entries are rejected.
The connector sends a single code using the original field and multiple codes
using the corresponding array. IPF encodes each array in one stored-query slot.

ITB's native interaction forms do not support live dependencies between fields.
The action and document selectors therefore use separate `interact` steps with a
TDL `if` branch; the document request is mandatory only in the validation branch.
The **Back to results** choice is handled by the flow and never sent for retrieval.

The code and repository selection controls use ITB's native `SELECT_MULTIPLE` input, whose result
is a comma-separated list of the displayed labels. Identity, code, repository, document and
action selections use matching values and labels so ITB's interaction reports
retain the actual choices, including on failure. Code labels include the code and
scheme; identity labels include certificate type and expiry. Commas within labels
are replaced by semicolons for ITB's list encoding, and duplicate labels receive
numbered suffixes. The connector resolves labels through its transaction's saved
choices to the original credential IDs, code objects, repository IDs and document handles; it does
not parse backend identifiers from submitted labels. Legacy ID inputs remain
supported for older test definitions. Existing sessions and reports retain their
original forms; redeploy the suite and start new sessions after changing the flow.

- The shared ITI-43 service returns original bytes and typed IPF errors. GITB attaches
  those bytes directly, preserving encoding, declarations, whitespace and locations.
  REST retains `responseBase64`, optional `includeFormattedResponse=false`, and the
  default formatted `response` field.
- `xds-service/src/main/java/com/trifork/ihexdsapi/gitb/` implements GITB
  `choices`, `search`, `filter`, `retrieve` in a processing transaction. Server-side
  opaque handles bind retrieval to the current search and its visible subset.
  Hidden document handles are rejected until the filter restores them.
- `get-up-and-running/xds-flow.xml` is inserted at packaging time by `enable-xds.py`.
  All registered testcase IDs and their validation targets are preserved.
- `get-up-and-running/setup-itb.sh` registers `$DOMAIN{xdsConnector}` as a SOAP
  processing service at `http://xds-api:8080/processing?wsdl`.

Sources: [MedCom XDS portal guide](https://svn.medcom.dk/svn/releases/Standarder/IHE/XDS-portal/XDS-portal_guide.pdf),
[service API specification](../xds-service/src/main/openapi/ihe-xds-api.yaml),
[MedCom metadata profile](https://svn.medcom.dk/svn/releases/Standarder/IHE/DK_profil_metadata/XDS%20Metadata%20for%20Document%20Sharing.%20Danish%20profile%20v.1.0.0.pdf),
[GITB processing service contract](https://www.itb.ec.europa.eu/docs/services/latest/processing/index.html),
[GITB interaction steps](https://www.itb.ec.europa.eu/docs/tdl/latest/constructs/index.html#interact).

## Verification

```bash
mvn --batch-mode --no-transfer-progress -f xds-service/pom.xml -Plint verify
python3 tests/test_xds_packaging.py
```

`xds-service/tests/compose.mock.yml` runs the actual GITB adapter with deterministic in-process
services from test sources. The fixture is absent from the production image.
The CI workflow starts a full ITB, deploys the actual XDS suite and submits real
interactions through the Java `ItbFlowIT` Failsafe suite. It exercises uploads, zero/one/multiple results, search-again,
Unique ID filtering, repository inclusion/exclusion and empty-filter recovery,
missing document selection, wrong-release rejection, access/registry failures and non-CDA
retrieval. Backend REST/SOAP contract tests verify original ITI-43 bytes, JSON
Base64 encoding and date/status mapping. Java connector tests additionally cover
SOAP interoperability, exact bytes including non-UTF-8 XML, date/code mapping, timeouts and invalid/expired/cross-session handles.

To avoid building the CDA dependency in XDS CI, set the repository Actions variable
`CDA_RUNTIME_IMAGE` (or workflow input `cda_runtime_image`) to a published complete
CDA service image, preferably a digest. The workflow pulls it, records the image
ID in `test-results/xds/cda-image.txt`, and builds only XDS and its fixture. A pull
failure fails the job. If no image is configured, CDA is built from the checkout.

To run against a local ITB, temporarily switch the optional backend:

```bash
docker compose -f docker-compose.yml -f xds-service/tests/compose.mock.yml --profile xds build xds-api
docker compose --env-file get-up-and-running/.itb.env -f docker-compose.yml -f xds-service/tests/compose.mock.yml --profile xds up -d --no-deps --wait xds-api
ITB_ENABLE_XDS=true ./get-up-and-running/setup-itb.sh
./get-up-and-running/setup-test-user.sh
mvn --batch-mode --no-transfer-progress -f xds-service/pom.xml -Pitb-it -Dit.test=ItbFlowIT verify
# Restore the real TEST1 backend after testing:
docker compose --env-file get-up-and-running/.itb.env --profile xds up -d --build --no-deps --wait xds-api
```

The `itb-it` profile explicitly enables these external-stack tests; ordinary
`mvn verify` does not contact ITB. `ItbFlowIT` creates separate test sessions and
preserves existing history. The setup commands update suite definitions and may
replace saved pending session slots; existing session reports remain available. Do not use
`down --volumes` on an existing installation. CI reports are in
`xds-service/target/surefire-reports/`, `xds-service/target/failsafe-reports/` and `test-results/xds/`.

`xds-service/tests/check_backend.py` checks local readiness without calling TEST1.
`check_bootstrap.py` exercises session reuse while switching upload/XDS modes;
CI runs it against its disposable ITB. Render saved test results with
`python3 xds-service/tests/report_summary.py`. The separate
[quality workflow](../.github/workflows/xds-quality.yml) enforces Spotless, compiler
warning checks, PMD, CPD, coverage and self-contained Sonar Java analysis before
integration or publication; see the [build guide](../xds-service/README.md).
