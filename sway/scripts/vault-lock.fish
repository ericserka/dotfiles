#!/usr/bin/env fish

# Encrypt (unmount) the knowledge vault. No screen lock, so this is safe to call
# in any session-teardown path: idle lock, before-sleep, and logout.
# See ~/.config/sway/config (power menu + swayidle) and lock-session.fish.

set -l mount ~/personal/my-knowledge-vault

if mountpoint -q $mount
    # Prefer a clean unmount. Fall back to a lazy unmount so the vault ALWAYS
    # re-locks even if an editor still holds a file open: the path is detached
    # immediately (new processes see only the encrypted/empty mountpoint), while
    # the editor's existing handles linger until it is closed.
    fusermount3 -u $mount 2>/dev/null
    or fusermount3 -uz $mount 2>/dev/null
end
