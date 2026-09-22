#!/usr/bin/env bash
set -euo pipefail

ITB_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ITB_REPOSITORY_ROOT=$(cd -- "$ITB_SCRIPT_DIR/.." && pwd)
ITB_ENV_FILE=${ITB_ENV_FILE:-"$ITB_SCRIPT_DIR/.itb.env"}
ITB_API_BASE=${ITB_API_BASE:-http://localhost:9000/api/rest}
ITB_VALIDATOR_READY_URL=${ITB_VALIDATOR_READY_URL:-http://localhost:8091/api/cda-dk/validation?wsdl}

for ITB_COMMAND in curl docker openssl python3; do
    if ! command -v "$ITB_COMMAND" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$ITB_COMMAND" >&2
        exit 1
    fi
done

if [[ -f "$ITB_ENV_FILE" ]]; then
    # Local bootstrap configuration, including the automation key.
    # shellcheck source=/dev/null
    source "$ITB_ENV_FILE"
fi

if [[ -z "${ITB_AUTOMATION_API_MASTER_KEY:-}" ]]; then
    ITB_AUTOMATION_API_MASTER_KEY=$(openssl rand -hex 32)
    umask 077
    printf 'ITB_AUTOMATION_API_MASTER_KEY=%q\n' "$ITB_AUTOMATION_API_MASTER_KEY" > "$ITB_ENV_FILE"
    chmod 600 "$ITB_ENV_FILE"
    printf 'Generated local ITB automation key in %s\n' "$ITB_ENV_FILE"
fi
export ITB_AUTOMATION_API_MASTER_KEY

ITB_ENABLE_XDS=${ITB_ENABLE_XDS:-false}
case "$ITB_ENABLE_XDS" in true|false) ;; *) printf 'ITB_ENABLE_XDS must be true or false.\n' >&2; exit 1 ;; esac
export ITB_ENABLE_XDS
ITB_BUILD_FROM_SOURCE=${ITB_BUILD_FROM_SOURCE:-false}
case "$ITB_BUILD_FROM_SOURCE" in true|false) ;; *) printf 'ITB_BUILD_FROM_SOURCE must be true or false.\n' >&2; exit 1 ;; esac
ITB_COMPOSE_OPTIONS=(-f "$ITB_REPOSITORY_ROOT/docker-compose.yml")
ITB_UP_OPTIONS=()
if [[ "$ITB_BUILD_FROM_SOURCE" == true ]]; then
    ITB_UP_OPTIONS+=(--build)
    printf 'Building the service images from this checkout.\n'
else
    ITB_COMPOSE_OPTIONS+=(-f "$ITB_SCRIPT_DIR/compose.published.yml")
    ITB_UP_OPTIONS+=(--no-build --pull always)
    printf 'Pulling published service images from Docker Hub. A failed pull stops startup.\n'
fi
if [[ "$ITB_ENABLE_XDS" == true ]]; then
    ITB_COMPOSE_OPTIONS+=(--profile xds)
    ITB_UP_OPTIONS+=(--wait --wait-timeout 180)
    printf 'Enabling DDS search using the combined XDS service. Live TEST1 requires configured signing identities in xds-service/local/application.properties.\n'
fi


docker compose \
    --project-directory "$ITB_REPOSITORY_ROOT" \
    --env-file "$ITB_ENV_FILE" \
    "${ITB_COMPOSE_OPTIONS[@]}" up -d "${ITB_UP_OPTIONS[@]}"

printf 'Waiting for the ITB REST API and CDA validator'
ITB_READY=false
for ITB_ATTEMPT in $(seq 1 90); do
    if curl --silent --fail --max-time 2 "$ITB_API_BASE/swagger" >/dev/null 2>&1 && \
       curl --silent --fail --max-time 2 "$ITB_VALIDATOR_READY_URL" >/dev/null 2>&1; then
        ITB_READY=true
        break
    fi
    printf '.'
    sleep 2
done
printf '\n'

if [[ "$ITB_READY" != true ]]; then
    printf 'Services did not become ready: %s/swagger and %s\n' "$ITB_API_BASE" "$ITB_VALIDATOR_READY_URL" >&2
    exit 1
fi

ITB_MASTER_API_KEY=$ITB_AUTOMATION_API_MASTER_KEY \
ITB_API_BASE=$ITB_API_BASE \
    "$ITB_SCRIPT_DIR/setup-itb.sh"

ITB_UI_API_BASE=${ITB_UI_API_BASE:-"${ITB_API_BASE%/rest}"} \
    "$ITB_SCRIPT_DIR/setup-test-user.sh"
