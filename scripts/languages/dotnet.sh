#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_dotnet() {

    if command -v dotnet >/dev/null 2>&1; then
        log_warning ".NET SDK already installed."
        dotnet --version
        return
    fi

    log_info "Installing .NET SDK 8 LTS..."

    source /etc/os-release

    wget https://packages.microsoft.com/config/ubuntu/${VERSION_ID}/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb

    sudo dpkg -i /tmp/packages-microsoft-prod.deb

    rm /tmp/packages-microsoft-prod.deb

    sudo apt-get update

    sudo apt-get install -y dotnet-sdk-8.0

    log_success ".NET SDK installed."

    dotnet --version
}

install_dotnet
