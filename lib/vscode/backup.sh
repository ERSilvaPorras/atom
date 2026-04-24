#!/usr/bin/env sh

set -eu
REPO_URL="https://github.com/ersilvaporras/learn-vscode.git"
INSTALL_DIR="$HOME/Documents/git/learn-vscode"
EXTENSIONS_FILE_PATH="$INSTALL_DIR/config/extensions.txt"

backup() {
    EXTENSION_LIST=$(code --list-extensions)

    
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_URL" "$INSTALL_DIR"
        atom src "$(basename "$INSTALL_DIR")"
    fi

    if [ ! -d  "$INSTALL_DIR/.git" ]; then
        echo "[ERROR] The directory $INSTALL_DIR is not a git repository."
        exit 1
    fi

    echo "$EXTENSION_LIST" > "$EXTENSIONS_FILE_PATH"
    
    if ! git -C "$INSTALL_DIR" diff --quiet "$EXTENSIONS_FILE_PATH"; then
        git -C "$INSTALL_DIR" add "$EXTENSIONS_FILE_PATH"
        . "$SCRIPT_DIR/../lib/sshup.sh"
        sshup "$1"
        git -C "$INSTALL_DIR" commit -m "docs(backup): update vscode extensions list"
        git -C "$INSTALL_DIR" push origin main  
    fi
}
