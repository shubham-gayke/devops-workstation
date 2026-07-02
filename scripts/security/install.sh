#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

export PATH="$PATH:$HOME/go/bin:$HOME/.local/bin"

log_info "Installing Security Tools..."

# --------------------------------------------------
# Trivy
# --------------------------------------------------
if ! command -v trivy >/dev/null 2>&1; then

    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key \
        | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg

    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" \
        | sudo tee /etc/apt/sources.list.d/trivy.list >/dev/null

    sudo apt-get update
    sudo apt-get install -y trivy

else
    log_info "Trivy already installed."
fi

# --------------------------------------------------
# Gitleaks
# --------------------------------------------------
if ! command -v gitleaks >/dev/null 2>&1; then

    go install github.com/zricethezav/gitleaks/v8@latest

    export PATH="$PATH:$HOME/go/bin"

else
    log_info "Gitleaks already installed."
fi

# --------------------------------------------------
# Checkov
# --------------------------------------------------
if ! command -v checkov >/dev/null 2>&1; then

    sudo apt-get update

    sudo apt-get install -y pipx

    pipx ensurepath

    pipx install checkov

else
    log_info "Checkov already installed."
fi

# --------------------------------------------------
# tfsec
# --------------------------------------------------
if ! command -v tfsec >/dev/null 2>&1; then

    go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

    export PATH="$PATH:$HOME/go/bin"

else
    log_info "tfsec already installed."
fi

# --------------------------------------------------
# Lynis
# --------------------------------------------------
if ! command -v lynis >/dev/null 2>&1; then

    sudo apt-get update

    sudo apt-get install -y lynis

else
    log_info "Lynis already installed."
fi

echo
echo "=========================================="
echo " Security Tools Installation Completed"
echo "=========================================="
echo

command -v trivy >/dev/null 2>&1 && trivy --version || true
command -v gitleaks >/dev/null 2>&1 && gitleaks version || true
command -v checkov >/dev/null 2>&1 && checkov --version || true
command -v tfsec >/dev/null 2>&1 && tfsec --version || true
command -v lynis >/dev/null 2>&1 && lynis show version || true

