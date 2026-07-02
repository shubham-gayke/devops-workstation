#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

source "$ROOT_DIR/scripts/common/core/logging.sh"

log_info "Updating package lists"
bash "$ROOT_DIR/scripts/linux/packages.sh"

log_info "Installing Cloud Tools"
bash "$ROOT_DIR/scripts/linux/cloud.sh"

log_info "Installing Programming Languages"
bash "$ROOT_DIR/scripts/linux/languages.sh"

log_info "Installing Databases"
bash "$ROOT_DIR/scripts/linux/databases.sh"

log_info "Installing Monitoring"
bash "$ROOT_DIR/scripts/linux/monitoring.sh"

log_info "Installing Web Servers"
bash "$ROOT_DIR/scripts/linux/webserver.sh"

log_info "Installing Security Tools"
bash "$ROOT_DIR/scripts/linux/security.sh"

log_info "Installing Utilities"
bash "$ROOT_DIR/scripts/linux/utilities.sh"

bash "$ROOT_DIR/scripts/linux/finalize.sh"
