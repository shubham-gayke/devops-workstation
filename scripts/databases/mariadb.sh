#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_mariadb() {

    if command -v mariadb >/dev/null 2>&1 || command -v mysql >/dev/null 2>&1; then
        log_warning "MariaDB already installed."
        mariadb --version 2>/dev/null || mysql --version
        return
    fi

    log_info "Installing MariaDB..."

    sudo apt-get update

    sudo apt-get install -y \
        mariadb-server \
        mariadb-client

    sudo systemctl enable mariadb
    sudo systemctl start mariadb

    log_success "MariaDB installed."

    mariadb --version 2>/dev/null || mysql --version
}

install_mariadb
