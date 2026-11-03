#!/usr/bin/env sh

tree_networks() {
    if ! command -v docker > /dev/null 2>&1; then
        printf "\t[ERROR] Docker in not installed or not in PATH\n"
        return 1
    fi

    command docker network ls --format '{{.Name}} {{.ID}}' | while read -r name id; do
        containers=$(command docker network inspect "$id" --format '{{range $cid, $conf := .Containers}}{{$conf.Name}}:{{$conf.IPv4Address}} {{end}}')
        gateway=$(command docker network inspect "$id" --format '{{range .IPAM.Config}}{{.Gateway}}{{end}}')
        [ -z "$gateway" ] && gateway="no-gateway"
        
        printf "🌐 $name [$gateway]\n"
        
        if [ -n "$containers" ]; then
            for item in $containers; do
                c_name=$(echo "$item" | cut -d':' -f1)
                c_ip=$(echo "$item" | cut -d':' -f2)

                [ -z "$c_ip" ] && c_ip="host/none"

                printf "\t└── 📦 %-25s  %s\n" "$c_name" "$c_ip"
            done
        fi
        printf "\n"
    done
}
