# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Eric's personal dotfiles for an **Arch Linux + Sway (Wayland)** machine. Each top-level directory is one application's config and mirrors its live location under `$HOME`:

- `<tool>/` → `~/.config/<tool>/` for `fish`, `nvim`, `sway`, `foot`, `kanshi`, `mako`, `qutebrowser`, `swappy`, `swaylock`, `waybar`, `wofi`, `systemd`.
- Root files map into `$HOME` directly: `.wezterm.lua` → `~/.wezterm.lua`, `rofimoji.rc` → `~/.config/rofimoji.rc`.

The repo is a **versioned mirror**, not the live tree — files here are plain copies of what lives under `~/.config` (not symlinks, and there is no stow/chezmoi/install script). Editing a file here does **not** change running programs until the same file is in place under `~/.config`; the per-tool testing instructions below all operate on the `~/.config` copy. There is no build system and no automated tests anywhere in this repo — verification is always running the affected program by hand.

## Per-tool guidance (read these first)

The three tools with real logic have their own detailed `CLAUDE.md` — consult them before editing that tool:

- **`fish/CLAUDE.md`** — Fish shell. Autoloading model (`conf.d` vs `functions` vs `completions`), Bitwarden/vault/recording helpers, and how to reload/lint (`source`, `fish -n`).
- **`nvim/CLAUDE.md`** — Neovim (Lua + `lazy.nvim`). `init.lua` load order, where the plugin list lives (`lua/lazy-config.lua`), and the LSP architecture (`after/lsp/<server>.lua` overrides, format-on-save).
- **`sway/CLAUDE.md`** — Sway WM. The **security-sensitive session-lock chain** (the gocryptfs vault must be re-encrypted on every lock/sleep/logout), the conditional idle guard, kanshi multi-monitor coupling, and clipboard scripts.

The other directories (`foot`, `mako`, `waybar`, `wofi`, `swaylock`, `swappy`, `kanshi`, `qutebrowser`) are mostly static declarative config with no per-tool CLAUDE.md.

## Cross-cutting architecture

These pieces span directories — a change in one usually requires a matching change in another:

- **Session lock / knowledge vault.** A `gocryptfs` vault at `~/personal/my-knowledge-vault` is opened/closed by `fish/functions/vault-open.fish` / `vault-close.fish` and force-locked by `sway/scripts/vault-lock.fish`. Sway's `lock-session.fish` chains vault-lock → `swaylock`. Invariant: the vault is encrypted on **every** screen lock, sleep, and logout — never add a lock/idle/power path that skips it.
- **Idle ↔ kanshi coupling.** `sway/scripts/swayidle-guard.fish` reads `/tmp/kanshi-profile` (written by the kanshi config) to suppress idle when docked. The `kanshi/` config and the Sway guard must agree on that file.
- **Clipboard.** Sway starts `cliphist` (`sway/scripts/cliphist-daemon.fish`) and drives a wofi-based history UI; Wayland clipboard I/O uses `wl-copy`/`wl-paste` throughout (fish helpers, rofimoji.rc).

## Conventions

- **Environment assumption:** everything targets Wayland/Sway + Arch and specific tools — `wl-copy`/`wl-paste`, `slurp`, `pactl`, `gocryptfs`/`fusermount3`, `wf-recorder`, `jq`, Flatpak apps, `notify-send` for user feedback. Reuse these; do not introduce X11/GNOME equivalents.
- **American English** in all identifiers, comments, and user-facing/log strings, regardless of any Portuguese content in reference docs (e.g. `nvim/cheat_sheet.md`, spell files) — those docs are personal reference, not loaded config.
