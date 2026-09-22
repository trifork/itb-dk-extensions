#!/usr/bin/env bash
# Run Java integration tests against an already running validator.
set -euo pipefail
ITB_REPOSITORY_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
CDA_IT_TESTS=CdaSamplesIT
if [[ "${1:-}" == --check-versions ]]; then
    CDA_IT_TESTS=CdaSamplesIT,CdaVersionsIT
    shift
fi
if [[ $# -ne 0 ]]; then
    printf '%s\n' 'Usage: ./run-samples.sh [--check-versions]' >&2
    exit 2
fi
exec mvn --batch-mode --no-transfer-progress -f "$ITB_REPOSITORY_ROOT/cda-validator/pom.xml" \
    -Pcontainer-it "-Dit.test=$CDA_IT_TESTS" test-compile failsafe:integration-test failsafe:verify
