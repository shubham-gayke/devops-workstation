#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_ansible() {

    if command -v ansible >/dev/null 2>&1; then
        log_warning "Ansible already installed."
        ansible --version | head -n 1
        return
    fi

    log_info "Installing Ansible..."

    sudo apt-get update

    sudo apt-get install -y ansible

    log_success "Ansible installed."

    ansible --version | head -n 1
}

install_ansible
