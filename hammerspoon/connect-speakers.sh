#!/bin/bash
# Connects a paired Bluetooth device by name. Meant to run inside a terminal
# (Ghostty) because only the terminal has Bluetooth permission; Hammerspoon does not.
name="${1:-OS-10}"
log=/tmp/connect-speakers.log
exec > >(tee "$log") 2>&1
date
blueutil="$(command -v blueutil || echo /opt/homebrew/bin/blueutil)"
address=$("$blueutil" --paired --format json | jq -r --arg n "$name" '.[] | select(.name == $n) | .address')
if [ -z "$address" ]; then
  echo "$name is not paired"; sleep 3; exit 1
fi
"$blueutil" --connect "$address"
