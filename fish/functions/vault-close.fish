function vault-close --description 'Lock the my-knowledge-vault (gocryptfs)'
    set -l mount ~/personal/my-knowledge-vault

    if not mountpoint -q $mount
        echo "Vault is already locked 🔒"
        return 0
    end

    if fusermount3 -u $mount 2>/dev/null
        echo "Vault locked 🔒"
        return 0
    end

    echo "Could not lock: a program is still using the folder." >&2
    echo "Close any Obsidian/Neovim open in the vault (and leave any terminal 'cd'd into it), then run 'vault-close' again." >&2
    echo "" >&2
    echo "Currently holding the folder:" >&2
    fuser -mv $mount 2>&1 | grep (whoami) >&2
    return 1
end
