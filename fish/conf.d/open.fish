# Open files with the default application in background and detach from terminal
function open
    setsid xdg-open $argv &
end
