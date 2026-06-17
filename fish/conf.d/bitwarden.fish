# Bitwarden CLI helpers (via Flatpak).
# All commands run with --nointeraction on internal calls so a locked vault
# returns an error instead of hanging on the master-password prompt.

# Thin wrapper around the Flatpak-packaged Bitwarden CLI.
# Forwards BW_SESSION into the sandbox so the unlocked session is seen.
function bw --description 'Bitwarden CLI via Flatpak'
    flatpak run --env=BW_SESSION=$BW_SESSION --command=bw com.bitwarden.desktop $argv
end

# Internal: print a clear reason when a vault command fails (never prompts).
function __bw_explain_failure
    set -l vault_status (bw --nointeraction status 2>/dev/null | jq -r '.status' 2>/dev/null)
    switch "$vault_status"
        case unauthenticated
            echo "Not logged in to Bitwarden. Run: bw login" >&2
        case unlocked
            echo "Bitwarden command failed unexpectedly while unlocked." >&2
        case '*'
            echo "Bitwarden vault is locked. Run: bw-unlock" >&2
    end
end

# Unlock the vault and export BW_SESSION for this session.
function bw-unlock --description 'Unlock the Bitwarden vault and export BW_SESSION'
    set -l session (bw unlock --raw)
    if test -z "$session"
        echo "Failed to unlock the vault (wrong password or not logged in)." >&2
        return 1
    end
    set -gx BW_SESSION $session
    echo "Vault unlocked. BW_SESSION exported for this session."
end

# Copy a Bitwarden item password to the clipboard, optionally disambiguated by username.
function bw-pass --description 'Copy a Bitwarden item password to the clipboard'
    if test (count $argv) -eq 0
        echo "Usage: bw-pass <item-name-or-search> [username]" >&2
        return 1
    end

    set -l name $argv[1]
    set -l username $argv[2]

    set -l items (bw --nointeraction list items --search $name 2>/dev/null)
    if test -z "$items"
        __bw_explain_failure
        return 1
    end

    # Keep only login items, optionally filtered by an exact username match.
    set -l filter '.[] | select(.login != null)'
    if test -n "$username"
        set filter "$filter | select(.login.username == \$user)"
    end
    set -l matches (echo $items | jq -c --arg user "$username" "$filter")

    set -l count (count $matches)
    if test $count -eq 0
        if test -n "$username"
            echo "No item matching \"$name\" with username \"$username\"." >&2
        else
            echo "No login item matching \"$name\"." >&2
        end
        return 1
    end

    if test $count -gt 1
        echo "Multiple matches for \"$name\". Re-run with the username as a second argument:" >&2
        for m in $matches
            echo "  bw-pass \"$name\" "(echo $m | jq -r '.login.username // "(no username)"') >&2
        end
        return 1
    end

    set -l password (echo $matches | jq -r '.login.password // empty')
    if test -z "$password"
        echo "The matched item has no password." >&2
        return 1
    end

    printf '%s' $password | wl-copy
    echo "Password copied to the clipboard. It will be cleared in 30s."

    # Clear the clipboard after 30s, in the background (same as the app's behavior).
    fish -c 'sleep 30; wl-copy --clear' &
    disown
end

# Search Bitwarden login items and print a readable table.
function bw-search --description 'Search Bitwarden login items and print a readable table'
    if test (count $argv) -eq 0
        echo "Usage: bw-search <term>" >&2
        return 1
    end

    set -l term $argv[1]

    set -l items (bw --nointeraction list items --search $term 2>/dev/null)
    if test -z "$items"
        __bw_explain_failure
        return 1
    end

    set -l rows (echo $items | jq -r '.[] | select(.login != null) | [.name, (.login.username // "-"), (.login.uris[0].uri // "-")] | @tsv')
    if test -z "$rows"
        echo "No login items matching \"$term\"." >&2
        return 1
    end

    set -l tab (printf '\t')
    begin
        printf 'NAME\tUSERNAME\tURI\n'
        printf '%s\n' $rows
    end | column -t -s $tab
end
