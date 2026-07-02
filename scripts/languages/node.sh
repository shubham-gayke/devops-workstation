#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_node() {

    if command -v node >/dev/null 2>&1; then
        log_warning "Node.js already installed."
        node -v
        npm -v
        return
    fi

    log_info "Installing Node.js LTS..."

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
        sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" | \
        sudo tee /etc/apt/sources.list.d/nodesource.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y nodejs

    log_success "Node.js installed."

    node -v
    npm -v
}

install_node
