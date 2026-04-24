#!/usr/bin/env sh

set -eu

sshup() {
    NAME_SSH_KEY="${1:-}"

    if [ -z "$NAME_SSH_KEY" ]; then
        echo "[ERROR] Missing key suffix. Usage: atom sshup <key_suffix>"
        exit 1
    fi

    KEY_PATH="$HOME/.ssh/id_ed25519_$NAME_SSH_KEY"

    if [ ! -f "$KEY_PATH" ]; then
        echo "[ERROR] SSH key not found: $KEY_PATH"
        exit 1
    fi

    if [ -z "${SSH_AUTH_SOCK:-}" ]; then
        eval "$(ssh-agent -s)"
    fi
    
    ssh-add "$KEY_PATH"
}
