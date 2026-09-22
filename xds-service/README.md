# ITB XDS service

Independent Java 25 Spring Boot application providing ITI-18 search, ITI-43
retrieval and STS authentication. REST and GITB SOAP adapters share Java services.
Compose runs it as `xds-api` under profile `xds`, with network alias `xds-connector`.
See [setup and configuration](../docs/xds.md) and [contracts](../docs/xds-service.md).

## Configuration and interfaces

`application.properties` contains runtime defaults, including named TEST1/TEST2
registries with separate search, retrieval and STS endpoints. Keep signing material
and overrides in ignored `local/`; both locations are mounted read-only and excluded
from the image build context.

ITB offers a registry selector when multiple registries exist. Retrieval stays bound
to the selected search registry; repository filters operate on saved results.
`GET /v1/registries` lists IDs/names, and REST operations accept `registryId`.

OpenAPI contracts live in `src/main/openapi/`. `credential-api.yaml` generates the
credential listing/registration and service-configuration interfaces; ITB's identity
selector calls the shared credential service directly.
GITB is at `/processing?wsdl`, QName
`{http://www.gitb.com/ps/v1/}ProcessingServiceService`.
`/health/ready` checks local readiness without contacting STS or DDS.

## Build and verify

Run from the repository root with Java 25 and Maven:

```bash
mvn --batch-mode --no-transfer-progress -f xds-service/pom.xml -Plint verify
python3 xds-service/scripts/install-sonar.py
python3 xds-service/scripts/sonar-java.py --extension xds-service/target/sonar-analyzer
docker compose --profile xds build xds-api
```

Quality gates: JUnit 5, Spotless, compiler warnings as errors, PMD/CPD (`lint`
profile), JaCoCo (80% lines / 60% branches), and zero-finding self-contained Sonar.
The [shared quality workflow](../.github/workflows/xds-quality.yml) gates integration
and publication. Reports are under `target/reports/`, `target/site/jacoco/` and
Surefire/Failsafe folders. The executable JAR is `target/xds-service-exec.jar`.

Normal verification uses local fixtures and does not contact ITB or live DDS.
Spring integration tests load classpath configuration with loopback endpoints.
The Docker `fixture` target adds synthetic XDS operations for the opt-in real ITB
flow test; the `runtime` target contains production code only.

After [fixture setup](../docs/xds.md#verification):

```bash
mvn -f xds-service/pom.xml -Pitb-it -Dit.test=ItbFlowIT verify
```

This test creates and cleans up its own sessions. Restore the real backend after
fixture testing; never reset user data. `tests/` contains Compose overrides,
bootstrap/readiness checks and report summaries. External service calls do not
contribute to test-JVM coverage.

CI can reuse a complete CDA image through the `CDA_RUNTIME_IMAGE` Actions variable
or `cda_runtime_image` workflow input; otherwise it builds CDA from source.
XDS is always built from the checkout under test. See [published images](../README.md#published-container-images).

The REST code originates from `trifork/ihe-xds-api`; its [MIT licence](LICENSE)
is retained. No separate API repository or deployment is required.
