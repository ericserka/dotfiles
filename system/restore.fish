#!/usr/bin/env fish

# Rebuild this machine's system layer from the inventory in this repo, in dependency
# order: official packages, AUR helper and AUR packages, Flatpak apps, tracked /etc files,
# deliberately enabled services, then asdf plugins and tool versions. Every step is idempotent, so
# re-running after a failure is safe. Expects the config mirrors to be copied into
# $HOME first (the user units and ~/.tool-versions come from there; see README).

set -l system_dir (path resolve (status dirname))
set -l repo_dir (path dirname $system_dir)

function read_list --argument-names list_file
    string match -rv -- '^\s*(#|$)' <$list_file
end

function restore_pacman_packages --argument-names list_file
    set -l packages (read_list $list_file)
    test (count $packages) -eq 0; and return 0
    sudo pacman -S --needed $packages
end

function ensure_yay
    command -q yay; and return 0
    set -l build_dir (mktemp -d)
    git clone --depth 1 https://aur.archlinux.org/yay.git $build_dir
    and makepkg -si --dir $build_dir
    set -l result $status
    rm -rf $build_dir
    return $result
end

function restore_aur_packages --argument-names list_file
    set -l packages (read_list $list_file)
    test (count $packages) -eq 0; and return 0
    ensure_yay
    and yay -S --needed $packages
end

function restore_flatpak_apps --argument-names list_file
    # flatpak has no --needed, so skip what is already installed by hand.
    set -l installed (flatpak list --app --system --columns=application)
    set -l missing
    for app in (read_list $list_file)
        contains -- $app $installed; or set -a missing $app
    end
    test (count $missing) -eq 0; and return 0
    # Every tracked app comes from Flathub, installed system-wide.
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    and sudo flatpak install --system flathub $missing
end

function restore_etc --argument-names etc_mirror
    set -l changed
    for tracked in (find $etc_mirror -type f)
        set -l relative (string replace -- "$etc_mirror/" '' $tracked)
        cmp -s $tracked /etc/$relative; and continue
        sudo install -Dm644 $tracked /etc/$relative; or return 1
        set -a changed $relative
    end
    apply_etc_side_effects $changed
end

function apply_etc_side_effects
    # Some files only take effect after a regeneration step.
    if contains -- locale.gen $argv
        sudo locale-gen; or return 1
    end
    if contains -- vconsole.conf $argv
        # The sd-vconsole hook bakes the console keymap into the initramfs.
        sudo mkinitcpio -P; or return 1
    end
    if string match -q -- 'systemd/*' $argv
        sudo systemctl daemon-reload; or return 1
    end
end

function restore_services --argument-names system_list user_list
    set -l system_units (read_list $system_list)
    if test (count $system_units) -gt 0
        sudo systemctl enable $system_units; or return 1
    end
    set -l user_units (read_list $user_list)
    if test (count $user_units) -gt 0
        systemctl --user enable $user_units; or return 1
    end
end

function restore_asdf --argument-names plugins_file tool_versions_file
    set -l installed_plugins (asdf plugin list 2>/dev/null)
    for line in (read_list $plugins_file)
        set -l fields (string split -n ' ' -- $line)
        contains -- $fields[1] $installed_plugins; and continue
        asdf plugin add $fields[1] $fields[2]; or return 1
    end
    # A .tool-versions line may list several versions: "<tool> <version>...".
    for line in (read_list $tool_versions_file)
        set -l fields (string split -n ' ' -- $line)
        for tool_version in $fields[2..]
            asdf where $fields[1] $tool_version >/dev/null 2>&1; and continue
            asdf install $fields[1] $tool_version; or return 1
        end
    end
end

if fish_is_root_user
    echo "restore: run as your own user; it calls sudo where root is needed" >&2
    exit 1
end

restore_pacman_packages $system_dir/packages/pacman.txt
and restore_aur_packages $system_dir/packages/aur.txt
and restore_flatpak_apps $system_dir/packages/flatpak.txt
and restore_etc $system_dir/etc
and restore_services $system_dir/services/system.txt $system_dir/services/user.txt
and restore_asdf $system_dir/asdf/plugins.txt $repo_dir/.tool-versions
or begin
    echo "restore: a step failed; fix it and re-run (every step is idempotent)" >&2
    exit 1
end

echo "Restore complete. Reboot to start the enabled services and apply the /etc changes."
