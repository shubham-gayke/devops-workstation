#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Run with sudo"
        exit 1
    fi
}
