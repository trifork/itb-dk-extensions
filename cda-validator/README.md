# CDA validator

Independent Java 25 project packaging the `cda-dk` filesystem domain, Gazelle Java
plugin and browser preview on the pinned `isaitb/xml-validator` image. Validation
runs XSD, Schematron/XSLT and Gazelle checks. All releases have partial coverage;
see [conformance](../docs/cda-conformance.md) and the [release catalogue](domain/cda-dk/rulesets.json).
[Setup and web/REST/SOAP links](../README.md#get-up-and-running) are in the root README.

## Layout

- `domain/cda-dk/`: configuration, catalogue, schemas, rules and vocabularies.
- `src/main/java/com/trifork/itb/plugin/`: Gazelle integration and PHMR checks.
- `src/main/java/com/trifork/itb/preview/`: upload-page CDA preview extension.
- `src/main/resources/rendering/CDA.xsl`: shared display stylesheet.
- `src/test/`: Java tests and XML fixtures.
- `tests/`: isolated container runner, standalone HTTP test-client POM and reporting.

Docker builds `validator-plugin-cda-dk.jar` and installs it inside the domain.
Do not commit plugin binaries or bind-mount over the image's domain directory.
The thin `validator-plugin-cda-dk-preview.jar` is loaded separately using
PropertiesLauncher; its provided runtime dependencies must match the upstream image.

## Build and verify

Maven downloads pinned Gazelle dependencies from the
[IHE Nexus repository](https://nexus.ihe-catalyst.net/repository/maven-public/)
and standard libraries from Maven Central. An empty Maven cache requires access
to both repositories; no Maven artifacts are checked into this project.

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
