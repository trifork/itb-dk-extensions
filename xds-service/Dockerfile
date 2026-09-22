# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM maven:3.9.11-eclipse-temurin-25 AS build
WORKDIR /build
COPY pom.xml ./
COPY src ./src
COPY scripts/sonar ./scripts/sonar
RUN --mount=type=cache,target=/root/.m2,sharing=locked mvn --batch-mode --no-transfer-progress -Plint clean verify

# Test-only image runs the actual GITB adapter with synthetic in-process services.
FROM build AS fixture-build
RUN --mount=type=cache,target=/root/.m2,sharing=locked mvn --batch-mode --no-transfer-progress dependency:copy-dependencies -DincludeScope=test -DoutputDirectory=target/fixture-lib
FROM gcr.io/distroless/java25-debian13:nonroot AS fixture
WORKDIR /app
COPY LICENSE /app/LICENSE
COPY --from=fixture-build /build/target/classes /app/classes
COPY --from=fixture-build /build/target/test-classes /app/test-classes
COPY --from=fixture-build /build/target/fixture-lib /app/lib
COPY --from=fixture-build /build/target/classes/com/trifork/ihexdsapi/gitb/ReadinessProbe.class /app/probe/com/trifork/ihexdsapi/gitb/ReadinessProbe.class
USER nonroot:nonroot
ENTRYPOINT ["java", "-cp", "/app/classes:/app/test-classes:/app/lib/*", "com.trifork.ihexdsapi.gitb.FixtureApplication"]

FROM gcr.io/distroless/java25-debian13:nonroot AS runtime

LABEL org.opencontainers.image.source="https://github.com/trifork/itb-dk-extensions"
WORKDIR /app
COPY LICENSE /app/LICENSE
COPY --from=build --chown=nonroot:nonroot /build/target/xds-service-exec.jar /app/xds-service.jar
COPY --from=build --chown=nonroot:nonroot /build/target/classes/com/trifork/ihexdsapi/gitb/ReadinessProbe.class /app/probe/com/trifork/ihexdsapi/gitb/ReadinessProbe.class
ENV TZ=UTC CORRELATION_ID=x-request-id SERVICE_ID=itb-xds
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["java", "-jar", "/app/xds-service.jar"]
