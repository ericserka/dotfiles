#!/usr/bin/env fish
# cliphist-daemon
# Clear previous history and start the clipboard history daemon

cliphist wipe
exec wl-paste --watch cliphist -max-items 500 -max-dedupe-search 10 store
