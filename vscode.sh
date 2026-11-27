#!/bin/sh
set -euo pipefail

VSCODE_PORT=4200 # defined through docker-sandbox-vscode-mixin-kit
BOLD=$'\e[1m'
UNDERLINE=$'\e[4m'
YELLOW=$'\e[0;33m'
RESET=$'\e[0m'

SELFDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SANDBOX_NAME=$(grep '^name: ' "$SELFDIR/sbxenv.yaml" | sed 's/^name: //')

if ! OUTPUT=$(sbx port ls "$SANDBOX_NAME" --format yaml 2>&1); then
    if grep -q 'not found' <<<"$OUTPUT"; then
        echo "ERROR: sandbox $SANDBOX_NAME not found" >&2
    else
        echo "$OUTPUT" >&2
    fi
    exit 1
fi

# Start the sandbox if not running, otherwise we can't see published ports
sbx env exec true
# Keep the sandbox alive for long enough so we can query the ports
sbx env exec sleep 10 &

if ! HOST_PORT=$(sbx port ls "$SANDBOX_NAME" --format yaml | grep -B 1 "sandbox_port: ${VSCODE_PORT}$" | grep 'host_port:' | sed 's|.*host_port: ||'); then
    echo "ERROR: failed to get host port for sandbox port $VSCODE_PORT" >&2
    exit 1
fi

echo "${BOLD}${YELLOW}VSCode server will be accessible on the host at ${UNDERLINE}http://localhost:${HOST_PORT}${RESET}"
echo "${BOLD}${YELLOW}--------------------------------------------------------------------${RESET}"
exec ./exec.sh code server serve-web \
    --host 0.0.0.0 \
    --port "$VSCODE_PORT" \
    --without-connection-token \
    --accept-server-license-terms \
    --default-folder . \
    "$@"
