#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_nginx() {

    if command -v nginx >/dev/null 2>&1; then
        log_warning "Nginx already installed."
        nginx -v
        return
    fi

    log_info "Installing Nginx..."

    sudo apt-get update

    sudo apt-get install -y nginx

    sudo systemctl enable nginx
    sudo systemctl start nginx

    log_success "Nginx installed."

    nginx -v
}

install_nginx
