# install EPEL repo

yum install epel-release

# install nux-dextop.repo 

sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm


# install keepassx
install EPEL first, then yum install
yum install keepassx.x86_64 

# install google talk plugin
yum localinstall google-talkplugin_current_x86_64.rpm 

# install dropbox
download rpm from dropbox
[root@localhost Downloads]# yum localinstall nautilus-dropbox-1.6.2-1.fedora.x86_64.rpm
OR
https://www.dropbox.com/install?os=lnx

[gengwg@localhost Downloads]$ dropbox start -i

# Install Google Chrome with YUM
sudo -i

cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

sudo yum install google-chrome-stable

# install virtualbox
see separate article.
centos7_install_vbox.txt

# owncloud
not successful at the moment.
running in a ubuntu 14.04 vm as a backup.

# install multimedia
https://wiki.centos.org/TipsAndTricks/MultimediaOnCentOS7

# install skype
first install nux-dextop repo
#rpm -Uvh http://li.nux.ro/download/nux/dextop/el6/x86_64/nux-dextop-release-0-2.el6.nux.noarch.rpm
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

yum install skype 

# chinese input
yum install  ibus-libpinyin # already installed.
search 'lang'
--> 'input source' add chinese
exchange input method: super + space

# mount: unknown filesystem type 'ntfs'
yum install ntfs-3g

# change hostname
sudo nmtui
    --> choose set system hostname
sudo systemctl restart systemd-hostnamed

# start a service
[root@foster ssh]# /bin/systemctl status  yum-cron.service
[root@foster ssh]# systemctl start yum-cron.service 

# unison
# NOTE: unison on centos 7 must use 2.40.128
# 2.40.65 not compatible with ocaml 4.
# This happens because the latest version of unison is build against ocaml 4, while Ubuntu/Debian still use ocaml 3.

sudo yum install ocaml ocaml-camlp4-devel ctags ctags-etags
-> download unison, then untar
tar xvfz unison-2.48.3.tar.gz 
cd unison-2.48.3
make
sudo cp -p -v unison /usr/local/sbin/

## security
# rkhunter
yum install rkhunter
vim /etc/cron.daily/rkhunter.sh
#!/bin/sh
(
 /usr/local/bin/rkhunter --versioncheck
 /usr/local/bin/rkhunter --update
 /usr/local/bin/rkhunter --cronjob --report-warnings-only
 ) | /usr/bin/mail -s 'rkhunter Daily Run foster' gengwg@gmail.com'

# lynis
vim /etc/cron.monthly/lynis
#!/bin/sh

AUDITOR="automated"
DATE=$(date +%Y%m%d)
HOST=$(hostname)
LOG_DIR="/var/log/lynis"
REPORT="$LOG_DIR/report-${HOST}.${DATE}"
DATA="$LOG_DIR/report-data-${HOST}.${DATE}.txt"

/usr/bin/lynis -c --auditor "${AUDITOR}" --cronjob > ${REPORT}

mv /var/log/lynis-report.dat ${DATA}

# End
chmod 755 /etc/cron.monthly/lynis

# unhide
yum install unhide
unhide proc | sys | brute
unhide-tcp

# Timeout for blanking the screen (seconds; 0 = never):
gsettings set org.gnome.desktop.session idle-delay 3600

# Timeout for locking the screen after blanking (seconds; 0 = instant):
gsettings set org.gnome.desktop.screensaver lock-delay 3600

# packages
tree
lynx
htop
gedit
gimp
mplayer
ansible
ansible-lint
yum-cron
rkhunter
lynis
unhide
tmux
audacity
sudo yum localinstall rstudio-0.98.1103-x86_64.rpm
ImageMagick
terminator
gnuplot
brackets
youtube-dl
maven
nload
tripwire
tig
mosh

# install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

Then update the package cache and install the package:

yum check-update
sudo yum install code


## Installing RPMForge Repository 
# wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
# rpm -Uvh rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

# make a keyboard shortcut for Terminal in CentOS 7
Go to Settings >>> keyboard >>> Shortcuts tab >>> Custom Shortcuts >>> click "+"
Name: Terminal Shortcut
Command: gnome-terminal
Now a new shortcut added with status "disabled". Click on "disabled" word and assign your shortcut. 
For me, I prefer Ctrl+Alt+t to run Terminator

# CentOS 7 suspend the system
gengwg@foster:~/Dropbox$ sudo systemctl suspend
# CentOS 7 hibernate the system. sleep
gengwg@foster:~/Dropbox$ sudo systemctl hibernate
------------------------------------------------
When you export/import a VM under CentOS, in VMWare or Hyper-V   environment, you can meet very annoying error – network service in the system can’t be started. When you issue the systemctl status network.service command, you can see output like this:

Jan ######## localhost.localdomain systemd[1]: Failed to start LSB: Bring up/down networking.
Jan ######## localhost.localdomain systemd[1]: Unit network.service entered failed state.

And the solution is simple – when you export/import your VM, the MAC address changes. But your config don’t! So the task is – find out your new MAC-address and change your network configuration file.

There are many ways to discover your MAC, but for me the most simple way – ifconfig

Write down or somehow copy your MAC and then edit interface configuration file with vi, for example:

Vi /etc/sysconfig/network-scripts/ifcgf-eth0
Paste your MAC into HWADDR parameter, and save with :wq

Then you can restart network service without errors with systemctl restart network.service command
--------------------------------------------------
## Configuring Static IP 

** Don’t run this command if you still want to maintain connection **
# systemctl stop NetworkManager.service
# systemctl disable NetworkManager.service

[root@foster network-scripts]#  systemctl disable NetworkManager.service
rm '/etc/systemd/system/dbus-org.freedesktop.NetworkManager.service'
rm '/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service'
rm '/etc/systemd/system/multi-user.target.wants/NetworkManager.service'

Now move to /etc/sysconfig/network-scripts/ path, open and choose your Network Interface you want to assign static IP for editing – to get all NICs names use ifconfig -a or ip -a commands.

# vim /etc/sysconfig/network-scripts/ifcfg-eno1

[root@foster network-scripts]# cat ifcfg-eno1 
#HWADDR=00:0C:29:5B:08:A2
HWADDR=44:39:c4:4f:6e:37
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
USERCTL=no
NM_CONTROLLED=no
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_FAILURE_FATAL=no
NAME=eno1
#UUID=8c6eefa2-0d7b-4559-9870-2953290dc988
ONBOOT=yes
IPADDR=192.168.1.102
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
DNS1=192.168.1.101
DOMAIN=gengwg.com

# vim /etc/resolv.conf
search gengwg.com.
nameserver 192.168.1.101

# systemctl restart network

## change host name
vim /etc/hostname
foster

# automatically mount 7 TB drive
# vim /etc/fstab
/dev/sdb1               /archive                xfs     defaults        1 2

# use dark theme in Terminal
Edit --> Preferences
--> check 'use dark theme variant'
--> Profiles --> Edit --> Colors --> Use colors from system theme

# start application on boot
search 'startup applications'
click 'Add'
/usr/bin/gnome-terminal
/usr/bin/google-chrome


# show the date in the gnome 3 menubar
use dconf-editor to change many of the settings (GSettings) on your GNOME desktop environment. Run dconf-editor and find the appropriate key for your time settings.

e.g. org.gnome.desktop.interface.clock-show-date

# Connect to windows shared folder

Open File browser
--> Connect to Server
--> smb://192.168.1.91

# merge multiple pdfs into one
$ sudo yum install poppler
$ cd pdf_dir/
$ pdfunite *.pdf combined.pdf

# Move to workspace above
Super + Page Up

# Move to workspace below
Super + Page Down


# install foxit pdf reader

First download the installer file according to your system requirement. Use below link to download Foxit installer:
https://www.foxitsoftware.com/pdf-reader/

Unpack the Foxit PDF Reader archive to the document root directory on your server:
 gzip -d FoxitReader2.4.1.0609_Server_x64_enu_Setup.run.tar.gz 
 tar xvf FoxitReader2.4.1.0609_Server_x64_enu_Setup.run.tar 

Next run the following command to start the setup process of Foxit Reader:
 1370  ./FoxitReader.enu.setup.2.4.1.0609\(r08f07f8\).x64.run 

Default installs at home dir, and creates opt/ bin/ there. 
You may want to add ~/bin to PATH env.

# startup applications

gnome-session-properties

# centos 7 has night light
settings --> devices --> displays

# mount: unknown filesystem type 'LVM2_member'

 You must give them unique names. You can rename one of the groups using vgrename and its UUID.

Find the UUID with vgdisplay and then rename the volume group:

vgdisplay
vgrename <VG UUID> gwg

Load the necessary module(s):

$ sudo modprobe dm-mod

Scan your system for LVM volumes and identify in the output the volume group name that has your Fedora volume (mine proved to be VolGroup00):

$ sudo vgscan

Activate the volume:

$ sudo vgchange -ay gwg

Find the logical volume that has your Fedora root filesystem (mine proved to be LogVol00):

$ sudo lvs

mount /dev/gwg/home /mnt/

# install wireshark
yum install wireshark wireshark-gnome



Add Printer Error

Unable to add printer:

    Forbidden
===>
sudo usermod -a -G sys gengwg

Burn Fedora Live usb:

```
dd if=./Fedora-Workstation-Live-x86_64-32-1.6.iso of=/dev/sdc
```

#  Install Jenkins on CentOS 7

### Step 1: Update your CentOS 7 system
```
sudo yum install epel-release
sudo yum update
sudo reboot
```

### Step 2: Install Java
```
sudo yum install java-1.8.0-openjdk.x86_64
java -version
```

In order to help Java-based applications locate the Java virtual machine properly, you need to set two environment variables: "JAVA_HOME" and "JRE_HOME".
```
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile

echo $JAVA_HOME
echo $JRE_HOME
```

### Step 3: Install Jenkins

Use the official YUM repo to install the latest stable version of Jenkins:
```
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key

sudo yum install jenkins
```
Start the Jenkins service and set it to run at boot time:
```
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service
```

In order to allow visitors access to Jenkins, you need to allow inbound traffic on port 8080:
```
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

Now, test Jenkins by visiting the following address from your web browser:
```
http://<your-server-IP>:8080
```

### Step 4: Install Nginx

In order to facilitate visitors' access to Jenkins, you can setup an Nginx reverse proxy for Jenkins, so visitors will no longer need to key in the port number 8080 when accessing your Jenkins application.

Install Nginx using YUM:
```
sudo yum install nginx
```

Modify the configuration of Nginx:
```
sudo vi /etc/nginx/nginx.conf
```

Find the two lines below:
```
location / {
}
```

Insert the six lines below into the { } segment:
```
proxy_pass http://127.0.0.1:8080;
proxy_redirect off;
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

The final result should be:
```
location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_redirect off;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
}
```
Start and enable the Nginx service:
```
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
```

Allow traffic on port 80:
```
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --reload
```

Finally, visit the following address from your web browser to confirm your installation:
```
http://<your-server-IP>
```
