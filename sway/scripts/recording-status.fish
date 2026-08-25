#!/usr/bin/env fish
# recording-status.fish
# Waybar custom module: print a JSON REC indicator while wf-recorder is running.

if pgrep -x wf-recorder >/dev/null
    echo '{"text": "● REC", "class": "recording", "tooltip": "Screen recording in progress (Super+Print or click to stop)"}'
else
    echo '{"text": ""}'
end
