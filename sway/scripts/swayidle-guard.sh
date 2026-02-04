#!/bin/bash

# Conditionally entering idle mode

PROFILE_FILE="/tmp/kanshi-profile"


# Rule 1: docked profile → do not execute / do not idle
if [[ -f "$PROFILE_FILE" ]] && [[ "$(cat "$PROFILE_FILE")" == "docked" ]]; then
    exit 0
fi

# Rule 2: battery charging → do not execute / do not idle
if [[ -f /sys/class/power_supply/BAT0/status ]] && \
   [[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ]]; then
    exit 0
fi

# No restriction conditions, execute the command / idle
exec "$@"
