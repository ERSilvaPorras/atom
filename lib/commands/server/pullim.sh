#!/usr/bin/env sh

set -eu

pull_images() {
    . "$SCRIPT_DIR/../lib/helpers/colors.sh"
    printf "\t[INFO] Pulling Docker images...\n"

    . "$SCRIPT_DIR/../lib/commands/sshup.sh"
    read -p "Enter SSH_NAME: " SSH_NAME
    sshup "$SSH_NAME"
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_BACKUP_URL" "$INSTALL_DIR"
        printf "\t[INFO] Cloning repository...${reset}\n"
    else
        git -C "$INSTALL_DIR" pull
        printf "\t[INFO] Repository already exists. Pulling latest changes...${reset}\n"
    fi

    read -p "Enter USER_DOCKER: " USER_DOCKER
    docker login ghcr.io -u "$USER_DOCKER"
    for image in $(cat "$IMAGES_DOCKER_FILE_PATH"); do
        printf "\t[INFO] Pulling image: $image...\n"
        if ! sudo docker pull "$image"; then
            printf "\t[ERROR] Failed to pull image: $image. Skipping...\n"
        else
            printf "\t[INFO] Successfully pulled image: $image\n"
        fi
    done
    printf "\t${green}[OK] Docker images pulled successfully ${reset} 🚀\n"

    printf "\t${green}[OK] Docker images pulled successfully ${reset} 🚀\n"
}
