set fish_greeting

# Sway configuration code
if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" -eq 1
	exec sway
end

# SSH Agent configuration code
if test -z "$SSH_AGENT_PID"
    eval (ssh-agent -c) > /dev/null
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# Homebrew configuration code
export PATH="$HOME/.local/bin:$PATH"
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
