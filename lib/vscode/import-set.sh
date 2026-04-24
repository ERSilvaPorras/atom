#!/usr/bin/env sh

set -eu

import_set() {
    . "$SCRIPT_DIR/../lib/vscode/vsc-precheck.sh"
    vsc_precheck
    
    cat "$SETTINGS" > "$HOME/.config/Code/User/settings.json"
    echo "[OK] Settings imported successfully 🚀"
}
