#!/usr/bin/env sh

set -eu

server() {
    REPO_BACKUP_URL="git@github.com:ERSilvaPorras/server-setup.git"
    INSTALL_DIR="$HOME/Documents/git/server-setup"
    ZSHRC_FILE_PATH="$INSTALL_DIR/config/.zshrc"
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        export)
            . "$SCRIPT_DIR/../lib/commands/server/export.sh"
            export_server "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
