#!/usr/bin/env sh

set -eu

BIN_PATH="$HOME/.local/bin/atom"
INSTALL_DIR="$HOME/.atom"

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    BIN_PATH="/usr/local/bin/atom"
fi

sudo rm -f "$BIN_PATH"
sudo rm -rf "$INSTALL_DIR"

echo "[OK] Successfully uninstalled Atom CLI 🚀"
