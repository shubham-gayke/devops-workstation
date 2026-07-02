#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

log() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

log "Installing Kubernetes tools..."

bash "$ROOT_DIR/scripts/kubernetes/kubectl.sh"

bash "$ROOT_DIR/scripts/kubernetes/helm.sh"

bash "$ROOT_DIR/scripts/kubernetes/kind.sh"

echo
echo "=================================="
echo " Kubernetes Installation Complete "
echo "=================================="
