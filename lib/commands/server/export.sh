#!/usr/bin/env sh

set -eu

. "$SCRIPT_DIR/../lib/helpers/colors.sh"

save_apt_mark() {
    apt-mark showmanual > "$APT_MARK_FILE_PATH"
}

save_zshrc() {
    if [ ! -f "$HOME/.zshrc" ]; then
        printf "${red}[ERROR] No .zshrc file found in the home directory.${reset}\n"
        return
    fi
    cat "$HOME/.zshrc" > "$ZSHRC_FILE_PATH"
}

save_images_docker() {
    if ! command -v docker > /dev/null 2>&1; then
        printf "\t${red}[ERROR] Docker is not installed. Skipping Docker images export.${reset}\n"
        return
    fi

    docker images --format "{{.Repository}}:{{.Tag}}" > "$IMAGES_DOCKER_FILE_PATH"
}

is_ubuntu_system() {
    if [ -f "/etc/os-release" ]; then
        . "/etc/os-release"
        if [ "$ID" = "ubuntu" ]; then
            return 0
        fi
    fi
    return 1
}

export_server() {
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
    fi

    if is_ubuntu_system; then
        save_apt_mark
    fi
    save_zshrc
    save_images_docker
    printf "\t${green}[INFO] Server configuration exported successfully.${reset}\n"
}
