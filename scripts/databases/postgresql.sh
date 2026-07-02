#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_postgresql() {

    if command -v psql >/dev/null 2>&1; then
        log_warning "PostgreSQL already installed."
        psql --version
        return
    fi

    log_info "Installing PostgreSQL..."

    sudo apt-get update

    sudo apt-get install -y \
        postgresql \
        postgresql-contrib

    sudo systemctl enable postgresql
    sudo systemctl start postgresql

    log_success "PostgreSQL installed."

    psql --version
}

install_postgresql
