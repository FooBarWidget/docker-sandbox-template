#!/usr/bin/env bash
# Fixes https://github.com/docker/sbx-releases/issues/918
set -euo pipefail

SELFDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SANDBOX_NAME=$(grep '^name: ' "$SELFDIR/../sbxenv.yaml" | sed 's/^name: //')

if SANDBOX_STATE=$(sbx inspect "$SANDBOX_NAME" --format yaml 2>/dev/null | grep '^state: ' | sed 's|^state: ||'); then
    if [[ "$SANDBOX_STATE" == running ]]; then
        echo "Syncing disk for sandbox $SANDBOX_NAME"
        sbx env exec sync
    else
        echo "Sandbox $SANDBOX_NAME is not running. Not syncing disk."
    fi
else
    echo "Sandbox $SANDBOX_NAME does not seem to exist. Not syncing disk."
fi
