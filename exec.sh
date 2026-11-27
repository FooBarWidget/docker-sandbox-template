#!/bin/sh
set -e
if tty -s; then
	TTY=(-ti)
else
	TTY=()
fi
# Source bashrc so that PATH customizations work
exec sbx env exec "${TTY[@]}" -- bash -c 'source /etc/bash.bashrc; source ~/.bashrc; exec "$@"' -- "$@"
