#!/usr/bin/env fish
# clipboard-manager
# Clipboard manager using wofi

set -l wofi_args \
    --dmenu \
    --insensitive \
    --conf ~/.config/sway/wofi/config \
    --style ~/.config/sway/wofi/style.css \
    --prompt "📋 Clipboard" \
    --width 600 \
    --height 400 \
    --lines 15 \
    --no-actions

function pick
    set -l selected (cliphist list | wofi $argv)
    if test -z "$selected"
        return
    end
    echo $selected | cliphist decode | wl-copy
end

function delete_item
    set -l selected (
        cliphist list \
            | wofi --dmenu --insensitive \
                --prompt "🗑️  Delete" \
                --width 600 --height 400 --lines 15
    )
    if test -z "$selected"
        return
    end
    echo $selected | cliphist delete
    notify-send Clipboard "Item removed from history."
end

function clear_all
    cliphist wipe
    notify-send Clipboard "Successfully cleared history."
end

set -l cmd (if set -q argv[1]; echo $argv[1]; else; echo pick; end)

switch $cmd
    case pick
        pick $wofi_args
    case delete
        delete_item
    case clear
        clear_all
    case '*'
        echo "Usage: clipboard-manager [pick|delete|clear]"
end
