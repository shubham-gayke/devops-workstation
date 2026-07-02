#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_grafana() {

    if command -v grafana-server >/dev/null 2>&1; then
        log_warning "Grafana already installed."
        grafana-server -v | head -n 1
        return
    fi

    log_info "Installing Grafana..."

    sudo mkdir -p /etc/apt/keyrings

    wget -q -O - https://apt.grafana.com/gpg.key | \
        sudo gpg --dearmor -o /etc/apt/keyrings/grafana.gpg

    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | \
        sudo tee /etc/apt/sources.list.d/grafana.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y grafana

    sudo systemctl enable grafana-server
    sudo systemctl start grafana-server

    log_success "Grafana installed."

    grafana-server -v | head -n 1
}

install_grafana
