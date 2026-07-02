#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

verify_docker() {

    log_info "Verifying Docker..."

    docker --version
    docker compose version

    if docker info >/dev/null 2>&1; then
        log_success "Docker is working."
    else
        log_error "Docker is not running."
        exit 1
    fi
}

verify_docker
