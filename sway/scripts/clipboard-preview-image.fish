#!/usr/bin/env fish
# clipboard-preview-image
# Opens a preview of the current image in the clipboard using imv

set -l tmp (mktemp /tmp/clipboard-preview-XXXXXX.png)

wl-paste >$tmp 2>/dev/null

if file $tmp | grep -q image
    swayimg $tmp
else
    notify-send Clipboard "There is no image in the clipboard."
end

rm -f $tmp
