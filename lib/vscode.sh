#!/usr/bin/env sh

set -eu

vscode() {
    REPO_BACKUP_URL="git@github.com:ERSilvaPorras/learn-vscode.git"
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        export)
            . "$SCRIPT_DIR/../lib/vscode/export-ext.sh"
            export_ext "$@"
            ;;
        import)
            . "$SCRIPT_DIR/../lib/vscode/import-ext.sh"
            import_ext "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
