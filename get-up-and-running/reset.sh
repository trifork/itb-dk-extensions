#!/usr/bin/env bash
# Deliberately discard this project's local ITB installation and provision it again.
set -euo pipefail
ITB_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ITB_REPOSITORY_ROOT=$(cd -- "$ITB_SCRIPT_DIR/.." && pwd)

printf 'Resetting local ITB: containers, volumes, test history and generated credentials.\n'
docker compose --project-directory "$ITB_REPOSITORY_ROOT" down --volumes
rm -f -- "$ITB_SCRIPT_DIR/.itb-bootstrap.env" "$ITB_SCRIPT_DIR/.itb.env" "$ITB_SCRIPT_DIR/.itb-users.env"
exec "$ITB_SCRIPT_DIR/start.sh"
