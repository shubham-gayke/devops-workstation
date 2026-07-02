#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_nats() {

    if command -v nats-server >/dev/null 2>&1; then
        log_warning "NATS Server already installed."
        nats-server --version
        return
    fi

    log_info "Installing NATS Server..."

    sudo apt-get update

    sudo apt-get install -y nats-server

    sudo systemctl enable nats-server
    sudo systemctl start nats-server

    log_success "NATS Server installed."

    nats-server --version
}

install_nats
