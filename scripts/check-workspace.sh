#!/bin/sh
set -e

RED=$'\e[0;31m'
RESET=$'\e[0m'

SELFDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
WORKSPACE_NAME=$(grep '^workspace: ' "$SELFDIR/../sbxenv.yaml" | sed 's/^workspace: //')

if ! test -e "$WORKSPACE_NAME"; then
    echo "${RED}ERROR: you must create symlink '$WORKSPACE_NAME'. See instructions in README.md${RESET}" >&2
    exit 1
fi
