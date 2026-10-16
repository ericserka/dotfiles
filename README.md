# dotfiles

Personal configuration for an **Arch Linux + Sway (Wayland)** laptop, plus the inventory needed to rebuild the machine from scratch: installed packages, enabled services, the `/etc` files that hold deliberate choices, and asdf-managed tools.

## How it is organized

The repo has two layers:

1. **Config mirrors.** Plain copies of what lives under `$HOME`, not symlinks. Each top-level directory mirrors one program's config directory. Editing a file here changes nothing until the same file is in place under `$HOME`.
2. **System layer (`system/`).** What the config mirrors cannot capture: which packages are installed, which services are enabled, and the system-wide files under `/etc`. Two scripts keep it in sync with the machine.

### Config mirrors

| In this repo | Lives at |
|---|---|
| `fish/` `foot/` `kanshi/` `mako/` `nvim/` `qutebrowser/` `swappy/` `sway/` `swaylock/` `systemd/` `waybar/` `wireplumber/` `wofi/` | `~/.config/<same name>/` |
| `rofimoji.rc`, `mimeapps.list` | `~/.config/` |
| `.wezterm.lua`, `.tool-versions` | `~/` |

### System layer

| Path | Contents |
|---|---|
| `system/packages/pacman.txt` | Explicitly installed packages from the official repos |
| `system/packages/aur.txt` | Explicitly installed AUR packages (`*-debug` byproducts filtered out) |
| `system/packages/flatpak.txt` | Flatpak apps, installed system-wide from Flathub |
| `system/services/system.txt` | System units enabled by hand (preset-enabled units are left out) |
| `system/services/user.txt` | User units enabled under `~/.config/systemd/user` |
| `system/etc/` | Tracked `/etc` files, at the same relative paths |
| `system/asdf/plugins.txt` | asdf plugins with pinned repository URLs |
| `system/snapshot.fish` | Refreshes everything above from the live machine |
| `system/restore.fish` | Rebuilds a fresh machine from everything above |

Only explicitly installed packages are listed: dependencies come back on their own. The same goes for services: units that Arch or their packages enable by default would be enabled on a fresh install anyway, so only the deliberate `systemctl enable` calls are recorded.

The tracked `/etc` files are:

| File | Why it is tracked |
|---|---|
| `pacman.conf` | Colored output, 10 parallel downloads |
| `NetworkManager/NetworkManager.conf` | NetworkManager drives Wi-Fi through `iwd` |
| `bluetooth/main.conf` | Bluetooth stays off at boot (`AutoEnable=false`); the fish `headphone-on`/`headphone-off` helpers power it on demand |
| `systemd/system/getty@.service.d/numlock.conf` | Num Lock on at the TTY login prompt |
| `vconsole.conf` | `br-abnt2` console keymap |
| `locale.gen`, `locale.conf` | `en_US` and `pt_BR` locales, English system language |

## Day-to-day workflow

**Changing a config:** edit the live file under `$HOME`, test it, then copy it into the repo:

```fish
cp ~/.config/sway/config ~/personal/dotfiles/sway/config
```

**Before every commit**, refresh the system layer:

```fish
~/personal/dotfiles/system/snapshot.fish
git -C ~/personal/dotfiles diff
```

The diff reads like a changelog of the machine, e.g. a package that was installed or removed, a service that was enabled, or an `/etc` file that was edited. Never edit the generated lists by hand: change the machine, then re-run the snapshot.

**Tracking another `/etc` file:** copy it in once and the snapshot keeps it fresh from then on:

```fish
install -Dm644 /etc/<path> ~/personal/dotfiles/system/etc/<path>
```

If the file only takes effect after a regeneration step (like `locale-gen` or `mkinitcpio -P`), add that step to `apply_etc_side_effects` in `system/restore.fish`.

## Setting up a fresh machine

Starting point: a base Arch install with network access and a user with `sudo`.

1. **Install the bootstrap tools and clone the repo:**

   ```sh
   sudo pacman -S --needed git fish base-devel
   git clone https://github.com/ericserka/dotfiles ~/personal/dotfiles
   ```

2. **Copy the config mirrors into place:**

   ```fish
   cd ~/personal/dotfiles
   mkdir -p ~/.config
   cp -r fish foot kanshi mako nvim qutebrowser swappy sway swaylock systemd waybar wireplumber wofi ~/.config/
   cp rofimoji.rc mimeapps.list ~/.config/
   cp .wezterm.lua .tool-versions ~/
   ```

   This step comes before the restore: the restore enables user units from `~/.config/systemd/user`.

3. **Rebuild the system layer.** Run it as your own user; it calls `sudo` where root is needed:

   ```fish
   ~/personal/dotfiles/system/restore.fish
   ```

   It runs in dependency order:
   1. official packages;
   2. `yay` (bootstrapped from the AUR if missing) and AUR packages;
   3. Flatpak apps;
   4. `/etc` files, plus their regeneration steps;
   5. services;
   6. asdf plugins and tool versions.

   Every step skips work that is already done, so if one fails, fix the cause and run it again.

4. **Make fish the login shell and reboot:**

   ```sh
   chsh -s /usr/bin/fish
   reboot
   ```

   Logging in on TTY1 starts Sway automatically (see `fish/config.fish`).

## What is deliberately not tracked

- **Secrets and machine identity:** `/etc/shadow`, `/etc/passwd`, `/etc/sudoers`, `/etc/fstab`, `/etc/hostname`, `/etc/hosts`, and `NetworkManager/system-connections/` (it stores Wi-Fi passwords).
- **Generated files:** `/etc/resolv.conf`, the pacman mirrorlist, the mkinitcpio presets.
- **Machine-local data:** `nvim/spell/` (personal word lists), the knowledge vault under `~/personal/`.

## More documentation

Each `CLAUDE.md` documents how its part of the repo works. They are written for Claude Code but read fine as developer notes:

- [`CLAUDE.md`](CLAUDE.md): repo-wide architecture and conventions.
- [`fish/CLAUDE.md`](fish/CLAUDE.md): Fish autoloading model and the Bitwarden, vault, and recording helpers.
- [`nvim/CLAUDE.md`](nvim/CLAUDE.md): Neovim load order, plugins, LSP setup.
- [`sway/CLAUDE.md`](sway/CLAUDE.md): the session-lock chain that keeps the vault encrypted, the idle guard, multi-monitor setup.
