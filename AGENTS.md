# Working in this repository

## Architecture and navigation

Read [README.md](README.md) for setup and interfaces. The independent Java 25
projects `cda-validator/` and `xds-service/` have separate Maven builds; do not add
a shared parent. `itb-ui/` independently owns the frontend extension and gateway.
Owned Java packages use `com.trifork`; preserve upstream namespaces.

- CDA: filesystem domain `cda-validator/domain/cda-dk/`, plugin under
  `src/main/java/com/trifork/itb/plugin/`, preview under `com.trifork.itb.preview`.
  Keep runtime domain/API name `cda-dk`. Docker builds and installs the plugin;
  never commit or manually copy JARs into the domain's `plugins/` directory.
- Validation remains **XSD → Schematron/XSLT → Gazelle**, merged into GITB TAR.
  All releases have partial coverage. Do not equate a passing sample with full
  compliance or remove validation stages to match future plans.
- [specs.md](specs.md) holds acceptance criteria; check implementation and current
  GitHub issues before declaring them complete. Keep prose `requirements.md` as Markdown.
- [rulesets.json](cda-validator/domain/cda-dk/rulesets.json) is the release catalogue;
  [versioning](docs/versioning.md), [CDA conformance](docs/cda-conformance.md) and
  [PRO conformance](docs/pro-conformance.md) hold normative references and gaps.
- [docs/xds.md](docs/xds.md) describes DDS configuration and verification. Read it
  before changing integration; [docs/xds-service.md](docs/xds-service.md) covers contracts.

## Validation changes

- Select exact release IDs: REST `validationType`, SOAP/TDL `type`. Reject unknown
  or unversioned values without fallback. Profile release, XML marker, document
  version and TDL package version are distinct; follow the versioning guide.
- New rules need normative version/clause references and positive/negative cases.
  Put findings on the offending element or nearest existing ancestor; preserve
  stable rule IDs. Never weaken rules or negative sample expectations just to pass CI.
- When adding a release, update catalogue, configuration, routes, rules, samples,
  TDL registration and documentation together; test cross-release rejection.
  Both PHMR routes retain PHMR-specific Java checks.
- Preserve vocabulary includes and relative paths in large imported XSLTs; avoid
  bulk formatting. Do not register include-only Schematrons as standalone rules.
- Maintain PRO `.sch` sources and regenerate their inventory with
  `python3 scripts/conformance-rule-inventory.py`. Paired QRD/QFDD validation requires
  its documented envelope, not single-document registration.
- `samples/validation-cases.json` records expected outcomes, including negative
  official examples. Keep per-case execution and reporting.
- CDA resolves pinned Gazelle dependencies from HTTPS IHE Nexus via Trifork's
  anonymous `maven-ihe-proxy` repository.
  Keep its `irisa-sumo` repository ID to override legacy HTTP URLs in upstream POMs.
  Never commit Maven caches, downloaded JARs or repository credentials.

## Preview and ITB frontend

The upload page and report extension share `src/main/resources/rendering/CDA.xsl`.
Preview must preserve original validation input, external-resource restrictions,
HTML sanitisation, no-store responses and sandboxed iframes. Keep provided
Spring/Servlet/jsoup dependencies compatible with the pinned validator runtime.

`itb-ui/` builds a separate Nginx gateway image containing frontend
assets compiled from checksum-pinned ITB release source with the Angular preview
extension. Keep stock ITB images unchanged;
do not mount generated host assets. Compose builds it directly. Keep `/cda-preview`
same-origin, WebSockets working, and cookies/tokens out of renderer requests.
Compose shares the stock UI image pin with the gateway build through a YAML anchor.
`fetch-source.mjs` checks that pin against `upstream.json` and verifies the source
archive checksum before applying `apply.mjs` and compiling Angular. Review the
source extension and update both pins when upgrading ITB. The image records
source/input/asset provenance and CI publishes build attestations. See the [extension README](itb-ui/README.md).

## Development and verification

Use checks appropriate to the change; documentation-only edits need link/path and
diff checks. Both projects use Java 25, JUnit 5 Jupiter, Spotless AOSP formatting
and compiler warnings as errors. XDS additionally gates PMD/CPD and JaCoCo at
80% lines / 60% branches. Both require zero-finding self-contained Sonar Java scans.
Fix findings; do not skip unavailable analyzers. Generated OpenAPI sources are
excluded from analysis and coverage.

Run from the repository root:

```bash
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
bash cda-validator/tests/run-container-tests.sh
mvn --batch-mode --no-transfer-progress -f xds-service/pom.xml -Plint verify
python3 tests/check-rulesets.py
python3 tests/test_validator_image.py
python3 tests/test_xds_packaging.py
python3 cda-validator/tests/test_reporting_summary.py
```

Format Java using `mvn -f <project>/pom.xml spotless:apply`. Sonar installer/runner
scripts live in `xds-service/scripts/`; use `--project cda-validator` for CDA.
Keep the README quality table aligned with POMs and workflows.

`tests/`, `scripts/`, `get-up-and-running/` and `docs/` each have a `README.md`
with one table row per file stating what it does and where it is used. Update the
row with every change to a file in that folder, add a row when adding a file and
remove it when deleting one. Keep these READMEs short: tables, no tutorials.

CDA logic, artifact or image changes require the actual container tests. The
isolated runner preserves local ITB and writes diagnostics to `test-results/`;
Java reports go under project `target/`. Keep the 4 GiB container / 3 GiB heap
allowance for large XSLTs. Distinguish failed, unreached and completed checks.

`CDA_RUNTIME_IMAGE` uses a complete prebuilt service; `CDA_VALIDATOR_IMAGE` selects
a base for a source build. Never silently build after a published-image pull fails.
Keep fingerprints and resolved image IDs in reports. The standalone HTTP client
`cda-validator/tests/pom.xml` shares integration sources; align its JUnit/Jackson/jsoup
versions with the main POM. Normal tests must not fetch the public QFDD catalogue;
`SpgdefQfddIT` is opt-in, preserves original bytes and separates fetch/service errors
from conformance findings.

## Local state and deployment

Preserve user sessions and history. Never run `reset.sh` or `down --volumes` without
an explicit reset request. Ignored `.itb*.env` files contain credentials and saved
state: do not print or commit them. Obtain session IDs from state, not documentation.
Keep `session_catalogue.py`, suite order and release registration aligned; existing
sessions retain their test definitions.

Deploy CDA changes with `docker compose up -d --build --no-deps cda-validator`;
restart alone does not rebuild resources. XDS fixture tests must restore the real
backend afterward and must not reset ITB. The opt-in real interaction check is
`mvn -f xds-service/pom.xml -Pitb-it -Dit.test=ItbFlowIT verify` after fixture setup.

## XDS contracts and data

- Compose profile `xds` runs one `xds-api` container. REST and GITB adapters call
  shared Java services. Runtime defaults are `xds-service/application.properties`;
  private keys/overrides belong in ignored `local/`. Keep both out of image contexts.
- Each named registry owns ITI-18, ITI-43 and STS endpoints. Accept configured IDs,
  never user URLs. Preserve the selected route through filtering and retrieval;
  reject unknown IDs and retain legacy single-endpoint support.
- GITB retains patient/professional/search context server-side with opaque handles.
  Preserve QName `ProcessingServiceService`, REST `responseBase64` and formatting
  flags. Do not accept raw retrieval IDs or consent override from interaction input.
- Resolve readable dropdown labels through server-side maps, not parsed identifiers.
  Preserve comma sanitisation, duplicate disambiguation and legacy opaque values.
  Multi-code filters are OR within each field, AND across fields.
- Repository filtering uses saved results without another DDS request. Hidden
  handles remain unavailable until restored. Search/filter reports contain counts
  and repository summaries; full document metadata belongs only in retrieval reports.
- Preserve original retrieved bytes, attached XML and bounded log preview before
  CDA-content error exits. Never log SOAP envelopes, tokens or backend HTTP bodies.
- Repository names are display-only, sourced mappings. Keep unknown OIDs visible;
  never infer routing or repository identity from fault prose.
- Identity validity is checked before search; expose dates as ISO UTC. Public
  certificate metadata and mock tests do not establish STS trust or live DDS access.

## CI and pins

Compose is the source of the CDA base image pin; read it with
`python3 scripts/validator_image.py --print-image`. ITB components use explicit
release tags and multi-platform digests. Keep the Angular source extension compatible with the stock image.

Publication must use the tested `workflow_run.head_sha`, with same-repository,
default-branch push and success guards before package-write access. Advance
`latest` only for the current default-branch head. Never publish PR code with
privileged credentials. CDA pin-update PRs explicitly invoke candidate validation
because token-created PRs do not trigger ordinary workflows; updates require review.
The daily public QFDD monitor is independent of source-image publication.
