#!/usr/bin/env fish
# record-region.fish
# Toggle a region screen recording: first run selects an area with slurp and
# starts wf-recorder; second run stops it and saves the video.

# A recording is already running: stop it. The instance that started it
# handles the "saved" notification and the Waybar indicator refresh.
if pgrep -x wf-recorder >/dev/null
    pkill -SIGINT -x wf-recorder
    exit 0
end

set -l geometry (slurp)
if test -z "$geometry"
    # Selection cancelled (Esc)
    exit 1
end

# Reuse the directory exported by fish's conf.d/recording.fish when available
set -q RECORD_DIR; or set -l RECORD_DIR $HOME/Videos
mkdir -p $RECORD_DIR
set -l filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4

notify-send -a "Recording" "Recording started" "Press Super+Print again (or click REC in the bar) to stop."

# Run wf-recorder in the foreground: non-interactive fish blocks SIGINT/SIGQUIT
# in background jobs, which would make the stop signal undeliverable and leave
# the mp4 unfinalized (missing moov atom).
wf-recorder -g "$geometry" -f $filename

pkill -RTMIN+8 waybar
if test -s "$filename"
    notify-send -a "Recording" "Recording saved" "$filename"
else
    notify-send -a "Recording" -u critical "Recording failed" "No video file was produced."
end
