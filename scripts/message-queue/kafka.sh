#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

install_kafka() {

    if [ -d "/opt/kafka" ]; then
        log_warning "Kafka already installed."
        /opt/kafka/bin/kafka-topics.sh --version
        return
    fi

    log_info "Installing Apache Kafka..."

    sudo apt-get update
    sudo apt-get install -y wget tar

    cd /tmp

    wget -q https://downloads.apache.org/kafka/4.1.0/kafka_2.13-4.1.0.tgz

    sudo tar -xzf kafka_2.13-4.1.0.tgz -C /opt

    sudo mv /opt/kafka_2.13-4.1.0 /opt/kafka

    log_success "Kafka installed."

    /opt/kafka/bin/kafka-topics.sh --version
}

install_kafka
