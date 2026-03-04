#!/usr/bin/env fish
# cliphist-daemon
# Start the clipboard history daemon

exec wl-paste --watch cliphist -max-items 500 -max-dedupe-search 10 store
