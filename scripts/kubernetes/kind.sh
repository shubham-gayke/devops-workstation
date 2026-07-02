#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_kind() {

    if command -v kind >/dev/null 2>&1; then
        log_warning "Kind already installed."
        kind version
        return
    fi

    log_info "Installing Kind..."

    curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64

    chmod +x ./kind

    sudo mv ./kind /usr/local/bin/kind

    log_success "Kind installed."

    kind version
}

install_kind
