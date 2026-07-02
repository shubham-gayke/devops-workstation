#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_elasticsearch() {

    if command -v elasticsearch >/dev/null 2>&1; then
        log_warning "Elasticsearch already installed."
        elasticsearch --version
        return
    fi

    log_info "Installing Elasticsearch..."

    curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | \
        sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/9.x/apt stable main" | \
        sudo tee /etc/apt/sources.list.d/elastic-9.x.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y elasticsearch

    sudo systemctl daemon-reload
    sudo systemctl enable elasticsearch
    sudo systemctl start elasticsearch

    log_success "Elasticsearch installed."

    elasticsearch --version
}

install_elasticsearch
