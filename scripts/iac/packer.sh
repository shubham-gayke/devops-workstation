#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_packer() {

    if command -v packer >/dev/null 2>&1; then
        log_warning "Packer already installed."
        packer version
        return
    fi

    log_info "Installing Packer..."

    sudo apt-get install -y packer

    log_success "Packer installed."

    packer version
}

install_packer
