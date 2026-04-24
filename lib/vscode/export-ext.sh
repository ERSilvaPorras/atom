#!/usr/bin/env sh

set -eu

export_ext() {
    EXTENSION_LIST=$(code --list-extensions)

    
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
        atom src "$(basename "$INSTALL_DIR")"
    fi

    if [ ! -d  "$INSTALL_DIR/.git" ]; then
        echo "[ERROR] The directory is not a git repository."
        exit 1
    fi

    cat "$EXTENSION_LIST" > "$EXTENSIONS_FILE_PATH"
    
    if ! git -C "$INSTALL_DIR" diff --quiet "$EXTENSIONS_FILE_PATH"; then
        git -C "$INSTALL_DIR" add "$EXTENSIONS_FILE_PATH"
        . "$SCRIPT_DIR/../lib/sshup.sh"
        sshup "$1"
        git -C "$INSTALL_DIR" commit -m "docs(backup): update vscode extensions list"
        git -C "$INSTALL_DIR" push origin main  
    fi
}
