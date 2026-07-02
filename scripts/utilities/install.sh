#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"

source "$ROOT_DIR/scripts/common/bootstrap.sh"

log_info "Installing utility tools..."

sudo apt-get update

sudo apt-get install -y \
jq \
yq \
fzf \
ripgrep \
bat \
eza \
tmux \
zoxide \
tree \
htop \
ncdu \
fd-find \
zip \
unzip \
curl \
wget \
xclip \
dnsutils \
net-tools \
iputils-ping \
git

# -------------------------
# k9s
# -------------------------
if ! command -v k9s >/dev/null 2>&1; then
    curl -fsSL https://webinstall.dev/k9s | bash
    export PATH="$PATH:$HOME/.local/bin"
fi

# -------------------------
# kubectx / kubens
# -------------------------
if ! command -v kubectx >/dev/null 2>&1; then
    rm -rf /tmp/kubectx
    git clone https://github.com/ahmetb/kubectx.git /tmp/kubectx

    sudo install /tmp/kubectx/kubectx /usr/local/bin/kubectx
    sudo install /tmp/kubectx/kubens /usr/local/bin/kubens

    rm -rf /tmp/kubectx
fi

# -------------------------
# lazydocker
# -------------------------
if ! command -v lazydocker >/dev/null 2>&1; then
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

echo
echo "========================================="
echo " Utility tools installation completed"
echo "========================================="
echo

for cmd in \
jq \
yq \
fzf \
rg \
batcat \
eza \
tmux \
zoxide \
tree \
htop \
ncdu \
fdfind \
kubectx \
kubens \
k9s \
lazydocker
do
    if command -v "$cmd" >/dev/null 2>&1; then
        printf "✔ %-12s installed\n" "$cmd"
    else
        printf "✘ %-12s not found\n" "$cmd"
    fi
done

