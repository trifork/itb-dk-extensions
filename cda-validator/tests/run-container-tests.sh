#!/usr/bin/env bash
# Run the same Docker integration checks locally and in GitHub Actions.
set -euo pipefail

CDA_IT_SUITE=${1:-samples}
case "$CDA_IT_SUITE" in
    samples) CDA_IT_TESTS='Cda*IT' ;;
    spgdef-qfdd) CDA_IT_TESTS=SpgdefQfddIT ;;
    *) printf 'Unknown suite: %s (expected samples or spgdef-qfdd)\n' "$CDA_IT_SUITE" >&2; exit 2 ;;
esac

CDA_REPOSITORY_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
cd -- "$CDA_REPOSITORY_ROOT"
if [[ -n "${CDA_RUNTIME_IMAGE:-}" && -n "${CDA_VALIDATOR_IMAGE:-}" ]]; then
    printf '%s\n' 'Choose CDA_RUNTIME_IMAGE (prebuilt service) or CDA_VALIDATOR_IMAGE (base for a source build), not both.' >&2
    exit 2
fi
CDA_VALIDATOR_MEMORY=${CDA_VALIDATOR_MEMORY:-4g}
# XSLT compilation needs more heap than the JVM may choose on a small CI runner.
# Leave 1 GiB of the container limit for metaspace, code cache and other native memory.
CDA_VALIDATOR_JAVA_OPTIONS=${CDA_VALIDATOR_JAVA_OPTIONS:--Xms256m -Xmx3g}
CDA_DEFAULT_RESULTS="$CDA_REPOSITORY_ROOT/test-results"
if [[ "$CDA_IT_SUITE" == spgdef-qfdd ]]; then
    CDA_DEFAULT_RESULTS="$CDA_DEFAULT_RESULTS/spgdef-qfdd"
fi
CDA_TEST_RESULTS_DIR=${CDA_TEST_RESULTS_DIR:-"$CDA_DEFAULT_RESULTS"}
mkdir -p -- "$CDA_TEST_RESULTS_DIR"
export CDA_TEST_RESULTS_DIR=$(cd -- "$CDA_TEST_RESULTS_DIR" && pwd)
# A failed startup must not leave an earlier integration run looking current.
python3 - "$CDA_IT_SUITE" <<'CDA_CLEAR_REPORTS'
import os
import sys
from pathlib import Path
folder = Path('cda-validator/target/failsafe-reports')
for pattern in ('TEST-*.xml', '*.txt', 'failsafe-summary.xml'):
    for report in folder.glob(pattern):
        report.unlink()
if sys.argv[1] == 'spgdef-qfdd':
    output = Path(os.environ['CDA_TEST_RESULTS_DIR'])
    for name in ('summary.md', 'results.json', 'catalogue.html'):
        (output / name).unlink(missing_ok=True)
    for directory in ('documents', 'reports'):
        for report in (output / directory).glob('*.xml'):
            report.unlink()
CDA_CLEAR_REPORTS
CDA_STAGING_DIR=$(mktemp -d "${TMPDIR:-/tmp}/cda-docker-test.XXXXXX")
CDA_CONTAINER_ID=

cleanup() {
    local status=$?
    if [[ -n "$CDA_CONTAINER_ID" ]]; then
        docker logs --timestamps "$CDA_CONTAINER_ID" > "$CDA_TEST_RESULTS_DIR/container.log" 2>&1 || true
        docker inspect --format '{{json .State}}' "$CDA_CONTAINER_ID" > "$CDA_TEST_RESULTS_DIR/container-state.json" || true
        if [[ "$status" -ne 0 ]]; then
            printf '%s\n' 'Validator container state and final log messages:' >&2
            cat "$CDA_TEST_RESULTS_DIR/container-state.json" >&2
            tail -40 "$CDA_TEST_RESULTS_DIR/container.log" >&2
        fi
        docker rm --force "$CDA_CONTAINER_ID" >/dev/null || true
    fi
    rm -rf -- "$CDA_STAGING_DIR"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ -n "${CDA_RUNTIME_IMAGE:-}" ]]; then
    printf 'Runtime reference: %s\n' "$CDA_RUNTIME_IMAGE" | tee "$CDA_TEST_RESULTS_DIR/image.txt"
    # Full local image IDs support offline verification; registry references are refreshed.
    if [[ "$CDA_RUNTIME_IMAGE" != sha256:* ]]; then
        docker pull "$CDA_RUNTIME_IMAGE"
    fi
    CDA_TEST_IMAGE=$(docker image inspect --format '{{.Id}}' "$CDA_RUNTIME_IMAGE")
else
    # Source CI must exercise this checkout, including unpublished rule/plugin changes.
    CDA_VALIDATOR_IMAGE=${CDA_VALIDATOR_IMAGE:-$(python3 scripts/validator_image.py --print-image)}
    docker build --target runtime --build-arg "CDA_VALIDATOR_IMAGE=$CDA_VALIDATOR_IMAGE" \
        --iidfile "$CDA_STAGING_DIR/image-id" "$CDA_REPOSITORY_ROOT/cda-validator"
    CDA_TEST_IMAGE=$(cat "$CDA_STAGING_DIR/image-id")
    printf 'Base reference: %s\n' "$CDA_VALIDATOR_IMAGE" | tee "$CDA_TEST_RESULTS_DIR/image.txt"
fi
docker image inspect "$CDA_TEST_IMAGE" \
    --format 'Image: {{.Id}} OS/architecture: {{.Os}}/{{.Architecture}} Digests: {{json .RepoDigests}}' \
    | tee -a "$CDA_TEST_RESULTS_DIR/image.txt"
CDA_CONTAINER_ID=$(docker run --detach \
    --memory "$CDA_VALIDATOR_MEMORY" --memory-swap "$CDA_VALIDATOR_MEMORY" \
    --publish 127.0.0.1::8080 \
    --env "JDK_JAVA_OPTIONS=$CDA_VALIDATOR_JAVA_OPTIONS" \
    "$CDA_TEST_IMAGE")
# Fingerprint the actual deployed resources, including the image-built plugin.
docker cp "$CDA_CONTAINER_ID:/validator/resources/cda-dk" "$CDA_STAGING_DIR/cda-dk"
export VALIDATOR_RESOURCE_SHA256=$(python3 scripts/example_report.py --fingerprint "$CDA_STAGING_DIR/cda-dk")
printf 'Container memory limit: %s\nJDK_JAVA_OPTIONS: %s\n' \
    "$CDA_VALIDATOR_MEMORY" "$CDA_VALIDATOR_JAVA_OPTIONS" | tee "$CDA_TEST_RESULTS_DIR/runtime.txt"
CDA_PORT=$(docker inspect --format '{{(index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort}}' "$CDA_CONTAINER_ID")
export BASE_URL="http://127.0.0.1:$CDA_PORT"
printf 'Waiting for CDA validator at %s\n' "$BASE_URL"
CDA_READY=false
for ((attempt = 0; attempt < 60; attempt++)); do
    if curl --fail --silent --show-error --max-time 5 \
        --header 'Accept: application/json' "$BASE_URL/rest/cda-dk/api/info" \
        > "$CDA_TEST_RESULTS_DIR/validator-info.json" 2> "$CDA_TEST_RESULTS_DIR/readiness.log"; then
        CDA_READY=true
        break
    fi
    if [[ $(docker inspect --format '{{.State.Running}}' "$CDA_CONTAINER_ID") != true ]]; then
        printf '%s\n' 'Validator container exited before it became ready.' >&2
        exit 1
    fi
    sleep 2
done
if [[ "$CDA_READY" != true ]]; then
    printf '%s\n' 'Validator did not become ready. See container.log and readiness.log.' >&2
    exit 1
fi

export EXAMPLE_RESULTS_DIR="$CDA_TEST_RESULTS_DIR/example-results"
# Only results from this execution may contribute to the report.
python3 - <<'CDA_CLEAR_RESULTS'
import os
from pathlib import Path
folder = Path(os.environ['EXAMPLE_RESULTS_DIR'])
folder.mkdir(parents=True, exist_ok=True)
for file in folder.glob('*.json'):
    file.unlink()
CDA_CLEAR_RESULTS
export VALIDATION_REPORT_DIR="$CDA_TEST_RESULTS_DIR/reports"
CDA_TEST_STATUS=0
mvn --batch-mode --no-transfer-progress -f cda-validator/tests/pom.xml \
    "-Dit.test=$CDA_IT_TESTS" clean test-compile failsafe:integration-test failsafe:verify 2>&1 \
    | tee "$CDA_TEST_RESULTS_DIR/integration-tests.log" || CDA_TEST_STATUS=1
if [[ "$CDA_IT_SUITE" == samples ]]; then
    python3 scripts/example_report.py --results "$EXAMPLE_RESULTS_DIR" --output "$CDA_TEST_RESULTS_DIR/example-validation-report.md" || CDA_TEST_STATUS=1
fi
exit "$CDA_TEST_STATUS"
