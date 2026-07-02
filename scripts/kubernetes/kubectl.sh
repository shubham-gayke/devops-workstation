#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/core/colors.sh"
source "$ROOT_DIR/scripts/common/core/logging.sh"
source "$ROOT_DIR/scripts/common/system/system.sh"

install_kubectl() {

    if command_exists kubectl; then
        log_warning "kubectl already installed."
        kubectl version --client
        return
    fi

    log_info "Installing kubectl..."

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | \
        sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /" | \
        sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null

    sudo apt-get update

    sudo apt-get install -y kubectl

    log_success "kubectl installed successfully."

}
#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_kubectl() {

    if command -v kubectl >/dev/null 2>&1; then
        log_warning "kubectl already installed."
        kubectl version --client
        return
    fi

    log_info "Installing kubectl..."

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x kubectl

    sudo mv kubectl /usr/local/bin/

    log_success "kubectl installed."

    kubectl version --client
}

install_kubectl
