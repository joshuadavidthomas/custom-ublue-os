#!/usr/bin/env bash

set -eou pipefail

ONEPASSWORD_BIN=$(command -v 1password)

if [ -z "$ONEPASSWORD_BIN" ] || [ ! -x "$ONEPASSWORD_BIN" ]; then
    echo "1Password binary not found in PATH or not executable"
    exit 1
fi

while true; do
  if ! pgrep -x "1password" >/dev/null; then
    "$ONEPASSWORD_BIN" --silent --ozone-platform-hint=auto --enable-features=VaapiVideoDecodeLinuxGL,WebRTCPipeWireCapturer &
  fi
  sleep 60
done