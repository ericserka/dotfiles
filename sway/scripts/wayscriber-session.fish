#!/usr/bin/env fish
# wayscriber-session
# On-demand control for the wayscriber annotation overlay. The daemon is only
# started when it is actually needed (presentations, screen recordings) and is
# shut down again afterwards, so nothing runs during regular sessions.

set -l pid_file $XDG_RUNTIME_DIR/wayscriber/wayscriber.pid

function daemon_running
    # Match the daemon process itself: the overlay it spawns is also named
    # wayscriber, and an orphaned overlay must not count as a live daemon.
    pgrep -f 'wayscriber --daemon$' >/dev/null
end

function start_daemon -a pid_file
    setsid wayscriber --daemon >/dev/null 2>&1 &

    # --daemon-toggle fails while the runtime record is missing, so wait for the
    # daemon to publish it (3s ceiling) before sending any command.
    for i in (seq 30)
        if test -e $pid_file
            notify-send -a "Wayscriber" "Wayscriber started" "Super+Shift+A toggles the overlay, Super+Ctrl+A shuts it down."
            return 0
        end
        sleep 0.1
    end

    notify-send -a "Wayscriber" -u critical "Wayscriber failed to start" "The daemon did not publish $pid_file."
    return 1
end

function toggle_overlay -a pid_file
    if not daemon_running
        start_daemon $pid_file; or return 1
    end
    wayscriber --daemon-toggle
end

function toggle_light
    if not daemon_running
        notify-send -a "Wayscriber" "Wayscriber is not running" "Press Super+Shift+A first."
        return 1
    end
    wayscriber --light-toggle
end

function stop_daemon
    if not daemon_running
        notify-send -a "Wayscriber" "Wayscriber is not running"
        return
    end
    pkill -x wayscriber
    notify-send -a "Wayscriber" "Wayscriber stopped"
end

set -l cmd (if set -q argv[1]; echo $argv[1]; else; echo toggle; end)

switch $cmd
    case toggle
        toggle_overlay $pid_file
    case light
        toggle_light
    case stop
        stop_daemon
    case '*'
        echo "Usage: wayscriber-session [toggle|light|stop]"
end
