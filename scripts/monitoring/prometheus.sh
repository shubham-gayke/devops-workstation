#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_prometheus() {

    if command -v prometheus >/dev/null 2>&1; then
        log_warning "Prometheus already installed."
        prometheus --version | head -n 1
        return
    fi

    log_info "Installing Prometheus..."

    sudo apt-get update

    sudo apt-get install -y prometheus

    sudo systemctl enable prometheus
    sudo systemctl start prometheus

    log_success "Prometheus installed."

    prometheus --version | head -n 1
}

install_prometheus
