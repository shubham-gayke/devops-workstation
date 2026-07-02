#!/usr/bin/env bash

##################################################
# loader.sh
# Loads all common framework modules
##################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- Core ----------

source "$SCRIPT_DIR/core/colors.sh"
source "$SCRIPT_DIR/core/logging.sh"
source "$SCRIPT_DIR/core/banner.sh"

# ---------- System ----------

source "$SCRIPT_DIR/system/system.sh"
source "$SCRIPT_DIR/system/package.sh"
source "$SCRIPT_DIR/system/validator.sh"

# ---------- Utils ----------

source "$SCRIPT_DIR/utils/utils.sh"
