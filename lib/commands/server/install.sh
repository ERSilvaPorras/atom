#!/usr/bin/env sh

set -eu

ZSHRC_FILE="$HOME/.zshrc"

setup_ufw() {
    ufw --version
    sudo ufw allow OpenSSH
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw enable
    printf "\t[OK] UFW configured successfully 🚀\n"
}

setup_unattended_upgrades() {
    sudo dpkg-reconfigure -plow unattended-upgrades
    printf "\t[OK] Unattended Upgrades configured successfully 🚀\n"
}

import_zsh() {
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
        printf "\t[INFO] Cloning repository... 🚀\n"
    else
        git -C "$INSTALL_DIR" pull
        printf "\t[INFO] Repository already exists. Pulling latest changes... 🚀\n"
    fi

    ZSHRC_LOCAL_PATH="$HOME/.zshrc"
    if [ -f "$ZSHRC_FILE_PATH" ] && [ -f "$ZSHRC_LOCAL_PATH" ]; then
        cp "$ZSHRC_LOCAL_PATH" "$ZSHRC_LOCAL_PATH.original"
        cat "$ZSHRC_FILE_PATH" >> "$ZSHRC_LOCAL_PATH"
    fi      
}

setup_zsh() {
    PLUGINS_DIR="$HOME/.local/share/zsh/plugins"
    ZSH_AUTOSUGGESTIONS_URL="https://github.com/zsh-users/zsh-autosuggestions.git"
    ZSH_SYNTAX_HIGHLIGHTING_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    
    if [ ! -d "$PLUGINS_DIR" ]; then
        mkdir -p "$PLUGINS_DIR"
    fi
    
    git clone "$ZSH_AUTOSUGGESTIONS_URL" "$PLUGINS_DIR/zsh-autosuggestions"
    git clone "$ZSH_SYNTAX_HIGHLIGHTING_URL" "$PLUGINS_DIR/zsh-syntax-highlighting"

    if ! grep -q "source $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" "$ZSHRC_FILE"; then
        printf "\nsource $PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh\n" >> "$ZSHRC_FILE"
    fi

    if ! grep -q "source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$ZSHRC_FILE"; then
        printf "\nsource $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n" >> "$ZSHRC_FILE"
    fi

    zsh --version
    if [ "$SHELL" != "$(which zsh)" ]; then
        if chsh -s "$(which zsh)"; then
            printf "\t[INFO] Default shell changed to zsh. Please log out and log back in for changes to take effect.\n"
        fi
    fi
    printf "\t[OK] Zsh and plugins installed successfully 🚀\n"
}

eza() {
    EZA_TITLE="# EZA - Aliases ########################################################################"
    EZA_ENTRY="${EZA_TITLE}
    alias ls='eza --icons'
    alias ll='eza -lah'
    alias la='eza -a'
    alias lt='eza --tree'
    alias bat='batcat'"

    if ! grep "$EZA_ENTRY" "$ZSHRC_FILE"; then
        printf "\n$EZA_ENTRY\n" >> "$ZSHRC_FILE"
    fi

    printf "\t[OK] EZA aliases added successfully 🚀\n"
}

fzf() {
    FZF_TITLE="# FZF - [CTRL] + [R] Interactive #######################################################"
    FZF_ENTRY="${FZF_TITLE}
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh"
    if ! grep -q "$FZF_ENTRY" "$ZSHRC_FILE"; then
        printf "\n$FZF_ENTRY\n" >> "$ZSHRC_FILE"
    fi
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
    
    setup_ufw
    setup_unattended_upgrades
    import_zsh
    setup_zsh
    eza
    fzf
}
