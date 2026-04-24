#!/usr/bin/env sh

set -eu

import_ext() {
    REPO_BACKUP_PATH="$HOME/Documents/git/learn-vscode"
    EXTENSIONS="$REPO_BACKUP_PATH/config/extensions.txt"

    if [ ! -d "$REPO_BACKUP_PATH"]; then
        git clone "$REPO_BACKUP_PATH" "$REPO_BACKUP_URL"
    fi

    if [ ! -d "$REPO_BACKUP_PATH/.git" ]; then
        echo "[ERROR] Backup repository is not a git repository"
        exit 1
    fi

    if [ ! -f "$EXTENSIONS" ]; then
        echo "[ERROR] Extensions file not found"
        exit 1
    fi

    if [ ! code --version >/dev/null 2>&1 ]; then
        echo "[ERROR] VSCode CLI not found. Please install Visual Studio Code and ensure 'code' command is available in PATH."
        exit 1
    fi
    
    while IFS= read -r EXTENSION; do
        if [ -n "$EXTENSION" ]; then
             code --install-extension "$EXTENSION" --force
        fi
    done < "$EXTENSIONS"

    echo "[OK] Extensions installed successfully 🚀"
}