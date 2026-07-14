#!/usr/bin/env fish

# Lock the session: encrypt the knowledge vault, then lock the screen.
# Invoked by swayidle (idle `timeout` and `before-sleep`) — see ~/.config/sway/config.
# Keeping vault-lock and screen-lock in one place guarantees the encrypted vault
# is always re-locked whenever the screen locks.

~/.config/sway/scripts/vault-lock.fish

exec swaylock -f
