# CDA validator

Independent Java 25 project packaging the `cda-dk` filesystem domain, Gazelle Java
plugin and browser preview on the pinned `isaitb/xml-validator` image. Validation
runs XSD, Schematron/XSLT and Gazelle checks. All releases have partial coverage;
see [conformance](../docs/cda-conformance.md) and the [release catalogue](domain/cda-dk/rulesets.json).
[Setup and web/REST/SOAP links](../README.md#get-up-and-running) are in the root README.

## Layout

- `domain/cda-dk/`: configuration, catalogue, schemas, rules and vocabularies.
- `src/main/java/com/trifork/itb/plugin/`: Gazelle integration, PHMR checks and the QRD/QFDD
  comparison (`QrdQfddPairRules`, `QfddResolver` with the embedded, SPGDEF and combined
  resolvers).
- `src/main/java/com/trifork/itb/preview/`: upload-page CDA preview extension.
- `src/main/resources/rendering/`: the shared display stylesheet `HL7_CDA_stylesheet.xsl` and its
  label file `cda_l10n.xml` (see below), plus the preview script.
- `src/test/`: Java tests and XML fixtures.
- `tests/`: isolated container runner, standalone HTTP test-client POM and reporting.

## QFDD source

A QRD is also compared with the QFDD it references. Where that QFDD comes from is set by the
environment variable `CDA_QFDD_RESOLVER` (Compose passes it through): `embedded` (default, offline),
`spgdef` (the public catalogue at <https://spgdef.dk/qfdd/>) or `combined` (embedded first, then
spgdef). `spgdef` and `combined` send the QFDD id, and nothing else, to spgdef.dk. Details, the
checks made on the catalogue and on each download, and the reported outcomes are in
[PRO conformance](../docs/pro-conformance.md#qfdd-resolvers). The live catalogue is only touched by
the opt-in `mvn test -Dtest=SpgdefLiveTest -Dcda.live.spgdef=true`. The same switch enables
`SpgdefCorpusLiveTest`, which compares generated responses with every form in the catalogue.

## Display stylesheet

"View CDA" renders with the HL7 Structured Documents WG "CDA R2 StyleSheet" 4.0.2 beta 2
(Apache License 2.0), which MedCom publishes at
<https://svn.medcom.dk/svn/drafts/Standarder/HL7/CDA-Stylesheet/HL7_CDA/>. Both files are
unchanged copies, pinned by SHA-256 in `CdaRendererTest`; they are bundled and never fetched
at runtime (external stylesheet access stays disabled, and the resolver serves only these two
resources). The renderer passes `useJavascript=false` and `limit-external-images=yes`, and
the output is still sanitised and shown in a sandboxed iframe. To update, replace both files,
review the diff and change the hashes in the test.

**Danish.** The upstream label file has no Danish, so `cda_l10n_da.xml` supplies 113 `da-dk`
labels (header labels, months, address and participant types, identifier names such as CPR). It is
merged into the upstream labels in memory at start-up, which never changes an upstream value; a
language the file does not cover still falls back to English. The stylesheet writes dates as "Month
day, year" for everything but Dutch, so `CdaRenderer.withDanishDates` also inserts a Danish branch
("13. maj 2025"). That is the only change to the stylesheet, made in memory, and it refuses to apply
to a stylesheet it does not fit. The wording is a draft that a Danish speaker should review. To see
what a new stylesheet needs, the keys it requests can be logged while rendering the sample documents.

That stylesheet shows the header and the narrative only. For a questionnaire form definition (QFDD)
or response (QRD) the preview therefore adds a list of the structured entries, written by our own
`questionnaire.xsl`: each answer of a response, or each question of a form with its options,
limits, ranges and preconditions. It uses only `xsl:value-of`, so document text can never become
markup, and the output passes through the same sanitiser, CSP and sandbox.

Docker builds `validator-plugin-cda-dk.jar` and installs it inside the domain.
Do not commit plugin binaries or bind-mount over the image's domain directory.
The thin `validator-plugin-cda-dk-preview.jar` is loaded separately using
PropertiesLauncher; its provided runtime dependencies must match the upstream image.

## Build and verify

Maven downloads pinned Gazelle dependencies through
[Trifork's IHE Nexus proxy](https://nexus3.trifork.com/repository/maven-ihe-proxy/)
and standard libraries from Maven Central. An empty Maven cache requires access
to both repositories; no credentials or checked-in Maven artifacts are needed.
The proxy fetches uncached artifacts from IHE Nexus and retains cached artifacts
for subsequent host and Docker builds.

Run from the repository root with Java 25 and Maven:

```bash
mvn --batch-mode --no-transfer-progress -f cda-validator/pom.xml clean verify
bash cda-validator/tests/run-container-tests.sh
python3 xds-service/scripts/install-sonar.py
python3 xds-service/scripts/sonar-java.py --project cda-validator --extension xds-service/target/sonar-analyzer
```

Maven runs JUnit 5 unit tests, Spotless and compiler warning checks. CI additionally
requires zero-finding Sonar analysis and actual-image integration tests. CDA has
no PMD/CPD or JaCoCo gate; see the [quality comparison](../README.md#development-and-quality-gates).

The container runner builds an isolated service without replacing local ITB.
Set `CDA_RUNTIME_IMAGE` to test a complete prebuilt image, or `CDA_VALIDATOR_IMAGE`
to override the upstream base for a source build. Do not combine them.
For an already running validator (`BASE_URL` defaults to `http://localhost:8091`):

```bash
mvn -f cda-validator/tests/pom.xml clean test-compile failsafe:integration-test failsafe:verify
```

Reports are in `target/surefire-reports/`, `target/failsafe-reports/` and root
`test-results/`. The opt-in public catalogue test is
`bash cda-validator/tests/run-container-tests.sh spgdef-qfdd`; normal tests use
local samples. After a complete container run, `python3 scripts/example_report.py`
refreshes the [example report](../docs/example-validation-report.md).

Deploy local changes with `docker compose up -d --build --no-deps cda-validator`.
Compose holds the upstream image pin. Successful source CI publishes the complete
[CDA container](../README.md#published-container-images).

## Preview

The separate [ITB UI project](../itb-ui/README.md) adds View CDA to ITB reports
and calls this service’s rendering endpoint.

`POST /cda-dk/preview` accepts raw CDA XML up to 10 MiB and returns sanitised HTML.
It checks well-formed XML and the CDA root/namespace; DOCTYPEs and external XML/XSLT
resources are blocked. Output uses no-store responses and a sandboxed iframe.
Preview preserves the original bytes and can display documents that fail validation.
It shows header and narrative; structured questionnaire fields may not appear.
`CdaPreviewIT` exercises the renderer in the actual image.
