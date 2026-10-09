function headphone-on --description 'Power on Bluetooth and connect the JBL Tune 720BT headset'
    set -l attempts 5

    if not systemctl is-active -q bluetooth
        echo "Error: the bluetooth service is not running (sudo systemctl start bluetooth)" >&2
        return 1
    end

    set -l mac (__headphone_mac); or return 1

    if not bluetoothctl show | grep -q 'Powered: yes'
        if not bluetoothctl power on >/dev/null
            echo "Error: could not power on the Bluetooth adapter" >&2
            return 1
        end
        echo "Bluetooth powered on 📶"
    end

    # The headset is trusted, so it usually reconnects by itself a few seconds
    # after being turned on; explicit connects cover the case where it doesn't.
    for attempt in (seq $attempts)
        if bluetoothctl info $mac | grep -q 'Connected: yes'
            # Give WirePlumber a moment to create the headset nodes
            sleep 2
            echo "Headset connected 🎧"
            echo "  Output: "(wpctl inspect @DEFAULT_AUDIO_SINK@ | string match -rg 'node.description = "(.*)"')
            echo "  Mic:    "(wpctl inspect @DEFAULT_AUDIO_SOURCE@ | string match -rg 'node.description = "(.*)"')
            return 0
        end
        echo "Connecting to headset (attempt $attempt/$attempts)..."
        timeout 15 bluetoothctl connect $mac >/dev/null 2>&1
        or sleep 2
    end

    echo "Could not connect to the headset." >&2
    echo "Make sure it is turned on and not connected to another device (e.g. your phone), then run 'headphone-on' again." >&2
    return 1
end
