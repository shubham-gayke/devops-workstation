#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_apache() {

    if command -v apache2 >/dev/null 2>&1; then
        log_warning "Apache already installed."
        apache2 -v | head -n 1
        return
    fi

    log_info "Installing Apache HTTP Server..."

    sudo apt-get update

    sudo apt-get install -y apache2

    sudo systemctl enable apache2
    sudo systemctl start apache2

    log_success "Apache installed."

    apache2 -v | head -n 1
}

install_apache
