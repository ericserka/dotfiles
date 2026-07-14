# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal Sway (Wayland tiling WM) configuration. `config` is the main Sway rc file; `scripts/` holds helper scripts invoked by keybindings and `exec`/`exec_always` lines in `config`. All scripts are `fish`, executable, and referenced by absolute path (`~/.config/sway/scripts/...`) from `config`.

## Applying / testing changes

- Reload config after edits: `swaymsg reload` (or `$mod+Shift+c`). This re-reads `config` but does NOT re-run one-shot `exec` lines — only `exec_always` blocks re-run.
- Validate config syntax without applying: `sway --validate` (aka `sway -C`).
- Query live state (output names, inputs, tree): `swaymsg -t get_outputs`, `swaymsg -t get_inputs`, `swaymsg -t get_tree`.
- Scripts can be run directly to test, e.g. `~/.config/sway/scripts/clipboard-manager.fish pick`.

## Conventions

- Keys: `$mod` = Super (Mod4). Home-row `$left/$down/$up/$right` = `h/j/k/l` (vim). `$term`=foot, `$menu`=wofi, `$browser`=qutebrowser.
- Add new keybindings in the relevant `# ==========` section of `config`; put any non-trivial logic in a new `scripts/*.fish` rather than inlining it in `bindsym`.
- `--locked` flag on media/brightness binds keeps them working while the screen is locked — preserve it when editing those.
- `config` ends with `include /etc/sway/config.d/*` (distro drop-ins); keep it last.

## Architecture worth knowing

**Session lock chain (security-sensitive — read before touching):**
- `vault-lock.fish` — encrypts (fusermount-unmounts) the gocryptfs knowledge vault at `~/personal/my-knowledge-vault`. Idempotent, no screen lock, safe in any teardown path. Falls back to lazy unmount so the vault ALWAYS re-locks even with open file handles.
- `lock-session.fish` — calls `vault-lock.fish` then `swaylock -f`. This is the single entry point that guarantees the vault is encrypted whenever the screen locks.
- These are wired into three paths in `config`: swayidle `timeout`/`before-sleep`, and the power-menu Logout button (which calls `vault-lock.fish` directly before `swaymsg exit`). When changing lock/idle/power behavior, keep the invariant: **the vault must be locked on every lock, sleep, and logout.**

**Conditional idle:** `swayidle-guard.fish` wraps each idle-timeout action. It exits early (skipping the action) when: kanshi profile is `docked` (reads `/tmp/kanshi-profile`), the battery is not discharging, or audio is playing. `swayidle` in `config` calls the guard for each `timeout` action but calls `lock-session.fish` directly for `before-sleep` (that one is unconditional).

**Multi-monitor:** kanshi runs via `exec_always sh -c 'pkill kanshi; kanshi'`. Profiles switched with `$mod+F7` (docked) / `$mod+F8` (dual) via `kanshictl switch`. The docked profile also suppresses idle (see guard). The `/tmp/kanshi-profile` file is the coupling between kanshi and the idle guard — it must be written by the kanshi config (in `~/.config/kanshi/`, outside this repo), not here.

**Clipboard:** `cliphist-daemon.fish` (started via `exec`) wipes history then runs `wl-paste --watch cliphist store` (500 items). `clipboard-manager.fish [pick|delete|clear]` drives the wofi-based history UI. Image helpers: `clipboard-preview-image.fish` (swayimg preview) and `clipboard-save-image.fish` (save to `~/Screenshots`).

## Script style

- All scripts are `fish` with a `#!/usr/bin/env fish` shebang and a `# name` + one-line purpose comment header.
- 100% American English in identifiers, comments, and user-facing `notify-send`/output strings.
- User feedback goes through `notify-send`.
