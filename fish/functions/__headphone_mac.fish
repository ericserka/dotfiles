function __headphone_mac --description 'Print the Bluetooth address of the paired headset, looked up by name'
    # Looked up at runtime so the address never lands in the dotfiles repository
    set -l name 'JBL Tune 720BT'

    set -l mac (bluetoothctl devices Paired | string match -rg "^Device (\S+) $name\$")
    if test -z "$mac"
        echo "Error: no paired device named '$name' (pair it first with bluetoothctl)" >&2
        return 1
    end

    echo $mac[1]
end
