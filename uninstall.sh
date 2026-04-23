#!/usr/bin/env sh

set -eu

BIN_PATH="$HOME/.local/bin/atom"
INSTALL_DIR="$HOME/.atom"

sudo rm -f "$BIN_PATH"
sudo rm -rf "$INSTALL_DIR"

echo "[OK] Successfully uninstalled Atom CLI 🚀"
