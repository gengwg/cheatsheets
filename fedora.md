# Fedora Setup

```
$ cat /etc/fedora-release 
Fedora release 32 (Thirty Two)
```

## Set up Wifi Dongle

```sh

# for debian
# sudo apt-get install build-essential dkms

$ sudo dnf groupinstall "Development Tools"
$ git clone https://github.com/gnab/rtl8812au.git
$ sudo dkms add ./rtl8812au

Creating symlink /var/lib/dkms/8812au/4.2.2/source ->
                 /usr/src/8812au-4.2.2

DKMS: add completed.

# build the module
$ sudo dkms build 8812au/4.2.2
Kernel preparation unnecessary for this kernel.  Skipping...

Building module:
cleaning build area...
'make' all KVER=5.7.17-200.fc32.x86_64..................
cleaning build area...

DKMS: build completed.

# install the module 
$ sudo dkms install 8812au/4.2.2

8812au.ko.xz:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/5.7.17-200.fc32.x86_64/extra/
Adding any weak-modules

depmod....

DKMS: install completed.

# Load the driver
$ sudo modprobe 8812au
```

Now your Wifi dongle should work and you can use it to connect to your wifi network in Network Manager.

## Install Packages

```
sudo dnf groupinstall "Development Tools"
sudo dnf install gnome-tweaks
sudo dnf install keepassx
sudo dnf install ansible
sudo dnf install ruby
sudo dnf install lm_sensors
sudo dnf install trash-cli
sudo dnf install golang
```

### Install Microsoft VS Code

https://code.visualstudio.com/docs/setup/linux


### Install Docker

```
$ sudo dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo
$ sudo dnf install docker-ce
$ sudo systemctl enable --now docker
```

#### Run docker as normal user

```
$ docker ps
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.39/containers/json: dial unix /var/run/docker.sock: connect: permission denied
```

===>

```
sudo usermod -aG docker $USER
```

Then log out and log in again.

### Revert back to cgroup v1

```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
0e03bdcc26d7: Pull complete
Digest: sha256:4cf9c47f86df71d48364001ede3a4fcd85ae80ce02ebad74156906caff5378bc
Status: Downloaded newer image for hello-world:latest
docker: Error response from daemon: cgroups: cgroup mountpoint does not exist: unknown.
ERRO[0025] error waiting for container: context canceled
```

===>

Docker requires cgroups v1, and Fedora 31 uses cgroups v2.

Revert back to cgroup v1. Please consider whether this step does not negatively affect your any of the other services running on your system: 

```
$ sudo dnf install -y grubby
$ sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
$ sudo reboot
```

### Install VirtualBox

#### Install Dependencies

```
$ sudo dnf -y upgrade
$ sudo dnf -y install @development-tools
$ sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
```

#### Enabling the RPM Fusion repositories

```
sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

#### Install VirtualBox and guest additions

```
$ sudo dnf install VirtualBox
$ sudo dnf install virtualbox-guest-additions
```

Try starting:
```
$ virtualbox
WARNING: The vboxdrv kernel module is not loaded. Either there is no module
         available for the current kernel (5.14.16-201.fc34.x86_64) or it failed to
         load. Please try load the kernel module by executing as root

           dnf install akmod-VirtualBox kernel-devel-5.14.16-201.fc34.x86_64
           akmods --kernels 5.14.16-201.fc34.x86_64 && systemctl restart vboxdrv.service

         You will not be able to start VMs until this problem is fixed.
Qt WARNING: QXcbConnection: XCB error: 5 (BadAtom), sequence: 1301, resource id: 0, major code: 20 (GetProperty), minor code: 0

```

Run suggested commands:
```
$ sudo dnf install akmod-VirtualBox kernel-devel-5.14.16-201.fc34.x86_64
Package akmod-VirtualBox-6.1.28-1.fc34.x86_64 is already installed.
Package kernel-devel-5.14.16-201.fc34.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!

$ sudo akmods --kernels 5.14.16-201.fc34.x86_64 && sudo systemctl restart vboxdrv.service
Checking kmods exist for 5.14.16-201.fc34.x86_64           [  OK  ]
```

Try again:

```
$ virtualbox
Qt WARNING: QXcbConnection: XCB error: 5 (BadAtom), sequence: 1301, resource id: 0, major code: 20 (GetProperty), minor code: 0
```

### (Optional) Install Deepin Desktop Environment (DDE)

```
$ dnf group info "Deepin Desktop"
.........................................
Environment Group: Deepin Desktop
 Description: Deepin desktop is the desktop environment released with deepin. It aims at being elegant and easy to use.
 Mandatory Groups:
   Administration Tools
   Common NetworkManager Submodules
   Core
   Deepin Desktop Applications
   Deepin Desktop Environment
   Dial-up Networking Support
   Fonts
   Guest Desktop Agents
   Hardware Support
   Input Methods
   Multimedia
   Printing Support
   Standard
   base-x
 Optional Groups:
   3D Printing
   Cloud Management Tools
   Deepin Desktop Office
   Media packages for Deepin Desktop

$ sudo dnf group install "Deepin Desktop"
```

## Notes



### Fix “Dummy Output” on audio

This sometimes happens after Suspending after upgrading fedora. 
restarted pulseaudio helped:

```
pulseaudio --kill
```

This got my audio back without having to restart the desktop session

## Shortcuts

Switch between virtual desktops:    `Ctrl` + `Alt` + `left/right arrow key`

## Freestyle2 Blue for Mac

Tweeks tool:

- 'Ctrl Position' --> 'Swap right win with right Ctrl'
