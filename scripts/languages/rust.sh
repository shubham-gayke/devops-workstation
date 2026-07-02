#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_rust() {

    if command -v rustc >/dev/null 2>&1; then
        log_warning "Rust already installed."
        rustc --version
        cargo --version
        return
    fi

    log_info "Installing Rust..."

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- -y

    source "$HOME/.cargo/env"

    log_success "Rust installed."

    rustc --version
    cargo --version
}

install_rust
