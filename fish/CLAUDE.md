# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal [Fish shell](https://fishshell.com/) configuration for an Arch Linux + Sway (Wayland) machine. This directory is not itself a git repository, but the whole `fish/` tree is tracked as part of the dotfiles repository. Everything here is loaded by Fish at shell startup, so changes take effect on new shells (or after re-`source`ing the changed file).

## Fish's autoloading model (most important thing to know)

Fish autoloads files by directory convention — there is no central "require"/import list. Where you put a file determines when and how it loads:

- `config.fish` — runs once per interactive shell, top to bottom. Holds startup logic that must be ordered: exec-into-Sway on VT1, ssh-agent bootstrap, PATH construction (asdf shims, Homebrew, `~/.local/bin`, opencode), and `$EDITOR`/`$VISUAL`.
- `conf.d/*.fish` — sourced automatically at startup, **before** `config.fish`, in alphabetical order. Use for environment setup and for defining functions that should always exist. Files here define functions eagerly (e.g. all `bw-*`, `rec-*`, `open`).
- `functions/*.fish` — **lazily autoloaded** by filename: `functions/vault-open.fish` is only sourced the first time `vault-open` is invoked. The file's primary function name must match the filename. Helper functions may live in the same file and load alongside it.
- `completions/*.fish` — lazily autoloaded to provide tab completions for the command matching the filename (`completions/<cmd>.fish` → `<cmd>`).

Because `conf.d` loads before `config.fish`, don't rely on `config.fish`-set PATH entries inside `conf.d` files.

## Applying and testing changes

- New interactive shell picks up all changes. To reload the current shell after editing: `source ~/.config/fish/config.fish` (or `exec fish`).
- Re-source a single edited function/conf file: `source ~/.config/fish/conf.d/<file>.fish`.
- Lint/parse-check without executing: `fish -n <file>.fish`.
- Dry-run a function in a throwaway shell: `fish -c 'source functions/vault-open.fish; vault-open --help'`.
- There is no build or automated test suite — verification is running the affected command by hand.

## Feature areas (each self-contained in its own file)

- **Bitwarden helpers** (`conf.d/bitwarden.fish`). CLI is Flatpak-packaged; `bw` wraps `flatpak run … com.bitwarden.desktop` and forwards `$BW_SESSION` into the sandbox. `bw-unlock` exports `BW_SESSION` for the session; `bw-pass`/`bw-search` use `--nointeraction` so a locked vault errors instead of hanging on the password prompt. Output is via `wl-copy` (Wayland clipboard) with a backgrounded 30s clear.
- **`vault-open`/`vault-close`** (`functions/`). Mount/unmount a `gocryptfs`-encrypted knowledge vault under `~/personal/`. Close uses `fusermount3 -u` and, on failure, reports which processes still hold the mount via `fuser`.
- **Screen recording** (`conf.d/recording.fish`). `rec*` family wrapping `wf-recorder` (Wayland) + `slurp` for region selection and `pactl` for audio sources; `rec-help` lists them.
- **`open`** (`conf.d/open.fish`) — detached `xdg-open`. **Aliases** (`conf.d/aliases.fish`) — `vbackup` (git commit+push a vault), `stremio`.

## Conventions to match when editing

- These scripts assume a **Wayland/Sway + Arch** environment and specific tools: `wl-copy`, `wf-recorder`, `slurp`, `pactl`, `gocryptfs`, `fusermount3`, `jq`, Flatpak apps. Reuse these rather than introducing X11/GNOME equivalents.
- Prefer local scoping (`set -l`) inside functions; use `set -gx` only for exports meant to outlive the function, and `set -U` only for cross-session config.
- User-facing messages are in American English; error/usage messages print to stderr (`>&2`) and functions `return 1` on failure — follow that pattern.
- Keep a feature's function, completions, and any conf.d setup consistent: if you add a command's subcommand, update both its `functions/<cmd>.fish` and `completions/<cmd>.fish`.
