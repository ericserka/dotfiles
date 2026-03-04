#!/usr/bin/env fish
# clipboard-save-image
# Save the current image in the clipboard to the ~/Screenshots directory with a timestamped filename

wl-paste --type image/png >~/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
notify-send Clipboard "Image saved to ~/Screenshots."
