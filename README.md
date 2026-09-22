# ITB DK extensions

Danish MedCom CDA validation and DDS document retrieval for the
[Interoperability Test Bed](https://www.itb.ec.europa.eu/).
The repository contains three projects:

- [cda-validator](cda-validator/README.md): CDA domain resources, Gazelle plugin
  and browser preview, packaged on the pinned `isaitb/xml-validator` image.
- [xds-service](xds-service/README.md): ITI-18 search and ITI-43 retrieval with
  STS authentication, exposed through REST and GITB SOAP adapters.
- [itb-ui](itb-ui/README.md): the ITB frontend extension and Nginx gateway image.

CDA and XDS use Java 25 with independent Maven builds; the UI has its own Docker
build and browser tests.

**All registered releases have partial conformance coverage.** A successful
validation does not establish full compliance. See [coverage](docs/cda-conformance.md)
and [PRO coverage](docs/pro-conformance.md).

## Get up and running

Requires Docker Compose, Python 3.12+, curl, jq, zip and openssl.

```bash
./get-up-and-running/start.sh
# Or include DDS search and retrieval:
ITB_ENABLE_XDS=true ./get-up-and-running/start.sh
```

Bootstrap pulls the published services and frontend extension from Docker Hub,
configures ITB, runs a connection check and provisions `cda-test@itb` with a session
for each release.
Credentials and session state are saved in ignored `get-up-and-running/.itb*.env`
files. Existing test history is preserved; do not use `reset.sh` or remove Docker
volumes unless you intend to delete it.

Startup refreshes the published `latest` images and stops if any pull fails;
it never falls back to a source build. No `dhi.io` login or local Java/Node build
toolchain is needed. To use specific image tags or digests, set `CDA_RUNTIME_IMAGE`,
`ITB_UI_RUNTIME_IMAGE` and, when XDS is enabled, `XDS_RUNTIME_IMAGE` in the environment
or ignored `get-up-and-running/.itb.env`.

For development, explicitly build the current checkout instead:

```bash
ITB_BUILD_FROM_SOURCE=true ./get-up-and-running/start.sh
```

Source builds need access to their build dependencies, including `docker login dhi.io`
for the hardened Node image. The base `docker-compose.yml` remains the source-build
configuration; startup adds `get-up-and-running/compose.published.yml` by default.

| Interface | Local address |
| --- | --- |
| ITB guided sessions | [ITB UI](http://localhost:9000) |
| CDA upload and preview | [Validator web UI](http://localhost:8091/cda-dk/upload) |
| REST validation (`POST`) | [Validation endpoint](http://localhost:8091/rest/cda-dk/api/validate) |
| REST specification | [OpenAPI](http://localhost:8091/v3/api-docs) |
| SOAP validation | [WSDL](http://localhost:8091/api/cda-dk/validation?wsdl) |

### HTTPS deployment

Point `itb.trifork.dev`'s DNS records at the Docker host and allow inbound TCP
ports **80, 443 and 8443** (optionally UDP 443 for HTTP/3). Requires Compose 2.24.4+.
Then run:

```bash
ITB_HTTPS_HOST=itb.trifork.dev ./get-up-and-running/start.sh
# Add ITB_ENABLE_XDS=true to include DDS retrieval.
```

Save `ITB_HTTPS_HOST=itb.trifork.dev` in the existing ignored
`get-up-and-running/.itb.env` to retain HTTPS on subsequent starts.
Startup adds `get-up-and-running/compose.https.yml`, which runs pinned Caddy with
[automatic certificate issuance, renewal and HTTP redirects](https://caddyserver.com/docs/automatic-https).
Certificates and ACME account state persist in the `caddy-data` volume.

Caddy sets `Strict-Transport-Security: max-age=31536000` on both HTTPS endpoints,
replacing any upstream HSTS header. The one-year policy covers all ports of the
configured hostname; it does not add `includeSubDomains` or request preloading.
Caddy preserves each application's Content-Security-Policy: ITB's policy passes
through the gateway with same-origin preview frames allowed, while the validator
retains its per-response script nonces and the renderer's restrictive preview policy.
Avoid adding a shared CSP at the edge that blocks those application requirements.

| Public HTTPS address | Internal Compose destination |
| --- | --- |
| `https://itb.trifork.dev/` (ITB, WebSockets and `/cda-preview`) | `gitb-ui-gateway:9000`, which routes preview to `cda-validator:8080` |
| `https://itb.trifork.dev/itbsrv/` (callbacks) | `gitb-srv:8080` |
| `https://itb.trifork.dev:8443/cda-dk/upload` (validator UI) | `cda-validator:8080` |
| `https://itb.trifork.dev:8443/rest/cda-dk/api/validate` (REST) | `cda-validator:8080` |
| `https://itb.trifork.dev:8443/api/cda-dk/validation?wsdl` (SOAP) | `cda-validator:8080` |
| `https://itb.trifork.dev:8443/v3/api-docs` (OpenAPI) | `cda-validator:8080` |

The validator uses a separate HTTPS port to preserve its own root-relative assets
and API routes. Caddy uses container ports, not host mappings such as `8091`.
HTTP ports 9000, 8080 and 8091 are bound to loopback for local bootstrap; XDS remains
internal. Bootstrap readiness checks use these local endpoints and do not confirm
public certificate issuance; inspect `https-proxy` logs and open the HTTPS URLs
after DNS is ready. Keep the HTTPS overlay included when running Compose manually:

```bash
docker compose --env-file get-up-and-running/.itb.env \
  -f docker-compose.yml -f get-up-and-running/compose.published.yml \
  -f get-up-and-running/compose.https.yml logs --tail=100 https-proxy
```

After updating the mounted `Caddyfile`, reload only Caddy to apply header changes
without restarting ITB sessions (no image rebuild is needed):

```bash
ITB_HTTPS_HOST=itb.trifork.dev docker compose --env-file get-up-and-running/.itb.env \
  -f docker-compose.yml -f get-up-and-running/compose.published.yml \
  -f get-up-and-running/compose.https.yml exec -T https-proxy \
  caddy reload --config /etc/caddy/Caddyfile --adapter caddyfile
```

The gateway's HTTPS forwarding fix must be included in the published UI image;
publish the updated checkout before deploying with the default image selection.
For source builds, set `ITB_BUILD_FROM_SOURCE=true` as above.

To update test definitions without rerunning the connection check:

```bash
ITB_RUN_EXAMPLE=false ./get-up-and-running/setup-itb.sh
```

Pending sessions are reused; completed or expired sessions are replaced. Set
`ITB_FORCE_NEW_SESSION=true` to create new sessions while retaining previous ones.

## Validation and preview

The validation chain is **XSD → Schematron/XSLT → Gazelle Java plugin**, with
findings merged into one GITB TAR report. Web, REST and SOAP use the same rules.
REST selects the exact release through `validationType`; SOAP/TDL uses `type`.
Unknown or unversioned selections are rejected.

Supported targets are APD 2.0.1, CPD 2.0.0, PDC 2.0 and 3.0.0, PHMR 1.3 and 2.1.0,
QRD 1.3.2, QFDD 1.2, PHAD 1.0.1, PMR 2.0.0, PRF 3.0.0 and PSCR 2.0.0.
The [release catalogue](cda-validator/domain/cda-dk/rulesets.json) maintains exact
API identifiers and artifact mappings; [versioning](docs/versioning.md) explains
release identity. `GET /rest/cda-dk/api/info` lists deployed selections.

**View CDA** on the upload page and ITB XML report attachments renders the CDA
header and narrative. Preview also works for documents that fail validation;
structured questionnaire fields may not be displayed. It preserves the original
XML and does not change the validation result.
The [ITB UI extension](itb-ui/README.md) serves compiled frontend
assets compiled from pinned ITB release source with the Angular preview extension. Stock ITB
images remain unchanged; there are no generated host asset mounts.

## DDS retrieval

Configure signing identities and registry bundles following [XDS setup](docs/xds.md).
Each registry has its own search, retrieval and STS endpoints. Runtime defaults
are in `xds-service/application.properties`; private keys and overrides belong
in ignored `xds-service/local/`.

Users can select a registry, search with multiple type/format codes, and include
or exclude repositories from fetched results without repeating the search.
Reports summarise counts and filters; full metadata and original bytes are
attached only for the selected document. Live DDS access requires valid signing
credentials and authorisation.

## Development and quality gates

Run from the repository root with Java 25 and Maven:

```bash
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
bash cda-validator/tests/run-container-tests.sh
mvn --batch-mode --no-transfer-progress -f xds-service/pom.xml -Plint clean verify
```

| Gate | CDA | XDS |
| --- | --- | --- |
| JUnit 5 unit/integration tests | Yes | Yes |
| Spotless and compiler warnings as errors | Yes | Yes |
| Self-contained Sonar Java, zero findings | Yes | Yes |
| PMD / CPD | No | Yes (`lint` profile) |
| JaCoCo thresholds | Not configured | 80% lines / 60% branches |

Sonar runs separately from Maven and is mandatory in CI. Both projects use
`xds-service/scripts/install-sonar.py` and `sonar-java.py`; pass
`--project cda-validator` for CDA. See the project READMEs for commands and reports.

Container tests use an isolated validator and preserve local ITB sessions.
`CDA_RUNTIME_IMAGE` selects a complete prebuilt service; `CDA_VALIDATOR_IMAGE`
selects an upstream base for a source build. To deploy local CDA changes:

```bash
docker compose up -d --build --no-deps cda-validator
```

## Published container images

Successful default-branch CI publishes separate amd64/arm64 packages:

- `docker.io/trifork/itb-dk-extensions-cda`
- `docker.io/trifork/itb-dk-extensions-xds`
- `docker.io/trifork/itb-dk-extensions-itb-ui` (gateway and extended frontend)

Images have immutable commit tags `sha-<full-commit-SHA>`; `latest` advances only
for the current default-branch head. PR runs do not publish. The gateway is gated
by XDS integration, including browser tests, and includes build provenance/SBOM
attestations plus image provenance and asset checksums. See the
[publisher](.github/workflows/publish-images.yml) and
[XDS release workflow](.github/workflows/publish-xds.yml).
`get-up-and-running/start.sh` pulls these images by default. Direct use of the base
`docker-compose.yml` remains available for source builds and CI.

The publishers authenticate through [Docker Hub OIDC](https://docs.docker.com/security/authentication/oidc-connections/create-manage/)
using `docker/login-action` and publish with `docker/build-push-action`.
In Docker Home, select **trifork → Identity & auth → OIDC connections** and create
a connection with these rulesets:

| GitHub subject claim | Docker Hub resources | Access |
| --- | --- | --- |
| `repo:trifork/itb-dk-extensions:ref:refs/heads/master` | The three image repositories above | Read/write |
| `repo:trifork/itb-dk-extensions:ref:refs/tags/xds-v*` | `trifork/itb-dk-extensions-xds` | Read/write |

The repository currently uses GitHub's default, name-based OIDC subject format.
Copy the connection ID into the GitHub Actions **variable**
`DOCKERHUB_OIDC_CONNECTIONID`. No Docker Hub password or access-token secret is
needed. Only publishing jobs receive `id-token: write`; their one-hour tokens
cover the multi-platform build and final tag update. The release publisher also
checks that its tested commit belongs to the default branch before authentication.

Create the three Docker Hub repositories as public so PR validation and the daily
QFDD monitor can pull without registry credentials. The daily monitor defaults to
`docker.io/trifork/itb-dk-extensions-cda:latest`; `CDA_RUNTIME_IMAGE` can select a
specific published image for it or XDS integration. Existing explicit GHCR image
references remain supported for reads. Publication requires the OIDC connection,
these workflows on GitHub, and successful validation runs.

All four ITB components are pinned to release 1.29.5 and multi-platform digests.
The CDA upstream pin is maintained in `docker-compose.yml`; read it with
`python3 scripts/validator_image.py --print-image`. The
[daily updater](.github/workflows/update-validator-image.yml) opens tested pin-update
PRs for manual review. The independent [daily QFDD check](.github/workflows/validate-spgdef-qfdd.yml)
fetches all documents listed at [SPG QFDD](https://spgdef.dk/qfdd/) and validates
original bytes against `qfdd.v1.2`, retaining documents and reports as CI artifacts.

## Documentation and provenance

- [AGENTS.md](AGENTS.md): repository editing and verification conventions.
- [Requirements](requirements.md) and [specifications](specs.md): scope and acceptance criteria.
- [Example results](docs/example-validation-report.md) and [samples](samples/README.md).
- [Validation slides](docs/cda-validation-slides.html): business overview.
- [Dependency review](docs/dependency-review.md), including Gazelle artifact provenance and available versions.

Schemas and examples originate from [MedCom / HL7](https://svn.medcom.dk/svn/releases/Standarder/HL7/).
Schematrons come from [MedCom](https://github.com/medcomdk/cda-validator-schematron-resources)
and [KvalitetsIT](https://github.com/KvalitetsIT/cda-validator); confirm redistribution
terms with MedCom where upstream has no explicit licence. Pinned Gazelle artifacts
are downloaded with their original POMs from the
[IHE Nexus repository](https://nexus.ihe-catalyst.net/repository/maven-public/);
upstream licence declarations and notices remain in those POMs and JARs.
The XDS service retains its [MIT licence](xds-service/LICENSE); the ITB frontend
retains upstream EUPL and third-party notices.
