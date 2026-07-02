#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/../core/logging.sh"

install_package() {
    local package="$1"

    if dpkg -s "$package" >/dev/null 2>&1; then
        log_success "$package already installed"
    else
        log_info "Installing $package"
        sudo apt-get install -y "$package"
    fi
}
