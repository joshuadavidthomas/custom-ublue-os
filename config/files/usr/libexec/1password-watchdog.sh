#!/usr/bin/env bash

set -eou pipefail

while true; do
  if ! pgrep -x "1password" >/dev/null; then
    /usr/bin/1password --silent --ozone-platform-hint=auto --enable-features=VaapiVideoDecodeLinuxGL,WebRTCPipeWireCapturer %U &
  fi
  sleep 60
done
