#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_mysql() {

    if command -v mysql >/dev/null 2>&1; then
        log_warning "MySQL already installed."
        mysql --version
        return
    fi

    log_info "Installing MySQL Server..."

    sudo apt-get update

    sudo apt-get install -y \
        mysql-server \
        mysql-client

    sudo systemctl enable mysql
    sudo systemctl start mysql

    log_success "MySQL installed."

    mysql --version
}

install_mysql
