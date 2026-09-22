# Maven dependency review — 17 September 2026

This is a review of both POMs, their effective dependency versions, and build
plugins (including XDS's `lint` profile). Versions below were checked against
Maven Central or the configured NSP repository metadata. The inventory includes
the implemented Java/test migration, which uses JDK 25 in both projects, JUnit Jupiter 5.14.4 without Vintage,
and test-only `ph-schematron-isosch` 10.0.2 plus Saxon-HE 13.0 in CDA, whose compiler and
Surefire/Failsafe plugins are now 3.16.0 and 3.5.6. Other candidates remain
recommendations. This review does not replace a full transitive vulnerability scan.
Pre-releases were excluded.

## Recommended order

1. Update XDS Commons Lang from 3.17.0 to 3.20.0. Apache reports
   [CVE-2025-48924](https://raw.githubusercontent.com/CVEProject/cvelistV5/main/cves/2025/48xxx/CVE-2025-48924.json)
   in versions before 3.18.0: long inputs to `ClassUtils.getClass` can exhaust the
   stack. This review has not established whether that method is reachable with
   untrusted inputs here. Boot 3.5.16 still manages 3.17.0, so its patch upgrade
   alone does not address this dependency.
2. Move XDS Spring Boot 3.5.14 to 3.5.16. This matches the Boot line in
   [IPF 5.3's compatibility table](https://oehf.github.io/ipf-docs/docs/migration-5.3/).
   Keep IPF 5.3.0 and CXF 4.1.8 together; Boot 4 and CXF 4.2 need a separate
   compatibility migration. IPF's planned 6.0 line targets Boot 4.
3. Align both projects' build tools: Spotless 3.10.2, compiler 3.16.0 and
   Surefire/Failsafe 3.5.6 are candidates. Also consider CDA Shade 3.6.2,
   XDS JaCoCo 0.8.15 and dependency-plugin 3.11.0. Surefire/Failsafe 3.6.0
   is available, but 3.5.6 keeps the current minor line.
4. Evaluate CDA Guava 33.7.1-jre, test-only Jackson 2.22.2, XDS JAXB runtime
   4.0.9, and GITB 1.25.2 in both projects. GITB 1.29.5 is newer; verify the
   deployed ITB SOAP contract before adopting it.

For XDS changes, run Java 25 `mvn -f xds-service/pom.xml -Plint clean verify`,
the self-contained Sonar analysis and synthetic ITB interactions. For CDA changes,
run Java 25 Maven verification and the isolated Docker integration runner.
Keep existing negative-sample expectations and finding locations unchanged unless
there is a justified validation behavior change.

## Updates that need migration work

- CDA's Gazelle classes use `javax.xml.bind`. Replacing JAXB 2.3.9 with 4.0.9
  changes the API family to `jakarta.xml.bind`; it is not a compatible version bump.
  XDS already uses Jakarta and can evaluate the 4.0.9 patch separately.
- CDA Saxon was upgraded from 9.9.1-8 to 13.0, with conformance and actual
  container integration checks required for Gazelle compatibility. It remains
  separate from the upstream validator's own Schematron engine.
- CDA SLF4J API/simple 1.7.36 should be reviewed together before moving to 2.0.19;
  account for Gazelle's logging dependencies and the isolated plugin classloader.
- The old `com.helger:ph-schematron:5.6.5` dependency has been replaced by
  `com.helger.schematron:ph-schematron-isosch:10.0.2`, with the compiler resource
  path updated. Only its stylesheets are used; transitive Java engine dependencies
  are excluded to preserve the plugin's classpath. See the
  [migration guide](https://github.com/phax/ph-schematron/wiki/Migrations).
- NSP HL7 builders was removed with ITI-41 submission; it is no longer an XDS dependency.
- KvalitetsIT's Spring helper libraries 2.x → 3.x need API and Spring compatibility checks. The external Maven group
  IDs do not change merely because this repository's own packages moved to Trifork.
- Keep logstash-logback-encoder 8.1 with the current Jackson 2 stack:
  [version 9 requires Jackson 3](https://github.com/logfellow/logstash-logback-encoder/releases).
- Both projects now use JUnit Jupiter 5.14.4; XDS overrides Boot's JUnit BOM
  version to keep the platform and Jupiter artifacts aligned. Vintage was removed.
  JUnit 6 remains a separate migration.
- The Git commit plugin has moved from `pl.project13.maven:git-commit-id-plugin`
  4.9.10 to `io.github.git-commit-id:git-commit-id-maven-plugin` (10.0.1 available).
  Review configuration and generated `git.properties` when migrating. See the
  [upstream project](https://github.com/git-commit-id/git-commit-id-maven-plugin).

## Gazelle repository availability

Rechecked 19 September 2026.

The [IHE Nexus Maven repository](https://nexus.ihe-catalyst.net/repository/maven-public/)
is accessible again from the development machine without credentials. All 12
artifact metadata requests and all 31 pinned artifact downloads returned HTTP 200.
The 12 JARs and 19 POMs matched the previously vendored copies byte-for-byte
and by SHA-256 before those copies were removed from the repository.
The earlier 17 September check received HTTP 403 with an IP-allowlist requirement;
the restored access was verified locally, not from GitHub Actions.

The updated project POM passed Java 25 `mvn clean verify` with an empty temporary
Maven cache and empty user settings: 1,135 tests passed, with formatting checks
successful. All 31 Gazelle graph artifacts resolved from Nexus and matched the
removed snapshot's SHA-256 values. The self-contained Sonar Java scan checked
24 files with 599 rules and reported zero findings or failed files. The source-built
Docker image passed all 265 HTTP integration tests; all 111 catalogued sample
cases executed, with none missing. Reports remain under `test-results/` and
`cda-validator/target/`.

Both direct dependencies already use their latest published releases:
`net.ihe.gazelle.cdabasic.validator:cdabasicapp-validator-jar:1.0.0` and
`net.ihe.gazelle:ccdav21-validator-jar:0.0.2` (metadata linked in the inventory below).
The transitive graph has newer releases at these coordinates:

| Transitive artifact | Current JAR | Latest release |
| --- | --- | --- |
| `net.ihe.gazelle:cdabasic-validator-jar` | 0.3 | [1.1.3](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/cdabasic-validator-jar/maven-metadata.xml) |
| `net.ihe.gazelle.cda:cda-code-jar` | 1.7 | [1.10](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/cda/cda-code-jar/maven-metadata.xml) |
| `net.ihe.gazelle.common.code:common-code-jar` | 1.8 | [2.0.3](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/common/code/common-code-jar/maven-metadata.xml) |
| `net.ihe.gazelle.common.code:common-operations-jar` | 0.9 | [1.1.0](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/common/code/common-operations-jar/maven-metadata.xml) |
| `net.ihe.gazelle.datatypes:datatypes-code-jar` | 1.9 | [1.10](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/datatypes/datatypes-code-jar/maven-metadata.xml) |
| `net.ihe.gazelle:ihe-xmltools-jar` | 0.2 | [1.0.4](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/ihe-xmltools-jar/maven-metadata.xml) |
| `net.ihe.gazelle.voc:voc-code-jar` | 1.0 | [1.1](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/voc/voc-code-jar/maven-metadata.xml) |

`infr-code-jar:1.0`, `nblock-code-jar:1.1` and `tudresden-ocl-types:3.0.0`
also match their latest published releases. Maven also resolves POM-only versions
while mediating the graph; they are not additional runtime JARs.

These transitive releases are candidates for a coordinated compatibility review,
not automatic overrides of the two direct validators' dependency graphs. In
particular, the [CDA basic 1.1.3 POM](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/cdabasic-validator-jar/1.1.3/cdabasic-validator-jar-1.1.3.pom)
requires newer CDA, datatype, vocabulary and common model libraries and adds
UCUM dependencies. `cdabasic-validator-jar` is distinct from the direct
`cdabasicapp-validator-jar`. No dependency versions or validation behavior were
changed by this recheck; adopting candidates requires Java 25 verification,
Sonar analysis and actual container integration tests.

The project now resolves these pinned dependencies directly from HTTPS IHE Nexus;
the checked-in Maven artifacts and their Docker/CI inventory checks were removed.
Maven Central is listed first for standard libraries. The Nexus entry uses
`irisa-sumo`, matching the upstream POM repository ID to replace its legacy HTTP
URL. Release checksum verification remains mandatory, snapshots are disabled,
and CI still uses a fresh Maven cache. Clean builds therefore require access to
Nexus and Central. Upstream POMs and JARs retain their original licence declarations
and notices; they are not relicensed as this repository's code.

## Version inventory

The linked metadata is the source for each available version. “Latest” refers to
the same Maven coordinates; relocation exceptions are discussed above. Inherited
default plugins are included for visibility, not a recommendation to override every
parent-managed version. Failsafe in CDA's `container-it` profile is 3.5.6, with
3.6.0 available as a later minor release.

### CDA validator

| Kind | Artifact | Resolved | Available at same coordinates |
| --- | --- | --- | --- |
| dependency | `com.fasterxml.jackson.core:jackson-databind` | 2.19.4 | [2.22.2](https://repo.maven.apache.org/maven2/com/fasterxml/jackson/core/jackson-databind/maven-metadata.xml) |
| dependency | `com.helger.schematron:ph-schematron-isosch` | 10.0.2 | [10.0.2](https://repo.maven.apache.org/maven2/com/helger/schematron/ph-schematron-isosch/maven-metadata.xml) |
| dependency | `org.junit.jupiter:junit-jupiter` | 5.14.4 | [5.14.4 (JUnit 5 line)](https://repo.maven.apache.org/maven2/org/junit/jupiter/junit-jupiter/maven-metadata.xml) |
| dependency | `eu.europa.ec.itb:gitb-types` | 1.25.1 | [1.29.5](https://repo.maven.apache.org/maven2/eu/europa/ec/itb/gitb-types/maven-metadata.xml) |
| dependency | `net.ihe.gazelle.cdabasic.validator:cdabasicapp-validator-jar` | 1.0.0 | [1.0.0](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/cdabasic/validator/cdabasicapp-validator-jar/maven-metadata.xml) |
| dependency | `net.ihe.gazelle:ccdav21-validator-jar` | 0.0.2 | [0.0.2](https://nexus.ihe-catalyst.net/repository/maven-public/net/ihe/gazelle/ccdav21-validator-jar/maven-metadata.xml) |
| dependency | `net.sf.saxon:Saxon-HE` | 13.0 | [13.0](https://repo.maven.apache.org/maven2/net/sf/saxon/Saxon-HE/maven-metadata.xml) |
| dependency | `com.google.guava:guava` | 33.4.8-jre | [33.7.1-jre](https://repo.maven.apache.org/maven2/com/google/guava/guava/maven-metadata.xml) |
| dependency | `xerces:xercesImpl` | 2.12.2 | [2.12.2](https://repo.maven.apache.org/maven2/xerces/xercesImpl/maven-metadata.xml) |
| dependency | `javax.xml.bind:jaxb-api` | 2.3.1 | [2.3.1](https://repo.maven.apache.org/maven2/javax/xml/bind/jaxb-api/maven-metadata.xml) |
| dependency | `com.sun.xml.bind:jaxb-impl` | 2.3.9 | [4.0.9](https://repo.maven.apache.org/maven2/com/sun/xml/bind/jaxb-impl/maven-metadata.xml) |
| dependency | `org.slf4j:slf4j-api` | 1.7.36 | [2.0.19](https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/maven-metadata.xml) |
| dependency | `org.slf4j:slf4j-simple` | 1.7.36 | [2.0.19](https://repo.maven.apache.org/maven2/org/slf4j/slf4j-simple/maven-metadata.xml) |
| plugin | `com.diffplug.spotless:spotless-maven-plugin` | 3.10.1 | [3.10.2](https://repo.maven.apache.org/maven2/com/diffplug/spotless/spotless-maven-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-compiler-plugin` | 3.16.0 | [3.16.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-compiler-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-surefire-plugin` | 3.5.6 | [3.6.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-surefire-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-shade-plugin` | 3.6.0 | [3.6.2](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-shade-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-clean-plugin` | 3.2.0 | [3.5.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-clean-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-resources-plugin` | 3.4.0 | [3.5.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-jar-plugin` | 3.5.0 | [3.5.1](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-jar-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-install-plugin` | 3.1.4 | [3.2.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-install-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-deploy-plugin` | 3.1.4 | [3.2.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-deploy-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-site-plugin` | 3.12.1 | [3.22.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-site-plugin/maven-metadata.xml) |

### XDS service

| Kind | Artifact | Resolved | Available at same coordinates |
| --- | --- | --- | --- |
| dependency | `eu.europa.ec.itb:gitb-types-jakarta` | 1.25.1 | [1.29.5](https://repo.maven.apache.org/maven2/eu/europa/ec/itb/gitb-types-jakarta/maven-metadata.xml) |
| dependency | `org.apache.cxf:cxf-rt-transports-http` | 4.1.8 | [4.2.3](https://repo.maven.apache.org/maven2/org/apache/cxf/cxf-rt-transports-http/maven-metadata.xml) |
| dependency | `org.apache.cxf:cxf-rt-transports-http-jetty` | 4.1.8 | [4.2.3](https://repo.maven.apache.org/maven2/org/apache/cxf/cxf-rt-transports-http-jetty/maven-metadata.xml) |
| dependency | `org.springframework.boot:spring-boot-starter-web` | 3.5.14 | [4.1.1](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-web/maven-metadata.xml) |
| dependency | `org.springframework.boot:spring-boot-starter-validation` | 3.5.14 | [4.1.1](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-validation/maven-metadata.xml) |
| dependency | `org.apache.commons:commons-lang3` | 3.17.0 | [3.20.0](https://repo.maven.apache.org/maven2/org/apache/commons/commons-lang3/maven-metadata.xml) |
| dependency | `dk.kvalitetsit:spring-prometheus-app-info` | 2.0.3 | [3.0.1](https://repo.maven.apache.org/maven2/dk/kvalitetsit/spring-prometheus-app-info/maven-metadata.xml) |
| dependency | `dk.kvalitetsit:spring-request-id-logger` | 2.0.1 | [3.0.0](https://repo.maven.apache.org/maven2/dk/kvalitetsit/spring-request-id-logger/maven-metadata.xml) |
| dependency | `org.apache.cxf:cxf-rt-frontend-jaxws` | 4.1.8 | [4.2.3](https://repo.maven.apache.org/maven2/org/apache/cxf/cxf-rt-frontend-jaxws/maven-metadata.xml) |
| dependency | `org.apache.cxf:cxf-rt-features-logging` | 4.1.8 | [4.2.3](https://repo.maven.apache.org/maven2/org/apache/cxf/cxf-rt-features-logging/maven-metadata.xml) |
| dependency | `dk.sosi.seal:seal` | 3.0.0 | [3.0.0](https://nexus.nspop.dk/nexus/content/groups/public/dk/sosi/seal/seal/maven-metadata.xml) |
| dependency | `org.openehealth.ipf.commons:ipf-commons-ihe-xds` | 5.3.0 | [5.3.0](https://repo.maven.apache.org/maven2/org/openehealth/ipf/commons/ipf-commons-ihe-xds/maven-metadata.xml) |
| dependency | `org.glassfish.jaxb:jaxb-runtime` | 4.0.6 | [4.0.9](https://repo.maven.apache.org/maven2/org/glassfish/jaxb/jaxb-runtime/maven-metadata.xml) |
| dependency | `org.openapitools:jackson-databind-nullable` | 0.2.11 | [0.2.11](https://repo.maven.apache.org/maven2/org/openapitools/jackson-databind-nullable/maven-metadata.xml) |
| dependency | `io.swagger.core.v3:swagger-annotations` | 2.2.55 | [2.2.55](https://repo.maven.apache.org/maven2/io/swagger/core/v3/swagger-annotations/maven-metadata.xml) |
| dependency | `net.logstash.logback:logstash-logback-encoder` | 8.1 | [9.0](https://repo.maven.apache.org/maven2/net/logstash/logback/logstash-logback-encoder/maven-metadata.xml) |
| BOM | `org.junit:junit-bom` (Jupiter; Vintage removed) | 5.14.4 | [5.14.4 (JUnit 5 line)](https://repo.maven.apache.org/maven2/org/junit/junit-bom/maven-metadata.xml) |
| dependency | `org.springframework.boot:spring-boot-starter-test` | 3.5.14 | [4.1.1](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-test/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-compiler-plugin` | 3.14.1 | [3.16.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-compiler-plugin/maven-metadata.xml) |
| plugin | `pl.project13.maven:git-commit-id-plugin` | 4.9.10 | [4.9.10](https://repo.maven.apache.org/maven2/pl/project13/maven/git-commit-id-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-surefire-plugin` | 3.5.4 | [3.6.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-surefire-plugin/maven-metadata.xml) |
| plugin | `org.jacoco:jacoco-maven-plugin` | 0.8.14 | [0.8.15](https://repo.maven.apache.org/maven2/org/jacoco/jacoco-maven-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-dependency-plugin` | 3.8.1 | [3.11.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-dependency-plugin/maven-metadata.xml) |
| plugin | `com.diffplug.spotless:spotless-maven-plugin` | 3.10.1 | [3.10.2](https://repo.maven.apache.org/maven2/com/diffplug/spotless/spotless-maven-plugin/maven-metadata.xml) |
| plugin | `org.openapitools:openapi-generator-maven-plugin` | 7.25.0 | [7.25.0](https://repo.maven.apache.org/maven2/org/openapitools/openapi-generator-maven-plugin/maven-metadata.xml) |
| plugin | `org.springframework.boot:spring-boot-maven-plugin` | 3.5.14 | [4.1.1](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-maven-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-failsafe-plugin` | 3.5.4 | [3.6.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-failsafe-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-pmd-plugin` | 3.28.0 | [3.28.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-pmd-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-clean-plugin` | 3.4.1 | [3.5.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-clean-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-resources-plugin` | 3.3.1 | [3.5.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-jar-plugin` | 3.4.2 | [3.5.1](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-jar-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-install-plugin` | 3.1.4 | [3.2.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-install-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-deploy-plugin` | 3.1.4 | [3.2.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-deploy-plugin/maven-metadata.xml) |
| plugin | `org.apache.maven.plugins:maven-site-plugin` | 3.12.1 | [3.22.0](https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-site-plugin/maven-metadata.xml) |
| parent | `org.springframework.boot:spring-boot-starter-parent` | 3.5.14 | [4.1.1](https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-starter-parent/maven-metadata.xml) |
| BOM | `org.openehealth.ipf:ipf-dependencies` | 5.3.0 | [5.3.0](https://repo.maven.apache.org/maven2/org/openehealth/ipf/ipf-dependencies/maven-metadata.xml) |
