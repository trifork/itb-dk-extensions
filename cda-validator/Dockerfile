# syntax=docker/dockerfile:1
# The pinned upstream image is supplied by Compose (or explicitly for CI candidates).
ARG CDA_VALIDATOR_IMAGE
FROM --platform=$BUILDPLATFORM maven:3.9.11-eclipse-temurin-25 AS build
WORKDIR /build/cda-validator
COPY pom.xml ./
COPY src ./src
COPY domain ./domain
RUN --mount=type=cache,id=cda-validator-maven,target=/root/.m2,sharing=locked mvn --batch-mode --no-transfer-progress clean verify

FROM ${CDA_VALIDATOR_IMAGE} AS runtime
COPY domain/cda-dk /validator/resources/cda-dk
COPY --from=build /build/cda-validator/target/validator-plugin-cda-dk.jar /validator/resources/cda-dk/plugins/validator-plugin-cda-dk.jar
COPY --from=build /build/cda-validator/target/validator-plugin-cda-dk-preview.jar /validator/extensions/cda-preview.jar
ENV validator.resourceRoot=/validator/resources
# Load only the thin preview extension alongside the upstream application. The
# shaded Gazelle plugin remains isolated in the domain's plugin class loader.
ENTRYPOINT ["java", "-XX:+ExitOnOutOfMemoryError", "-Djava.security.egd=file:/dev/./urandom", "-Dloader.path=/validator/extensions", "-cp", "/validator/validator.jar", "org.springframework.boot.loader.launch.PropertiesLauncher"]
