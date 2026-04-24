#!/usr/bin/env sh

set -eu

import_ext() {
    . "$SCRIPT_DIR/../lib/vscode/vsc-precheck.sh"
    vsc_precheck

    if [ ! -f "$EXTENSIONS_FILE_PATH" ]; then
        echo "[ERROR] Extensions file not found"
        exit 1
    fi
    
    while IFS= read -r EXTENSION; do
        if [ -n "$EXTENSION" ]; then
             code --install-extension "$EXTENSION" --force
        fi
    done < "$EXTENSIONS_FILE_PATH"

    echo "[OK] Extensions installed successfully 🚀"
}
