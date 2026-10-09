# Screen recording functions for Fish Shell
# Add to ~/.config/fish/config.fish or save as ~/.config/fish/conf.d/recording.fish

# Default directory for recordings
set -gx RECORD_DIR "$HOME/Videos"

# Create directory if it doesn't exist
if not test -d $RECORD_DIR
    mkdir -p $RECORD_DIR
end

# ========== FULLSCREEN ==========

# 1. Fullscreen without audio
function rec
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    echo "Recording to $filename (Ctrl+C to stop)"
    wf-recorder -f $filename
end

# 2. Fullscreen with system audio (what you hear)
function rec-sys
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set source (pactl get-default-sink).monitor
    echo "Recording to $filename with system audio (Ctrl+C to stop)"
    wf-recorder --audio=$source -f $filename
end

# 3. Fullscreen with microphone audio
function rec-mic
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set source (pactl get-default-source)
    echo "Recording to $filename with microphone (Ctrl+C to stop)"
    wf-recorder --audio=$source -f $filename
end

# Run a command (the recorder) with the rec-setup microphone actually live.
# A Bluetooth headset mic only carries audio in the HFP profile, and WirePlumber
# switches A2DP -> HFP (and back) only while a real app captures from it: the
# rec-setup loopback does not count, so the mic would be recorded as silence.
# Hold a throwaway capture stream on the headset mic for the duration of the
# command, so WirePlumber switches to HFP and restores A2DP once it is released.
function __rec_with_headset_mic
    if not pactl list sinks short | string match -qr '^\d+\svirtual-sink\s'
        echo "Error: virtual sink not found, run rec-setup first" >&2
        return 1
    end

    # The mic loopback created by rec-setup tells which headset is in use
    set -l mic (pactl list modules short | string match -rg '^\d+\s+module-loopback\s+source=(bluez_input\.\S+)\s+sink=virtual-sink\b')
    if test -z "$mic"
        # Not a Bluetooth mic: nothing to hold
        $argv
        return
    end

    pw-record --target $mic[1] -P '{ node.name = "rec-mic-hold" }' /dev/null &
    set -l hold $last_pid
    echo "Headset mic in use: call-quality audio (HFP) until the recording stops"

    $argv
    set -l result $status

    kill $hold 2>/dev/null
    return $result
end

# 4. Fullscreen with full audio (system + microphone)
function rec-full
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    echo "Recording to $filename with full audio (Ctrl+C to stop)"
    echo "Note: requires virtual sink setup (see rec-setup)"
    __rec_with_headset_mic wf-recorder --audio=virtual-sink.monitor -f $filename
end

# ========== SELECTED REGION ==========

# 5. Region without audio
function rec-region
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set geometry (slurp)
    if test -n "$geometry"
        echo "Recording to $filename (Ctrl+C to stop)"
        wf-recorder -g "$geometry" -f $filename
    end
end

# 6. Region with system audio
function rec-region-sys
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set geometry (slurp)
    set source (pactl get-default-sink).monitor
    if test -n "$geometry"
        echo "Recording to $filename with system audio (Ctrl+C to stop)"
        wf-recorder -g "$geometry" --audio=$source -f $filename
    end
end

# 7. Region with microphone audio
function rec-region-mic
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set geometry (slurp)
    set source (pactl get-default-source)
    if test -n "$geometry"
        echo "Recording to $filename with microphone (Ctrl+C to stop)"
        wf-recorder -g "$geometry" --audio=$source -f $filename
    end
end

# 8. Region with full audio
function rec-region-full
    set filename $RECORD_DIR/(date +%Y-%m-%d_%H-%M-%S).mp4
    set geometry (slurp)
    if test -n "$geometry"
        echo "Recording to $filename with full audio (Ctrl+C to stop)"
        __rec_with_headset_mic wf-recorder -g "$geometry" --audio=virtual-sink.monitor -f $filename
    end
end

# ========== UTILITIES ==========

# List available audio sources
function rec-sources
    echo "=== Available audio sources ==="
    pactl list sources short
    echo ""
    echo "=== Default sink (system) ==="
    pactl get-default-sink
    echo ""
    echo "=== Default source (microphone) ==="
    pactl get-default-source
end

# Setup virtual sink for full audio
function rec-setup
    echo "Creating virtual sink to combine system + microphone..."
    
    # Create virtual sink
    pactl load-module module-null-sink sink_name=virtual-sink sink_properties=device.description=VirtualSink
    
    # Create loopbacks
    pactl load-module module-loopback source=(pactl get-default-sink).monitor sink=virtual-sink
    pactl load-module module-loopback source=(pactl get-default-source) sink=virtual-sink
    
    echo "Virtual sink created! Use rec-full or rec-region-full"
    echo "Note: this configuration does not persist after reboot"
end

# Remove the virtual sink created by rec-setup, so a later rec-setup (e.g. after
# switching audio devices) starts clean instead of stacking duplicate loopbacks.
function rec-teardown
    # Safety net: release a mic hold left behind by an interrupted recording,
    # which would otherwise keep a Bluetooth headset stuck in HFP
    pkill -f rec-mic-hold

    # Only touch modules created by rec-setup, never other loopbacks or sinks
    set -l ids (pactl list modules short | string match -r '^\d+\s+module-(?:loopback|null-sink)\s.*\bsink(?:_name)?=virtual-sink\b.*' | string match -rg '^(\d+)')

    if test -z "$ids"
        echo "No virtual sink loaded, nothing to tear down"
        return 0
    end

    for id in $ids
        pactl unload-module $id
        or begin
            echo "Error: could not unload module $id" >&2
            return 1
        end
    end
    echo "Virtual sink removed"
end

# Stop recording (alternative to Ctrl+C)
function rec-stop
    pkill -SIGINT wf-recorder
    echo "Recording finished"
end

# Help
function rec-help
    echo "Screen recording commands:"
    echo ""
    echo "  FULLSCREEN"
    echo "    rec            - no audio"
    echo "    rec-sys        - system audio"
    echo "    rec-mic        - microphone audio"
    echo "    rec-full       - full audio (requires rec-setup)"
    echo ""
    echo "  SELECTED REGION"
    echo "    rec-region     - no audio"
    echo "    rec-region-sys - system audio"
    echo "    rec-region-mic - microphone audio"
    echo "    rec-region-full - full audio (requires rec-setup)"
    echo ""
    echo "  UTILITIES"
    echo "    rec-sources    - list audio sources"
    echo "    rec-setup      - setup full audio"
    echo "    rec-teardown   - remove full audio setup"
    echo "    rec-stop       - stop recording"
    echo ""
    echo "Recordings saved to: $RECORD_DIR"
end
