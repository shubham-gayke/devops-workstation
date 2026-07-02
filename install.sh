#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$ROOT_DIR/scripts/common/core/colors.sh"
source "$ROOT_DIR/scripts/common/core/banner.sh"
source "$ROOT_DIR/scripts/common/core/logging.sh"

source "$ROOT_DIR/scripts/common/system/system.sh"
source "$ROOT_DIR/scripts/common/system/package.sh"
source "$ROOT_DIR/scripts/common/system/validator.sh"

show_banner

log_info "Starting DevOps Workstation Installation"

bash "$ROOT_DIR/scripts/linux/main.sh"

log_success "Installation Completed Successfully"
