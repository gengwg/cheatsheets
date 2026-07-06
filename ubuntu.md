## Packages

```
sudo apt install -y keepassxc
sudo apt install -y git
sudo apt install -y zsh
sudo apt install -y neovim 
sudo apt install -y rsync
sudo apt install -y xclip
sudo apt install -y tree
sudo apt install -y tmux
sudo apt install -y terminator
sudo apt install -y curl
sudo apt install -y gnome-tweaks
 
# optional
sudo apt install golang-go
# later version of go
sudo snap install go --classic
sudo apt install -y dnsutils
sudo apt install -y moreutils
sudo apt install -y file
sudo apt install -y at
sudo apt install -y parted
sudo apt install imagemagick
sudo apt install gimp
```

`setup-ubuntu.sh`:

```
#!/usr/bin/env bash
# Ubuntu 26.04 LTS (Resolute Raccoon) setup — translated from macOS Homebrew list
set -euo pipefail

sudo apt update

###############################################################################
## CLI applications — all available directly via apt
###############################################################################
sudo apt install -y \
  tty-clock \
  ddgr \
  trash-cli \
  ansible \
  jq \
  wget \
  curl \
  nmap \
  git \
  telnet \
  tmux \
  neovim \
  zoxide
# Notes:
# - `watch` is part of procps and already installed on Ubuntu.
# - apt's neovim can lag upstream; for latest: sudo snap install nvim --classic

# uv — not packaged in Ubuntu; use the official installer
curl -LsSf https://astral.sh/uv/install.sh | sh

###############################################################################
## AWS tools
###############################################################################
# awscli v2 — the apt package is v1/outdated; use snap (or AWS's zip installer)
sudo snap install aws-cli --classic

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
# kubectl — official Kubernetes apt repo (adjust v1.3x to the minor you want)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubectl

# kubectx + kubens — in the Ubuntu archive
sudo apt install -y kubectx

# podman — in the Ubuntu archive
sudo apt install -y podman

# helm - using snap
sudo snap install helm --classic

# kustomize — snap (also note: kubectl has `kubectl kustomize` built in)
sudo snap install kustomize

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
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg
echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
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

###############################################################################
## GUI applications
###############################################################################
# keepassxc — in the Ubuntu archive
sudo apt install -y keepassxc

# Docker: on Linux you usually want Docker Engine, not Docker Desktop.
# Docker Engine (recommended):
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "$USER"   # log out/in afterwards
# If Docker's repo doesn't list "resolute" yet, use "noble" as the codename.
# If you specifically want Docker Desktop, download the .deb from:
#   https://docs.docker.com/desktop/setup/install/linux/ubuntu/

echo "Done. Remember to: 1) restart your shell for uv/pipx/krew PATH changes, 2) re-login for the docker group."
```

### VS Code

https://code.visualstudio.com/docs/setup/linux

### Zoom

https://zoom.us/download?os=linux

### Syncthing

https://gengwg.medium.com/set-up-syncthing-on-ubuntu-b3c78668a23e

### Zsh

```
➜  ~ mv .zshrc .zshrc.orig
➜  ~ ln -s ./Nextcloud/bash_conf/zshrc .zshrc
➜  ~ ln -s ~/Nextcloud/bash_conf/aliases.zsh $ZSH_CUSTOM/aliases.zsh
```

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

    Open Tweaks → Keyboard.

    Click Additional Layout Options.

    Under Ctrl position, choose Caps Lock as Ctrl or Swap Ctrl and Caps Lock, depending on what you prefer.

This applies each time you log in and is the easiest option on default Ubuntu with GNOME.

### Option 2

```
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
```

needs a log out and log back in to take effect on Wayland. GNOME Wayland doesn't apply xkb-options to an already-running session.

```
-----------------------
Terminator shortcuts
------------------------
Split Terminal Horizontally - Ctrl+Shift+0
Split Terminal Vertically   - Ctrl+Shift+E
    Move Parent Dragbar Right - Ctrl+Shift+Right_Arrow_key
    Move Parent Dragbar Left - Ctrl+Shift+Left_Arrow_key
    Move Parent Dragbar Up - Ctrl+Shift+Up_Arrow_key
    Move Parent Dragbar Down - Ctrl+Shift+Down_Arrow_key
Hide/Show Scrollbar          - Ctrl+Shift+s

Move to Next Terminal        - Ctrl+Shift+N or Ctrl+Tab
Move to the Above Terminal - Alt+Up_Arrow_Key
Move to the Below Terminal - Alt+Down_Arrow_Key
Move to the Left Terminal - Alt+Left_Arrow_Key
Move to the Right Terminal - Alt+Right_Arrow_Key

Copy a text to clipboard - Ctrl+Shift+c
Paste a text from Clipboard - Ctrl+Shift+v
Close the Current Terminal - Ctrl+Shift+w
Quit the Terminator - Ctrl+Shift+q
Toggle Between Terminals - Ctrl+Shift+x
Open New Tab - Ctrl+Shift+t

Move to Next Tab - Ctrl+page_Down
Move to Previous Tab - Ctrl+Page_up
Increase Font size - Ctrl+(+)
Decrease Font Size - Ctrl+(-)
Reset Font Size to Original - Ctrl+0
Toggle Full Screen Mode - F11
Reset Terminal - Ctrl+Shift+R
Reset Terminal and Clear Window - Ctrl+Shift+G
Remove all the terminal grouping - Super+Shift+t
Group all Terminal into one - Super+g
Note: Super is a key with the windows logo right of left CTRL.
--------------------------------------------------------------------
```

## set screen blank time to 1hr (default 15m)

gsettings set org.gnome.desktop.session idle-delay 1800

## Motion (webcam)

Install:

```
sudo apt-get install motion
```

Edit `/etc/motion.conf`. Change:

```
target_dir /tmp/motion
```

to:

```
target_dir /var/www/motion
```

Organize files by date instead of all in one directory:

```
# Snapshots
snapshot_filename %Y%m%d/camera-%t/snapshots/hour-%H/camera-%t-%v-%Y%m%d%H%M%S-snapshot

# Motion-triggered images
jpeg_filename %Y%m%d/camera-%t/motions/hour-%H/camera-%t-%v-%Y%m%d%H%M%S-%q-motion

# Motion-triggered movies
movie_filename %Y%m%d/camera-%t/movies/hour-%H/camera-%t-%v-%Y%m%d%H%M%S-movie

# Timelapse
timelapse_filename %Y%m%d/camera-%t/timelapses/hour-%H/camera-%t-%Y%m%d-timelapse
```

Run:

```
sudo motion
/etc/init.d/motion restart
```


