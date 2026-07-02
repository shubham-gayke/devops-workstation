#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_mongodb() {

    if command -v mongod >/dev/null 2>&1; then
        log_warning "MongoDB already installed."
        mongod --version | head -n 1
        return
    fi

    log_info "Installing MongoDB Community Edition..."

    curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
        sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
        --dearmor

    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
        sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y mongodb-org

    sudo systemctl enable mongod
    sudo systemctl start mongod

    log_success "MongoDB installed."

    mongod --version | head -n 1
}

install_mongodb
