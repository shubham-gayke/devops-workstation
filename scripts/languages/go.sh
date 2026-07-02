#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_go() {

    if command -v go >/dev/null 2>&1; then
        log_warning "Go already installed."
        go version
        return
    fi

    log_info "Installing Go..."

    GO_VERSION="1.25.1"

    cd /tmp

    wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz

    sudo rm -rf /usr/local/go

    sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

    rm go${GO_VERSION}.linux-amd64.tar.gz

    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    fi

    export PATH=$PATH:/usr/local/go/bin

    log_success "Go installed."

    go version
}

install_go
