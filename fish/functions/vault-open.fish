function vault-open --description 'Unlock the my-knowledge-vault (gocryptfs)'
    set -l cipher ~/personal/.my-knowledge-vault.enc
    set -l mount ~/personal/my-knowledge-vault

    if mountpoint -q $mount
        echo "Vault is already unlocked at $mount 🔓"
        return 0
    end

    if not test -f $cipher/gocryptfs.conf
        echo "Error: vault not found at $cipher" >&2
        return 1
    end

    gocryptfs $cipher $mount
    and echo "Vault unlocked at $mount 🔓"
end
