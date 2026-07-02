#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_rabbitmq() {

    if command -v rabbitmqctl >/dev/null 2>&1; then
        log_warning "RabbitMQ already installed."
        rabbitmqctl version
        return
    fi

    log_info "Installing RabbitMQ..."

    sudo apt-get update

    sudo apt-get install -y rabbitmq-server

    sudo systemctl enable rabbitmq-server
    sudo systemctl start rabbitmq-server

    log_success "RabbitMQ installed."

    rabbitmqctl version
}

install_rabbitmq
