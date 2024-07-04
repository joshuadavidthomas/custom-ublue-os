#!/usr/bin/env bash

set -eou pipefail

ONEPASSWORD_BIN=$(command -v 1password)
FLAG_FILE="/tmp/1password_running"

if [ -z "$ONEPASSWORD_BIN" ] || [ ! -x "$ONEPASSWORD_BIN" ]; then
    echo "1Password binary not found in PATH or not executable"
    exit 1
fi

cleanup() {
    rm -f "$FLAG_FILE"
}

trap cleanup EXIT

while true; do
    if pgrep -x "1password" > /dev/null; then
        # 1Password is running, ensure flag file exists
        touch "$FLAG_FILE"
    elif [ -f "$FLAG_FILE" ]; then
        # 1Password was running (flag file exists) but isn't now, so it likely crashed
        "$ONEPASSWORD_BIN" --silent --ozone-platform-hint=auto --enable-features=VaapiVideoDecodeLinuxGL,WebRTCPipeWireCapturer &
    else
        # 1Password isn't running and flag file doesn't exist, so it was likely quit manually
        rm -f "$FLAG_FILE"
    fi
    sleep 60
done