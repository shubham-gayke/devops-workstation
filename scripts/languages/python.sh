#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_python() {

    if command -v python3 >/dev/null 2>&1; then
        log_warning "Python already installed."
        python3 --version
        pip3 --version
        return
    fi

    log_info "Installing Python..."

    sudo apt-get update

    sudo apt-get install -y \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev

    log_success "Python installed."

    python3 --version
    pip3 --version
}

install_python
