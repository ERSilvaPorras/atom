#!/usr/bin/env sh

set -eu

sshc() {
    read -p "Enter NAME_SSH_KEY (e.g., personal): " NAME_SSH_KEY
    read -p "Enter EMAIL: " EMAIL
    read -p "Is Server? (y/n): " IS_SERVER

    TYPE_ENCRYPTION=$(ssh -Q key | grep -q "ed25519" && echo "ed25519" || echo "rsa")
    URL_GITHUB_SSH="https://github.com/settings/ssh/new"
    
    if [ "$TYPE_ENCRYPTION" = "ed25519" ]; then
        ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519_$NAME_SSH_KEY" -C "$EMAIL"
    else
        ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa_$NAME_SSH_KEY" -C "$EMAIL"
    fi

    # Add these credential to ~/.ssh/config
    SSH_CONFIG_ENTRY="Host $NAME_SSH_KEY
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_${TYPE_ENCRYPTION}_$NAME_SSH_KEY
    IdentitiesOnly yes # Fuerza el uso exclusivo de la clave, causa problemas si tienes varias claves
    AddKeysToAgent yes # Agrega automaticamente al ssh-agent
    
    "

    echo "$SSH_CONFIG_ENTRY" >> "$HOME/.ssh/config"

    # Copy the public key to the clipboard
    . "$SCRIPT_DIR/../lib/helpers/cptext.sh"
    if command -v xclip >/dev/null 2>&1; then
        xclip -sel clip < "$HOME/.ssh/id_${TYPE_ENCRYPTION}_$NAME_SSH_KEY.pub"
    elif command -v pbcopy >/dev/null 2>&1; then
        pbcopy < "$HOME/.ssh/id_${TYPE_ENCRYPTION}_$NAME_SSH_KEY.pub"
    elif command -v cpt >/dev/null 2>&1; then
        cpt "$(cat "$HOME/.ssh/id_${TYPE_ENCRYPTION}_$NAME_SSH_KEY.pub")"
    else
        echo "[WARNING] No clipboard utility found. Please copy the public key manually"
    fi

    echo "[INFO] Remember to add the public key to your GitHub account. ⚠️"
    . "$SCRIPT_DIR/../lib/helpers/colors.sh"
    if [ "$IS_SERVER" = "y" ]; then
        printf "Please add the following public key to your GitHub account:\n\n\n${blue}$(cat "$HOME/.ssh/id_${TYPE_ENCRYPTION}_$NAME_SSH_KEY.pub")${reset}"
    else
        nohup xdg-open "$URL_GITHUB_SSH" > /dev/null 2>&1 &
    fi
}
