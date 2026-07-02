#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_helm() {

    if command -v helm >/dev/null 2>&1; then
        log_warning "Helm already installed."
        helm version
        return
    fi

    log_info "Installing Helm..."

    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    log_success "Helm installed."

    helm version
}

install_helm
