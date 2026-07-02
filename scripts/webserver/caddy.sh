#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_caddy() {

    if command -v caddy >/dev/null 2>&1; then
        log_warning "Caddy already installed."
        caddy version
        return
    fi

    log_info "Installing Caddy..."

    sudo apt-get update

    sudo apt-get install -y caddy

    sudo systemctl enable caddy
    sudo systemctl start caddy

    log_success "Caddy installed."

    caddy version
}

install_caddy
