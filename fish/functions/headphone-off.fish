function headphone-off --description 'Disconnect the JBL Tune 720BT headset and power off Bluetooth'
    if not systemctl is-active -q bluetooth
        echo "Bluetooth is already off 📴"
        return 0
    end

    # Powering off the adapter drops any connection anyway, so a failed lookup
    # only skips the graceful disconnect
    set -l mac (__headphone_mac 2>/dev/null)
    if test -n "$mac"; and bluetoothctl info $mac 2>/dev/null | grep -q 'Connected: yes'
        timeout 10 bluetoothctl disconnect $mac >/dev/null 2>&1
    end

    if bluetoothctl show | grep -q 'Powered: yes'
        if not bluetoothctl power off >/dev/null
            echo "Error: could not power off the Bluetooth adapter" >&2
            return 1
        end
    end

    echo "Bluetooth is off 📴 — audio is back on the built-in speakers and mic"
end
