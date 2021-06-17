#!/bin/bash
set -euo pipefail

echo "Setting up docker..."

mkdir -p /data/docker /etc/docker

my_cidr=$(getent hosts fly-local-6pn | cut -d ' ' -f1 | awk -F: '{print $1":"$2":"$3"::/64"}')

echo '{"data-root": "/data/docker",
  "ipv6": true, 
  "fixed-cidr-v6": "'$my_cidr'",
  "insecure-registries": ["'$DOCKER_REPOSITORY'"]
}' > /etc/docker/daemon.json

exec /init