#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_node_exporter() {

    if command -v prometheus-node-exporter >/dev/null 2>&1; then
        log_warning "Node Exporter already installed."
        prometheus-node-exporter --version | head -n 1
        return
    fi

    log_info "Installing Node Exporter..."

    sudo apt-get update

    sudo apt-get install -y prometheus-node-exporter

    sudo systemctl enable prometheus-node-exporter
    sudo systemctl start prometheus-node-exporter

    log_success "Node Exporter installed."

    prometheus-node-exporter --version | head -n 1
}

install_node_exporter
