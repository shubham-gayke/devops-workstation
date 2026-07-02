#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_java() {

    if command -v java >/dev/null 2>&1; then
        log_warning "Java already installed."
        java -version
        return
    fi

    log_info "Installing Eclipse Temurin JDK 21..."

    sudo mkdir -p /etc/apt/keyrings

    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | \
        sudo gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg

    echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release) main" | \
        sudo tee /etc/apt/sources.list.d/adoptium.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y temurin-21-jdk

    log_success "Java installed."

    java -version
    javac -version
}

install_java
