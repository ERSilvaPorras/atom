#!/usr/bin/env sh

source "$HOME/Documents/git/colors.sh"
set -eu

status_repos() {
    REPOS_WORKDIR=${1:-"$HOME/Documents/git"}
    SSH_NAME=${2:-"ghp"}
    
    # Verify that the repositories directory exists
    if [ ! -d "$REPOS_WORKDIR" ]; then
        echo "[ERROR] Repositories path not found: $REPOS_WORKDIR"
        exit 1
    fi

    # Load SSH configuration
    . "$SCRIPT_DIR/../lib/sshup.sh"
    sshup "$SSH_NAME"

    # Iterate over each repository in the specified directory
    for repo_dir in "$REPOS_WORKDIR"/*; do
        if [ ! -d "$repo_dir" ]; then
            continue
        fi

        cd "$repo_dir"

        if [ ! -d ".git" ]; then
            continue
        fi

        echo -e "#######################################################################"
        repo_dir=$(basename "$repo_dir")
        repo_info="Repositorio: ${repo_dir}"

        # Verify if the remote repository is accessible
        if ! git fetch &>/dev/null; then
            echo -e "📁 ${red} ${repo_info} ${reset}  🚨  El repositorio remoto no existe o no es accesible"
            continue
        fi

        # Check for uncommitted changes
        sub_info=""
        if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
        sub_info="\t$sub_info📝 Uncommitted changes in ${repo_dir}"
        fi

        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u} 2>/dev/null)
        BASE=$(git merge-base @ @{u} 2>/dev/null)


        color=${green}
        status="✅ Sin commits pendientes"
        if [ "$LOCAL" = "$REMOTE" ]; then
            if [ ! -z "$sub_info" ]; then
                color=${yellow}
            fi
        elif [ "$LOCAL" = "$BASE" ]; then
            color=${yellow}
            status="⬇️  Necesita pull"
        elif [ "$REMOTE" = "$BASE" ]; then
            color=${yellow}
            status="⬆️  Tiene commits sin subir"
        else
            color=${yellow}
            status="🔀 Hay divergencia entre local y remoto"
        fi

        # Print repository information with status
        echo -e "📁 ${color} ${repo_info} ${reset} ${status}"

        if [ ! -z "$sub_info" ]; then
            echo -e "$sub_info"
        fi
    done

}
