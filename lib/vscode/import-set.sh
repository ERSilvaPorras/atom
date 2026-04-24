#!/usr/bin/env sh

set -eu

import_set() {
    . "$SCRIPT_DIR/../lib/vscode/vsc-precheck.sh"
    vsc_precheck
    
    cat "$SETTINGS_FILE_PATH" > "$HOME/.config/Code/User/settings.json"
    echo "[OK] Settings imported successfully 🚀"
}
