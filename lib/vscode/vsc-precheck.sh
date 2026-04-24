#!/usr/bin/env sh

set -eu

vsc_precheck() {
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
    fi

    if [ ! -d "$INSTALL_DIR/.git" ]; then
        echo "[ERROR] Backup repository is not a git repository"
        exit 1
    fi

    if [ ! code --version >/dev/null 2>&1 ]; then
        echo "[ERROR] VSCode CLI not found. Please install Visual Studio Code and ensure 'code' command is available in PATH."
        exit 1
    fi
}