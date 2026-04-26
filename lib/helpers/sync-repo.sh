#!/usr/bin/env sh

set -eu

sync_repo() {
    . "$SCRIPT_DIR/../lib/helpers/colors.sh"
    REPO_DIR=${1:-}
    TARGET_FILES=${2:-"."}
    read -p "Entre name SSH KEY: " SSH_NAME
    read -p "Enter message of commit: " MSG_COMMIT

    if ! git -C "$REPO_DIR" diff --quiet "$TARGET_FILES"; then
        git -C "$REPO_DIR" add "$TARGET_FILES"
        . "$SCRIPT_DIR/../lib/commands/sshup.sh"
        sshup "$SSH_NAME"
        . "$SCRIPT_DIR/../lib/commands/scr.sh"
        src "$(basename "$REPO_DIR")"
        git -C "$REPO_DIR" commit -m "$MSG_COMMIT"
        git -C "$REPO_DIR" push origin main
        printf "\t[OK] Extensions exported and pushed to repository successfully 🚀\n"
    else
        print "\t[OK] No changes detected in extensions list. Nothing to export.\n"
    fi
}
