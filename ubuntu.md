## setup-ubuntu.sh

```
#!/usr/bin/env bash
# Ubuntu 26.04 LTS (Resolute Raccoon) setup 
set -euo pipefail

sudo apt install -y curl

# Kubernetes repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list

# HashiCorp repo
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/hashicorp.gpg
echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update

###############################################################################
## applications — all available directly via apt
###############################################################################
sudo apt install -y \
  git \
  zsh \
  rsync \
  xclip \
  tree \
  tmux \
  tmuxp \
  tty-clock \
  ddgr \
  trash-cli \
  ansible \
  ansible-lint \
  jq \
  wget \
  nmap \
  telnet \
  zoxide \
  dnsutils \
  moreutils \
  file \
  at \
  gnome-network-displays \
  parted \
  imagemagick \
  keepassxc \
  gnome-tweaks \
  terminator \
  yq \
  nodejs \
  grim \
  npm \
  gnome-tweaks \
  sqlite3 \
  net-tools \
  libsecret-tools \
  mtr-tiny \
  gimp

# Zoom Linux client
wget -P /tmp https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install /tmp/zoom_amd64.deb

# uv — not packaged in Ubuntu; use the official installer
curl -LsSf https://astral.sh/uv/install.sh | sh

###############################################################################
## AWS tools
###############################################################################
# awsume — Python tool, install via pipx
sudo apt install -y pipx
pipx ensurepath
pipx install awsume

# granted (common-fate) — Linux tarball from GitHub releases
GRANTED_VERSION="0.36.1"  # check https://github.com/common-fate/granted/releases
curl -fsSLo /tmp/granted.tar.gz \
  "https://releases.commonfate.io/granted/v${GRANTED_VERSION}/granted_${GRANTED_VERSION}_linux_x86_64.tar.gz" \
  || echo "Check the latest granted release URL manually"
sudo tar -xzf /tmp/granted.tar.gz -C /usr/local/bin granted assumego assume assume.fish

###############################################################################
## Kubernetes tools
###############################################################################
# kubectl
sudo apt install -y kubectl

# kubectx + kubens — in the Ubuntu archive
sudo apt install -y kubectx

# podman — in the Ubuntu archive
sudo apt install -y podman

# k9s — .deb from GitHub releases
curl -fsSLo /tmp/k9s.deb \
  "https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb"
sudo apt install -y /tmp/k9s.deb

# clusterctl — binary from releases
curl -fsSLo /tmp/clusterctl \
  "https://github.com/kubernetes-sigs/cluster-api/releases/latest/download/clusterctl-linux-amd64"
sudo install -m 0755 /tmp/clusterctl /usr/local/bin/clusterctl

# kubeconform — replacement for kubeval (kubeval is archived/deprecated)
curl -fsSL "https://github.com/yannh/kubeconform/releases/latest/download/kubeconform-linux-amd64.tar.gz" \
  | sudo tar -xz -C /usr/local/bin kubeconform

# NOTE: octant was archived by VMware and is no longer maintained.
# Consider Headlamp (https://headlamp.dev) or Lens as a replacement, or rely on k9s.

# NOTE: colima is not needed on Linux — it exists to run a Linux VM on macOS.
# Docker/podman run natively here.

###############################################################################
## k8s test environments
###############################################################################
# kind — binary from releases
curl -fsSLo /tmp/kind \
  "https://github.com/kubernetes-sigs/kind/releases/latest/download/kind-linux-amd64"
sudo install -m 0755 /tmp/kind /usr/local/bin/kind

# minikube — official .deb
curl -fsSLo /tmp/minikube.deb \
  "https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb"
sudo apt install -y /tmp/minikube.deb

###############################################################################
## k8s operator / API build tools
###############################################################################
# kubebuilder — binary from releases
curl -fsSLo /tmp/kubebuilder \
  "https://github.com/kubernetes-sigs/kubebuilder/releases/latest/download/kubebuilder_linux_amd64"
sudo install -m 0755 /tmp/kubebuilder /usr/local/bin/kubebuilder

# tilt — official install script
curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash

###############################################################################
## Terraform — HashiCorp official apt repo
###############################################################################
sudo apt install -y terraform
# If HashiCorp hasn't added "resolute" yet, substitute the previous LTS codename:
# echo "deb [...] https://apt.releases.hashicorp.com noble main"

###############################################################################
## krew (kubectl plugin manager) — official install method
###############################################################################
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
# Add to your shell rc (~/.bashrc or ~/.zshrc):
#   export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew update
kubectl krew install access-matrix

# https://docs.cilium.io/en/stable/gettingstarted/k8s-install-default/#install-the-cilium-cli
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

# argocd — CLI from GitHub releases
# https://argo-cd.readthedocs.io/en/stable/cli_installation/
VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64


###############################################################################
## Docker
###############################################################################
# Docker: on Linux you usually want Docker Engine, not Docker Desktop.
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"   # log out/in afterwards
# If Docker's repo doesn't list "resolute" yet, use "noble" as the codename.
# If you specifically want Docker Desktop, download the .deb from:
#   https://docs.docker.com/desktop/setup/install/linux/ubuntu/

###############################################################################
## Snaps
#      Snaps auto-refresh ~4x per day.                                                                                                          
###############################################################################
# strict confinement
for snap in spotify notion-desktop libreoffice proton-pass doctl slack; do
  sudo snap install "$snap"
done

# classic confinement
for snap in go aws-cli helm kustomize codium nvim discord gh; do
  sudo snap install "$snap" --classic
done

# Snap glab doesn't work well with claude. also stores secrets as plaintext in snap.
# Apt glab version is too old.
curl -L -o /tmp/glab.deb https://gitlab.com/gitlab-org/cli/-/releases/v1.113.0/downloads/glab_1.113.0_linux_amd64.deb
sudo dpkg -i /tmp/glab.deb
glab auth login

# set screen blank time to 1hr (default 15m)
gsettings set org.gnome.desktop.session idle-delay 3600

echo "Done. Remember to: 1) restart your shell for uv/pipx/krew PATH changes, 2) re-login for the docker group."
```

### Syncthing

https://gengwg.medium.com/set-up-syncthing-on-ubuntu-b3c78668a23e

### Configure Zsh

```
➜  ~ mv .zshrc .zshrc.orig
➜  ~ ln -s ./Nextcloud/bash_conf/zshrc .zshrc
➜  ~ ln -s ~/Nextcloud/bash_conf/aliases.zsh $ZSH_CUSTOM/aliases.zsh
```

### Configure Terminator

https://github.com/gengwg/terminator

## Ubuntu 22.04 Chinese (simplified) pinyin input

https://askubuntu.com/questions/1408873/ubuntu-22-04-chinese-simplified-pinyin-input-support

    Open Settings, go to Region & Language -> Manage Installed Languages -> Install / Remove languages.
    Select Chinese (Simplified). Make sure Keyboard Input method system has Ibus selected. Apply.
    Reboot (please don't think "this isn't necessary", just do it or you will waste more precious time!)
    Log back in, reopen Settings, go to Keyboard.
    Click on the "+" sign under Input sources.
    Select Chinese (China) and then Chinese (Intelligent Pinyin).

If you see there is zh in the upper right in Ubuntu, input with that it is English.
--> uninstall it and reinstall it. 
Click on 'Chinese', now you will have the option to chose "Chinese (Intelligent pinyin)".
You should get a "拼" rather than "zh".

https://gengwg.medium.com/ubuntu-22-04-chinese-simplified-pinyin-input-6d193d572669

## Turn Caps into Ctrl in GNOME

Install Tweaks:

    sudo apt install gnome-tweaks

Then:

    Open Tweaks → Keyboard.
    Click Additional Layout Options.
    Under Ctrl position, choose Caps Lock as Ctrl.

This applies each time you log in and is the easiest option on default Ubuntu with GNOME.

### Option 2

```
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
```

needs a log out and log back in to take effect on Wayland. GNOME Wayland doesn't apply xkb-options to an already-running session.
