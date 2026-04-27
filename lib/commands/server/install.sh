#!/usr/bin/env sh

set -eu

. "$SCRIPT_DIR/../lib/helpers/colors.sh"
ZSHRC_FILE="$HOME/.zshrc"

setup_ufw() {
    printf "\t[INFO] Configuring UFW...\n"
    ufw --version
    sudo ufw allow OpenSSH
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw enable
    printf "\t${green}[OK] UFW configured successfully${reset} 🚀\n"
}

setup_unattended_upgrades() {
    printf "\t[INFO] Configuring Unattended Upgrades...\n"
    sudo dpkg-reconfigure -plow unattended-upgrades
    printf "\t${green}[OK] Unattended Upgrades configured successfully${reset} 🚀\n"
}

import_zsh() {
    printf "\t[INFO] Setting up Zsh...\n"
    . "$SCRIPT_DIR/../lib/commands/sshup.sh"
    read -p "Enter SSH_NAME: " SSH_NAME
    sshup "$SSH_NAME"
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
        printf "\t[INFO] Cloning repository...${reset} 🚀\n"
    else
        git -C "$INSTALL_DIR" pull
        printf "\t[INFO] Repository already exists. Pulling latest changes...${reset} 🚀\n"
    fi

    ZSHRC_LOCAL_PATH="$HOME/.zshrc"
    if [ -f "$ZSHRC_FILE_PATH" ] && [ -f "$ZSHRC_LOCAL_PATH" ]; then
        cp "$ZSHRC_LOCAL_PATH" "$ZSHRC_LOCAL_PATH.original"
        if ! grep -q -F "ERSP Custom" "$ZSHRC_LOCAL_PATH"; then
            cat "$ZSHRC_FILE_PATH" >> "$ZSHRC_LOCAL_PATH"
        fi
    fi
    printf "\t${green}[OK] Zsh setup completed successfully${reset} 🚀\n"      
}

setup_zsh() {
    printf "\t[INFO] Installing Zsh plugins...\n"
    PLUGINS_DIR="$HOME/.local/share/zsh/plugins"
    ZSH_AUTOSUGGESTIONS_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
    ZSH_SYNTAX_HIGHLIGHTING_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    
    if [ ! -d "$PLUGINS_DIR" ]; then
        mkdir -p "$PLUGINS_DIR"
    fi
    
    if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
        git clone "$ZSH_AUTOSUGGESTIONS_URL" "$PLUGINS_DIR/zsh-autosuggestions"
    fi

    if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        git clone "$ZSH_SYNTAX_HIGHLIGHTING_URL" "$PLUGINS_DIR/zsh-syntax-highlighting"
    fi

    PLUGINS_REL_DIR="~/.local/share/zsh/plugins"
    if ! grep -q "source $PLUGINS_REL_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" "$ZSHRC_FILE"; then
        printf "\nsource $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh\n" >> "$ZSHRC_FILE"
    fi

    if ! grep -q "source $PLUGINS_REL_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$ZSHRC_FILE"; then
        printf "\nsource $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n" >> "$ZSHRC_FILE"
    fi

    zsh --version
    if [ "$SHELL" != "$(which zsh)" ]; then
        if chsh -s "$(which zsh)"; then
            printf "\t[INFO] Default shell changed to zsh. Please log out and log back in for changes to take effect.\n"
        fi
    fi
    printf "\t${green}[OK] Zsh and plugins installed successfully${reset} 🚀\n"
}

eza() {
    printf "\t[INFO] Setting up EZA aliases...\n"
    EZA_TITLE="# Custom Alias #########################################################################"
    EZA_ENTRY="${EZA_TITLE}
    alias ls='eza --icons'
    alias ll='eza -lah'
    alias la='eza -a'
    alias lt='eza --tree'
    alias bat='batcat'"

    if ! grep -q -F "$EZA_ENTRY" "$ZSHRC_FILE"; then
        printf "\n$EZA_ENTRY\n" >> "$ZSHRC_FILE"
    fi

    printf "\t${green}[OK] EZA aliases added successfully${reset} 🚀\n"
}

fzf() {
    printf "\t[INFO] Setting up FZF key bindings and completions...\n"
    FZF_TITLE="# FZF - [CTRL] + [R] Interactive #######################################################"
    FZF_ENTRY="${FZF_TITLE}
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh"
    if ! grep -q -F "$FZF_ENTRY" "$ZSHRC_FILE"; then
        printf "\n$FZF_ENTRY\n" >> "$ZSHRC_FILE"
    fi
    printf "\t${green}[OK] FZF key bindings and completions added successfully${reset} 🚀\n"
}


install_basic_packages() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y \
        ufw \
        fail2ban \
        unattended-upgrades \
        zsh \
        bat \
        tree \
        eza \
        fzf
    printf "\t${green}[OK] Basic packages installed successfully${reset} 🚀\n"
    printf "\t[INFO] Setting up configurations...\n"
    setup_ufw
    setup_unattended_upgrades
    import_zsh
    setup_zsh
    eza
    fzf
}
