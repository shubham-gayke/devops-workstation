#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

log_info "Verifying Kubernetes tools..."

kubectl version --client

helm version

kind version

log_success "All Kubernetes tools are installed."
