#!/usr/bin/env fish

# Refresh the machine inventory in this repo from the live system: package lists
# (pacman, AUR, Flatpak), deliberately enabled services, tracked /etc files, and asdf plugins/tool versions.
# Run it before committing; the git diff is the review of what changed on the machine.
# Everything it writes is consumed by restore.fish.

set -l system_dir (path resolve (status dirname))
set -l repo_dir (path dirname $system_dir)

function snapshot_packages --argument-names out_dir
    pacman -Qqen >$out_dir/pacman.txt
    # makepkg emits *-debug split packages by default: build byproducts, not choices.
    pacman -Qqem | string match -v -- '*-debug' >$out_dir/aur.txt
    flatpak list --app --system --columns=application >$out_dir/flatpak.txt
end

function snapshot_system_services --argument-names out_file
    # Keep only units whose preset is "disabled": those were enabled by hand.
    # Preset-enabled units (getty@, remote-fs.target...) come back on any fresh install.
    systemctl list-unit-files --state=enabled --no-legend \
        | string replace -rf '^(\S+)\s+enabled\s+disabled\s*$' '$1' >$out_file
end

function snapshot_user_services --argument-names out_file
    # Units under /etc/systemd/user are enabled globally by their packages; only the
    # symlinks under ~/.config/systemd/user record this user's own `enable` calls.
    for link in ~/.config/systemd/user/*.wants/*
        path basename $link
    end | sort -u >$out_file
end

function snapshot_etc --argument-names etc_mirror
    # The mirror tree is the manifest: only files already tracked here are refreshed.
    for tracked in (find $etc_mirror -type f)
        set -l live /etc/(string replace -- "$etc_mirror/" '' $tracked)
        if test -r $live
            cp -- $live $tracked
        else
            echo "snapshot: $live is missing or unreadable; kept the tracked copy" >&2
        end
    end
end

function snapshot_asdf --argument-names plugins_file tool_versions_file
    # Pin plugin URLs: short names resolve through a community index that can change.
    asdf plugin list --urls | string replace -rf '^(\S+)\s+(\S+).*$' '$1 $2' >$plugins_file
    cp -- ~/.tool-versions $tool_versions_file
end

mkdir -p $system_dir/{packages,services,asdf}

snapshot_packages $system_dir/packages
snapshot_system_services $system_dir/services/system.txt
snapshot_user_services $system_dir/services/user.txt
snapshot_etc $system_dir/etc
snapshot_asdf $system_dir/asdf/plugins.txt $repo_dir/.tool-versions

echo "Snapshot refreshed. Review it with: git -C $repo_dir diff"
