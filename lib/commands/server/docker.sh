#!/usr/bin/env sh

set -eu

install_docker() {
    . "$SCRIPT_DIR/../lib/helpers/colors.sh"
    printf "\t[INFO] Installing Docker...\n"
    if ! command -v docker >/dev/null 2>&1; then
        # Add Docker's official GPG key:
        sudo apt update
        sudo apt install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources:
        docker_suite="$({ . /etc/os-release && printf '%s' "${UBUNTU_CODENAME:-$VERSION_CODENAME}"; })"
        docker_arch="$(dpkg --print-architecture)"
        printf '%s\n' \
            'Types: deb' \
            'URIs: https://download.docker.com/linux/ubuntu' \
            "Suites: $docker_suite" \
            'Components: stable' \
            "Architectures: $docker_arch" \
            'Signed-By: /etc/apt/keyrings/docker.asc' | sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null
        sudo apt update
    else
        printf "\t[INFO] Docker is already installed. Skipping installation...\n"
    fi
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl status docker
    sudo systemctl start docker
    
    printf "\t${green}[OK] Docker installed successfully ${reset} 🚀\n"

    sudo usermod -aG docker "$USER"
    printf "\t${green}[OK] Added user $USER to docker group. Please log out and log back in for changes to take effect.${reset}\n"
}