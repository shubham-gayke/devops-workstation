#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

log_info "Updating package lists..."

sudo apt-get update -y

sudo apt-get upgrade -y

log_success "System packages updated."
