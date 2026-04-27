#!/usr/bin/env sh

set -eu

handler_pem() {
    SSH_DIR="$HOME/.ssh"
    read -p "Enter name .pem file: " PEM_NAME
    find "$HOME" -type f -name "${PEM_NAME}.pem" 2>/dev/null -exec mv {} "$SSH_DIR" \;
    if [ -f "$SSH_DIR/${PEM_NAME}.pem" ]; then
        printf "\t[OK] .pem file(s) moved to ~/.ssh/ successfully ✅\n"
    else
        printf "\t[ERROR] No .pem file found with the name ${PEM_NAME}.pem ❌\n"
    fi
    sudo chmod 400 "$SSH_DIR/${PEM_NAME}.pem"
    if stat -c "%a" "$SSH_DIR/${PEM_NAME}.pem" | grep -q "400"; then
        printf "\t[OK] Permissions set to 400 for ${PEM_NAME}.pem ✅\n"
    else
        printf "\t[ERROR] Failed to set permissions to 400 for ${PEM_NAME}.pem ❌\n"
    fi

    if grep -q "Host ${PEM_NAME}" "$SSH_DIR/config" 2>/dev/null; then
        printf "\t[INFO] SSH config entry for ${PEM_NAME} already exists. Skipping addition.\n"
        exit 0
    else
        read -p "Enter DNS_SERVER: " DNS_SERVER
        SSH_CONFIG_ENTRY="Host ${PEM_NAME}
        HostName ${DNS_SERVER}
        User ubuntu
        IdentityFile ~/.ssh/${PEM_NAME}.pem"
        echo "$SSH_CONFIG_ENTRY" >> "$SSH_DIR/config"
        printf "\t[OK] SSH config entry for ${PEM_NAME} added successfully ✅\n"
    fi
    
    if ! stat -c "%a" "$SSH_DIR/config" | grep -q "600"; then
        sudo chmod 600 "$SSH_DIR/config"
        printf "\t[INFO] Permissions set to 600 for ~/.ssh/config file\n"
    fi

    if ! stat -c "%a" "$SSH_DIR" | grep -q "700"; then
        sudo chmod 700 "$SSH_DIR"
        printf "\t[INFO] Permissions set to 700 for ~/.ssh/ directory\n"
    fi
}
