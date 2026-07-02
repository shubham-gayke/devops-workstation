#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_gitlab_cli() {

    if command -v glab >/dev/null 2>&1; then
        log_warning "GitLab CLI already installed."
        glab version
        return
    fi

    log_info "Installing GitLab CLI..."

    curl -fsSL https://packages.gitlab.com/gpg.key | \
        sudo gpg --dearmor -o /usr/share/keyrings/gitlab-glab.gpg

    echo "deb [signed-by=/usr/share/keyrings/gitlab-glab.gpg] https://packages.gitlab.com/runner/gitlab-runner/ubuntu/ $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/gitlab-runner.list >/dev/null

    curl -s https://raw.githubusercontent.com/profclems/glab/trunk/scripts/install.sh | sudo bash

    log_success "GitLab CLI installed."

    glab version
}

install_gitlab_cli
