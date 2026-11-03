#!/usr/bin/env sh

overview_networks() {

    if ! command -v docker > /dev/null 2>&1; then
        printf "\t[ERROR] Docker is not installed or not in PATH\n"
        return 1
    fi

    printf "\n%-25s %-15s %-40s %-18s\n" "CONTAINER NAME" "CONTAINER IP" "NETWORK NAME" "NETWORK SUBNET"


    command docker container ps --filter "status=running" --format "{{.ID}}\t{{.Names}}" | while read -r id name; do
        
        command docker container inspect "$id" --format '{{range $net, $conf := .NetworkSettings.Networks}}{{$net}} {{end}}' | tr ' ' '\n' | while read -r net_name; do
            
            [ -z "$net_name" ] && continue

            container_ip=$(command docker container inspect "$id" --format "{{(index .NetworkSettings.Networks \"$net_name\").IPAddress}}")
            [ -z "$container_ip" ] && container_ip="host/none"

            net_subnet=$(command docker network inspect "$net_name" --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}' 2>/dev/null)
            [ -z "$net_subnet" ] && net_subnet="no-subnet"

            printf "%-25s %-15s %-40s %-18s\n" "$name" "$container_ip" "$net_name" "$net_subnet"
        done
    done
    
}
