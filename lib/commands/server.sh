#!/usr/bin/env sh

set -eu

server() {
    REPO_BACKUP_URL="git@github.com:ERSilvaPorras/server-setup.git"
    INSTALL_DIR="$HOME/Documents/git/server-setup"
    ZSHRC_FILE_PATH="$INSTALL_DIR/config/.zshrc"
    APT_MARK_FILE_PATH="$INSTALL_DIR/config/apt-mark.txt"
    IMAGES_DOCKER_FILE_PATH="$INSTALL_DIR/config/images-docker.txt"
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        export)
            . "$SCRIPT_DIR/../lib/commands/server/export.sh"
            export_server "$@"
            ;;
        packages)
            . "$SCRIPT_DIR/../lib/commands/server/install.sh"
            install_basic_packages "$@"
            ;;
        docker)
            . "$SCRIPT_DIR/../lib/commands/server/docker.sh"
            install_docker "$@"
            ;;
        pullim)
            . "$SCRIPT_DIR/../lib/commands/server/pullim.sh"
            pull_images "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
