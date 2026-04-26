#!/usr/bin/env sh

set -eu

REPO_URL="https://github.com/ERSilvaPorras/atom.git"
INSTALL_DIR="$HOME/.atom"
BIN_PATH="$HOME/.local/bin/atom"

echo "[INFO] Installing Atom CLI ..."

if [ ! -d "$INSTALL_DIR" ]; then 
    echo "[INFO] Cloning Atom repository to $INSTALL_DIR ..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# permissions
chmod +x "$INSTALL_DIR/bin/atom"

# Verify if ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    BIN_PATH="/usr/local/bin/atom"
    echo "[INFO] Will create symlink in /usr/local/bin"
fi

# Symlink global
echo "[INFO] Creating symlink ..."
if [ ! -d "$(dirname "$BIN_PATH")" ]; then
    mkdir -p "$(dirname "$BIN_PATH")"
fi

if [ "$BIN_PATH" = "/usr/local/bin/atom" ]; then
    sudo ln -sf "$INSTALL_DIR/bin/atom" "$BIN_PATH"
else
    ln -sf "$INSTALL_DIR/bin/atom" "$BIN_PATH"
fi

echo "[OK] Successfully installed 🚀"

. "$SCRIPT_DIR/../lib/commands/scr.sh"
scr "atom"
