#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_opentofu() {

    if command -v tofu >/dev/null 2>&1; then
        log_warning "OpenTofu already installed."
        tofu version
        return
    fi

    log_info "Installing OpenTofu..."

    curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh | sh

    log_success "OpenTofu installed."

    tofu version
}

install_opentofu
