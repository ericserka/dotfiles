# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Eric's personal dotfiles for an **Arch Linux + Sway (Wayland)** machine. Each top-level directory is one application's config and mirrors its live location under `$HOME`:

- `<tool>/` → `~/.config/<tool>/` for `fish`, `nvim`, `sway`, `foot`, `kanshi`, `mako`, `qutebrowser`, `swappy`, `swaylock`, `waybar`, `wofi`, `systemd`, `wireplumber`.
- Root files map into `$HOME` directly: `.wezterm.lua` → `~/.wezterm.lua`, `.tool-versions` → `~/.tool-versions` (asdf), `rofimoji.rc` → `~/.config/rofimoji.rc`, `mimeapps.list` → `~/.config/mimeapps.list`.
- `system/` is the one exception: it mirrors no `~/.config` directory. See "System layer" below.

The repo is a **versioned mirror**, not the live tree — files here are plain copies of what lives under `~/.config` (not symlinks, and there is no stow/chezmoi; config files are copied into place by hand, and only the `system/` layer has scripts). Editing a file here does **not** change running programs until the same file is in place under `~/.config`; the per-tool testing instructions below all operate on the `~/.config` copy. There is no build system and no automated tests anywhere in this repo — verification is always running the affected program by hand.

## System layer (`system/`)

The machine inventory that config mirrors cannot capture — what is installed and what is enabled — plus the few `/etc` files that hold deliberate choices. `system/snapshot.fish` refreshes it from the live machine (live → repo); `system/restore.fish` rebuilds a fresh machine from it (repo → live).

- `packages/{pacman,aur,flatpak}.txt` — explicitly installed packages only; dependencies come back on their own. `*-debug` split packages (makepkg byproducts) are filtered out of the AUR list.
- `services/system.txt` — enabled system units whose preset is `disabled`, i.e. the hand-made `systemctl enable` calls. Preset-enabled units are left out: a fresh install enables them anyway.
- `services/user.txt` — user units enabled under `~/.config/systemd/user/*.wants/`. Units enabled globally under `/etc/systemd/user` ship that way with their packages and are left out. The PRESET column cannot filter here: user presets report every unit as enabled.
- `etc/` — mirrors `/etc` by relative path. The tree itself is the manifest: the snapshot only refreshes files already present, and the restore installs each one as `root:root 644`.
- `asdf/plugins.txt` — `<name> <url>` per line. URLs are pinned because short names resolve through a community index that can change. Tool versions live in the root `.tool-versions`.

Rules when working here:

- **Run `system/snapshot.fish` before committing anything in this repo**, so the inventory never lags behind the machine. Its git diff is the review of what changed.
- The lists are generated — never hand-edit them; change the machine and re-run the snapshot.
- Track a new `/etc` file by copying it in once (`install -Dm644 /etc/<path> system/etc/<path>`). If it only takes effect after a regeneration step (like `locale-gen` or `mkinitcpio -P`), add that step to `apply_etc_side_effects` in `restore.fish`.
- **Never track secrets or machine identity** in `etc/`: no `shadow`/`passwd`/`sudoers`, no `NetworkManager/system-connections/` (Wi-Fi passwords), no `fstab`/`hostname`/`hosts`.
- `restore.fish` must stay idempotent — every step skips work already done, so a failed run is fixed by re-running it. Keep its step order (packages → AUR → Flatpak → `/etc` → services → asdf): later steps depend on earlier ones.
- Lint with `fish -n`. Exercise risky paths by sourcing the functions with a stubbed `sudo` function, never by running the restore against the live machine.

## Per-tool guidance (read these first)

The three tools with real logic have their own detailed `CLAUDE.md` — consult them before editing that tool:

- **`fish/CLAUDE.md`** — Fish shell. Autoloading model (`conf.d` vs `functions` vs `completions`), Bitwarden/vault/recording helpers, and how to reload/lint (`source`, `fish -n`).
- **`nvim/CLAUDE.md`** — Neovim (Lua + built-in `vim.pack`). `init.lua` load order, where the plugin list lives (`lua/pack-config.lua`), the native replacements under `lua/native/` (ui2 messages, LSP completion, inline completion), and the LSP architecture (`after/lsp/<server>.lua` overrides, format-on-save).
- **`sway/CLAUDE.md`** — Sway WM. The **security-sensitive session-lock chain** (the gocryptfs vault must be re-encrypted on every lock/sleep/logout), the conditional idle guard, kanshi multi-monitor coupling, and clipboard scripts.

The other directories (`foot`, `mako`, `waybar`, `wofi`, `swaylock`, `swappy`, `kanshi`, `qutebrowser`, `wireplumber`) are mostly static declarative config with no per-tool CLAUDE.md.

## Cross-cutting architecture

These pieces span directories — a change in one usually requires a matching change in another:

- **Session lock / knowledge vault.** A `gocryptfs` vault at `~/personal/my-knowledge-vault` is opened/closed by `fish/functions/vault-open.fish` / `vault-close.fish` and force-locked by `sway/scripts/vault-lock.fish`. Sway's `lock-session.fish` chains vault-lock → `swaylock`. Invariant: the vault is encrypted on **every** screen lock, sleep, and logout — never add a lock/idle/power path that skips it.
- **Idle ↔ kanshi coupling.** `sway/scripts/swayidle-guard.fish` reads `/tmp/kanshi-profile` (written by the kanshi config) to suppress idle when docked. The `kanshi/` config and the Sway guard must agree on that file.
- **Clipboard.** Sway starts `cliphist` (`sway/scripts/cliphist-daemon.fish`) and drives a wofi-based history UI; Wayland clipboard I/O uses `wl-copy`/`wl-paste` throughout (fish helpers, rofimoji.rc).

## Conventions

- **Environment assumption:** everything targets Wayland/Sway + Arch and specific tools — `wl-copy`/`wl-paste`, `slurp`, `pactl`, `gocryptfs`/`fusermount3`, `wf-recorder`, `jq`, Flatpak apps, `notify-send` for user feedback. Reuse these; do not introduce X11/GNOME equivalents.
- **American English** in all identifiers, comments, and user-facing/log strings, regardless of any Portuguese content in reference docs (e.g. `nvim/cheat_sheet.md`) — those docs are personal reference, not loaded config.
- **Ignored paths:** `nvim/spell/` is machine-local data (personal word lists and their generated `.spl` binaries) and is git-ignored — do not re-add it.
