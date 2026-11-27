#!/usr/bin/env bash
set -eo pipefail
SANDBOX_NAME=$(grep '^name: ' "sbxenv.yaml" | sed 's/^name: //')
set -x
exec sbx stop "$SANDBOX_NAME" "$@"
