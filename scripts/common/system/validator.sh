#!/usr/bin/env bash

validate_os() {
    grep -qi ubuntu /etc/os-release
}

validate_network() {
    ping -c 1 google.com >/dev/null 2>&1
}
