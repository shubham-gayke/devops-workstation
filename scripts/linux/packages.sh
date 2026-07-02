#!/usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/core/colors.sh"
source "$ROOT_DIR/scripts/common/core/logging.sh"
source "$ROOT_DIR/scripts/common/system/system.sh"

update_packages() {
    log_info "Updating package lists..."

    sudo apt-get update -y

    log_success "Package lists updated."
}

install_base_packages() {

    log_info "Installing base packages..."

    sudo apt-get install -y \
        curl \
        wget \
        git \
        unzip \
        zip \
        tar \
        gzip \
        bzip2 \
        xz-utils \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        jq \
        tree \
        htop \
        vim \
        nano \
        tmux \
        make \
        gcc \
        g++ \
        build-essential \
        pkg-config \
        openssl \
        net-tools \
        dnsutils \
        iputils-ping \
        traceroute \
        telnet \
        rsync \
        acl \
        sudo

    log_success "Base packages installed."
}
