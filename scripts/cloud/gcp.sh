#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_gcloud() {

    if command -v gcloud >/dev/null 2>&1; then
        log_warning "Google Cloud CLI already installed."
        gcloud version
        return
    fi

    log_info "Installing Google Cloud CLI..."

    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
        sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null

    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
        sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

    sudo apt-get update

    sudo apt-get install -y google-cloud-cli

    log_success "Google Cloud CLI installed."

    gcloud version
}

install_gcloud
