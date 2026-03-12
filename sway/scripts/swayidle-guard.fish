#!/usr/bin/env fish

# Conditionally entering idle mode

set PROFILE_FILE /tmp/kanshi-profile

# Rule 1: docked profile → do not execute / do not idle
if test -f $PROFILE_FILE; and test (cat $PROFILE_FILE) = docked
    exit 0
end

# Rule 2: battery charging → do not execute / do not idle
if test -f /sys/class/power_supply/BAT0/status; and test (cat /sys/class/power_supply/BAT0/status) != Discharging
    exit 0
end

# No restriction conditions, execute the command / idle
exec $argv
