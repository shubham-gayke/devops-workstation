
#!/usr/bin/env bash

#############################################
# colors.sh
# ANSI Color & Output Library
#############################################

# ---------- RESET ----------

RESET="\033[0m"

# ---------- REGULAR COLORS ----------

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

# ---------- BOLD COLORS ----------

BOLD="\033[1m"
BOLD_RED="\033[1;31m"
BOLD_GREEN="\033[1;32m"
BOLD_YELLOW="\033[1;33m"
BOLD_BLUE="\033[1;34m"
BOLD_MAGENTA="\033[1;35m"
BOLD_CYAN="\033[1;36m"

#############################################
# PRINT FUNCTIONS
#############################################

info() {
    echo -e "${BLUE}[INFO]${RESET} $*"
}

success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $*"
}

warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $*"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $*" >&2
}

debug() {
    echo -e "${CYAN}[DEBUG]${RESET} $*"
}

#############################################
# HEADERS
#############################################

title() {

    echo
    echo -e "${BOLD_MAGENTA}==============================================================${RESET}"
    echo -e "${BOLD_MAGENTA}$*${RESET}"
    echo -e "${BOLD_MAGENTA}==============================================================${RESET}"
    echo
}

section() {

    echo
    echo -e "${BOLD_CYAN}---- $* ----${RESET}"
}

#############################################
# STATUS SYMBOLS
#############################################

tick() {

    echo -e "${GREEN}✔${RESET} $*"
}

cross() {

    echo -e "${RED}✘${RESET} $*"
}

arrow() {

    echo -e "${CYAN}➜${RESET} $*"
}
