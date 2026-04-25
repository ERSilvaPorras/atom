#!/usr/bin/env sh

set -eu

vscode() {
    REPO_BACKUP_URL="git@github.com:ERSilvaPorras/learn-vscode.git"
    INSTALL_DIR="$HOME/Documents/git/learn-vscode"
    EXTENSIONS_FILE_PATH="$INSTALL_DIR/config/extensions.txt"
    SETTINGS_FILE_PATH="$INSTALL_DIR/config/settings.json"
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        export)
            . "$SCRIPT_DIR/../lib/commands/vscode/export-ext.sh"
            export_ext "$@"
            ;;
        import)
            . "$SCRIPT_DIR/../lib/commands/vscode/import-ext.sh"
            import_ext "$@"
            ;;
        settings)
            . "$SCRIPT_DIR/../lib/commands/vscode/import-set.sh"
            import_set "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
