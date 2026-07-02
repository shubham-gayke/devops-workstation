#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$ROOT_DIR/scripts/common/engine.sh"

show_banner

run_step "Updating package lists" \
"$ROOT_DIR/scripts/linux/update.sh"

run_step "Installing base packages" \
"$ROOT_DIR/scripts/linux/packages.sh"

run_step "Installing Git" \
"$ROOT_DIR/scripts/git/git.sh"

run_step "Installing Docker" \
"$ROOT_DIR/scripts/docker/install.sh"

run_step "Installing Kubernetes" \
"$ROOT_DIR/scripts/kubernetes/install.sh"

run_step "Installing Cloud CLIs" \
"$ROOT_DIR/scripts/linux/cloud.sh"

run_step "Installing Programming Languages" \
"$ROOT_DIR/scripts/linux/languages.sh"

run_step "Installing Databases" \
"$ROOT_DIR/scripts/linux/databases.sh"

run_step "Installing Monitoring Stack" \
"$ROOT_DIR/scripts/linux/monitoring.sh"

run_step "Installing Web Servers" \
"$ROOT_DIR/scripts/linux/webserver.sh"

run_step "Installing Security Tools" \
"$ROOT_DIR/scripts/linux/security.sh"

run_step "Installing Utilities" \
"$ROOT_DIR/scripts/linux/utilities.sh"

run_step "Finalizing Installation" \
"$ROOT_DIR/scripts/linux/finalize.sh"

log_success "DevOps Workstation installation completed."
