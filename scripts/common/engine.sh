#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

run_step() {
    local title="$1"
    local script="$2"

    log_info "$title"

    if [[ -f "$script" ]]; then
        bash "$script"
    else
        log_warning "Missing: $script"
    fi
}
