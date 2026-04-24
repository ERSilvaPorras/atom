#!/usr/bin/env sh

set -eu

vscode() {
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        backup)
            . "$SCRIPT_DIR/../lib/vscode/backup.sh"
            backup "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
