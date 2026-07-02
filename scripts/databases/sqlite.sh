#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_sqlite() {

    if command -v sqlite3 >/dev/null 2>&1; then
        log_warning "SQLite already installed."
        sqlite3 --version
        return
    fi

    log_info "Installing SQLite..."

    sudo apt-get update

    sudo apt-get install -y \
        sqlite3 \
        libsqlite3-dev

    log_success "SQLite installed."

    sqlite3 --version
}

install_sqlite
