#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_aws() {

    if command -v aws >/dev/null 2>&1; then
        log_warning "AWS CLI already installed."
        aws --version
        return
    fi

    log_info "Installing AWS CLI..."

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

    unzip -q awscliv2.zip

    sudo ./aws/install

    rm -rf aws awscliv2.zip

    log_success "AWS CLI installed."

    aws --version
}

install_aws
