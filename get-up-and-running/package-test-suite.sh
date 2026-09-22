#!/usr/bin/env bash
set -euo pipefail

ITB_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ITB_REPOSITORY_ROOT=$(cd -- "$ITB_SCRIPT_DIR/.." && pwd)
ITB_OUTPUT_FILE=${1:-"$ITB_SCRIPT_DIR/build/cda-dk-validator-example.zip"}
ITB_SUITE_KIND=${2:-upload}
case "$ITB_SUITE_KIND" in
    upload) ITB_SUITE_DIR="$ITB_SCRIPT_DIR/test-suite" ;;
    setup-check) ITB_SUITE_DIR="$ITB_SCRIPT_DIR/setup-check" ;;
    *) printf 'Unknown suite kind: %s\n' "$ITB_SUITE_KIND" >&2; exit 1 ;;
esac
ITB_BUILD_DIR=$(mktemp -d "${TMPDIR:-/tmp}/cda-dk-test-suite.XXXXXX")

cleanup() {
    rm -rf -- "$ITB_BUILD_DIR"
}
trap cleanup EXIT

mkdir -p -- "$ITB_BUILD_DIR/testCases" "$ITB_BUILD_DIR/resources"
cp -- "$ITB_SUITE_DIR/testSuite.xml" "$ITB_BUILD_DIR/testSuite.xml"
cp -- "$ITB_SUITE_DIR"/testCases/*.xml "$ITB_BUILD_DIR/testCases/"
if [[ "$ITB_SUITE_KIND" == setup-check ]]; then
    cp -- "$ITB_REPOSITORY_ROOT/samples/phmr/phmr_example01.xml" "$ITB_BUILD_DIR/resources/phmr_example01.xml"
fi

if [[ "$ITB_SUITE_KIND" == upload && "${ITB_ENABLE_XDS:-false}" == true ]]; then
    python3 "$ITB_SCRIPT_DIR/enable-xds.py" "$ITB_BUILD_DIR"
fi

mkdir -p -- "$(dirname -- "$ITB_OUTPUT_FILE")"
rm -f -- "$ITB_OUTPUT_FILE"
(
    cd -- "$ITB_BUILD_DIR"
    zip -q -r "$ITB_OUTPUT_FILE" testSuite.xml testCases resources
)

printf 'Created %s\n' "$ITB_OUTPUT_FILE"
