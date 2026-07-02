#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_tomcat() {

    if command -v catalina.sh >/dev/null 2>&1 || [ -d /usr/share/tomcat10 ]; then
        log_warning "Tomcat already installed."
        return
    fi

    log_info "Installing Apache Tomcat..."

    sudo apt-get update

    sudo apt-get install -y tomcat10

    sudo systemctl enable tomcat10
    sudo systemctl start tomcat10

    log_success "Tomcat installed."

    systemctl --no-pager --lines=0 status tomcat10
}

install_tomcat
