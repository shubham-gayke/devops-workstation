#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_redis() {

    if command -v redis-server >/dev/null 2>&1; then
        log_warning "Redis already installed."
        redis-server --version
        return
    fi

    log_info "Installing Redis..."

    sudo apt-get update

    sudo apt-get install -y redis-server

    sudo systemctl enable redis-server
    sudo systemctl start redis-server

    log_success "Redis installed."

    redis-server --version
}

install_redis
