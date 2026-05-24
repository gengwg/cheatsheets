Install Cups, it's in the Debian repo's. Then point your browser to http://localhost:631 and log in as root. Then click the 'Add printer' button and follow the steps presented. Choose the correct printer model and confirm. Next, go to the 'Printer' tab (top menu) and see if your newly added printer is named. Click on that name and try a testpage. If that works, you're ready for the real thing 

dd if=<file> of=<device> bs=4M; sync
dd bs=4M if=ubuntu-14.04-desktop-server-kylin-amd64.iso  of=/dev/sdb

cat debian.iso > /dev/sdb; sync

------------------------
install debian using usb 
along with windows
------------------------
1. prepare bootable usb

cat debian-7.1.0-amd64-netinst.iso > /dev/sdb
sync

restart x220, press F12 to enter bios
choose USB BOOT

when reaching 'Partition Disks' part
choose 'Manual'
choose windows disk 
--> Resize the partition
next use the FREE SPACE
--> automaticall partion
--> separate home partition.

modify  
/etc/network/interfaces 
show this :

auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp

then,
ifdown eth0
ifup eth0

then, check if network works by
ping google.com

next, copy the sources.list from another machine to a webserver.
then,
wget 192.168.0.19:/var/www/sources.list

apt-get update

install desktop environment:
apt-get install xfce4

startx (this needs to be commanded....)

final solution is tasksel....

---------------------------------------------------
mountng an external harddrive:
# fdisk -l | grep NTFS
# mkdir /media/TOURO
# mount /dev/sdb1 /media/TOURO
# umount /dev/sdb1


restart X server
"alt"+"print screen"+"k" 

----------------------------------------------------
Fixing virtualbox :
------------------------------------------------------

sudo vi /etc/apt/sources.list.d/vbox.list and paste in this line, then save:

deb http://download.virtualbox.org/virtualbox/debian wheezy contrib

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
(https://www.virtualbox.org/wiki/Linux_Downloads) 

run sudo apt-get update && sudo apt-get -y upgrade to update your machine to the latest

Run sudo apt-get remove virtualbox*. Then install Oracle's version: sudo apt-get install virtualbox-4.2

----------------------------------------------
original error message:
---------------------------------------------------
Kernel driver not installed (rc=-1908)

        The VirtualBox Linux kernel driver (vboxdrv) is either not loaded or there is a permission problem with /dev/vboxdrv. Please reinstall the kernel module by executing

            '/etc/init.d/vboxdrv setup'

                as root. If it is available in your distribution, you should install the DKMS package first. This package keeps track of Linux kernel changes and recompiles the vboxdrv kernel module if necessary.
-----------------------------------------------------                
another new error:

A critical error has occurred while running the virtual machine and the machine execution has been stopped.
For help, please see the Community section on http://www.virtualbox.org or your support contract. Please provide the contents of the log file VBox.log and the image file VBox.png, which you can find in the /home/gengwg/VirtualBox VMs/Learning Puppet VM (pe-3.0.1)/Logs directory, as well as a description of what you were doing when this error happened. Note that you can also access the above files by selecting Show Log from the Machine menu of the main VirtualBox window.
Press OK if you want to power off the machine or press Ignore if you want to leave it as is for debugging. Please note that debugging requires special knowledge and tools, so it is recommended to press OK now.

This seems fixed it:???
/etc/init.d/vboxdrv setup

# fix two monitors in xfce
install arandr

# restart networking to renew IP
root@think:/home/gengwg/Downloads# /etc/init.d/networking restart
# last one deprecated. should use this:
root@think:/etc# /etc/init.d/networking stop; /etc/init.d/networking start

----------------------------
Install Oracle Java 7

su -
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update
apt-get install oracle-java7-installer
exit
--------------------------------

debian 经常 freeze

1. ctrl+alt+backspace
2. ctrl+alt+F1，login ，kill X


#config
cd ~
mv .bashrc .bashrc.orig
ln -s ~/Dropbox/bash_conf/.bashrc
ln -s ~/Dropbox/bash_conf/.bash_aliases

root@neutrino:/home/gengwg/Dropbox/seagate# aptitude install mcollective
The following NEW packages will be installed:
  mcollective mcollective-client{a} mcollective-common{a} ruby1.8-dev{a} rubygems{a} 
0 packages upgraded, 5 newly installed, 0 to remove and 9 not upgraded.
Need to get 910 kB/1,616 kB of archives. After unpacking 6,785 kB will be used.
Do you want to continue? [Y/n/?] 
Err http://ftp.us.debian.org/debian/ wheezy/main ruby1.8-dev amd64 1.8.7.358-7
  404  Not Found [IP: 128.61.240.89 80]
0% [Working]E: Failed to fetch http://ftp.us.debian.org/debian/pool/main/r/ruby1.8/ruby1.8-dev_1.8.7.358-7_amd64.deb: 404  Not Found [IP: 128.61.240.89 80]

===>
apt-get clean
apt-get update
apt-get upgrade

=====================================================

# install flash
Open a terminal and edit the file /etc/apt/sources.list using a text editor and make sure following line exists:
deb ftp://ftp.debian.org/debian stable main contrib non-free
aptitude update
aptitude install flashplugin-nonfree


# install dropbox 

https://www.dropbox.com/help/246/en

Add the following line to /etc/apt/sources.list. Replace squeeze with your build's name.

deb http://linux.dropbox.com/debian squeeze main

To import our GPG keys into your apt repository, perform the following command from your terminal shell:

$ sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

# move the vertical XFCE panel to the right side 

    Right-click the panel and select "Panel -> Panel Preferences". Make sure the "Lock Panel" check box is unchecked. When unchecked, a handle will appear at the top of (vertical) or to the left of (horizontal) the panel. Click and drag this handle to move the panel. When satisfied with the new position, you an hide the handle again by checking the "Lock Panel" checkbox. 

---------------------------
# install lamp

apt-get install mysql-server mysql-client

apt-get install apache2
Go to:
http://localhost/info.php

apt-get install php5 libapache2-mod-php5
vi /var/www/info.php
<?php
phpinfo();
?>
Go to:
http://localhost/info.php

apt-get install php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

apt-get install php-apc

/etc/init.d/apache2 restart

Go to:
http://localhost/info.php

apt-get install phpmyadmin
Web server to reconfigure automatically: <-- apache2
Configure database for phpmyadmin with dbconfig-common? <-- No

----------------------------------------
# install mediawiki 
apt-get install mediawiki php5-gd php5-xcache php-pear
Uncomment the alias line in /etc/mediawiki/apache.conf :

Alias /mediawiki /var/lib/mediawiki

Restart apache and go to http://www.myserver.org/mediawiki/config/index.php and fill in the form.

Copy settings in /etc/mediawiki/ and change file permissions :

#cp Downlodas/LocalSettings.php /etc/mediawiki
# chgrp www-data /etc/mediawiki/LocalSettings.php
# chmod o= /etc/mediawiki/LocalSettings.php

You are ready to surf on your new wiki using this url:

    http://www.myserver.org/mediawiki/
----------------------------------------

-----------
# Install ganglia
apt-get install ganglia-monitor gmetad

---------------
#### install wps office

http://community.wps.cn/download/

aptitude install zenity
dpkg --add-architecture i386
apt-get update
apt-get install ia32-libs
apt-get install  ia32-libs-gtk

optional:
### to put wps in command
cp /home/gengwg/wps-office_8.1.0.3724~b1p2_x86 /opt/ -r
ln -s /opt/wps-office_8.1.0.3724~b1p2_x86/wps /usr/bin
modify the wps script gBinPath:
#gBinPath=$(dirname "$0")
gBinPath=/opt/wps-office_8.1.0.3724~b1p2_x86

do the same thing for other commands.
--------------------------------
!!! wrong arch !!!
aptitude install libglu1-mesa:i386
dpkg -i wps-office_8.1.0.3724~b1p2_i386.deb
-------------------------------------

restart network
/etc/init.d/networking restart

 restart the sound system 
/etc/init.d/alsa-utils restart

xscreensaver &

# packages
apt-get -y install aptitude
aptitude install -y tree
aptitude install -y git
aptitude install -y geany
aptitude install -y leafpad
aptitude install -y vim
aptitude install -y terminator
aptitude install -y dstat
aptitude install -y cmake
aptitude install -y moreutils

aptitude install -y xclip
aptitude install -y lynx
aptitude install -y build-essential
aptitude install -y ntp
aptitude install -y ntpdate
aptitude install -y dnsutils
aptitude install -y htop
aptitude install -y file
aptitude install -y at
aptitude install -y parted
aptitude install -y doxygen
aptitude install -y python-epydoc
aptitude install -y keepassx
aptitude install -y gedit
dpkg -i google-talkplugin_current_amd64.deb
aptitude install imagemagick
aptitude install gimp
aptitude install chromium
aptitude install mplayer2 # mplayer not supported...
aptitude install flashplugin-nonfree
aptitude install firmware-iwlwifi
aptitude install firmware-realtek   # for 330s
aptitude install gtk-recordmydesktop
aptitude install ffmpeg
aptitude install librsvg2-bin
aptitude install xchat
aptitude install ufw
aptitude install nautilus-dropbox
aptitude install -y fail2ban
aptitude install -y libnss-mdns

apt install geany-plugins

# fix wifi on lenovo 330s
aptitude install -y firmware-misc-nonfree
aptitude install -y firmware-linux-nonfree
aptitude install -y firmware-linux-free

Add in /etc/NetworkManager/NetworkManager.conf 

[device]
wifi.scan-rand-mac-address=no


# update system automatically
aptitude install cron-apt # to update system automatically
root@neutrino:/etc/cron-apt# cat config
# Configuration for cron-apt. For further information about the possible
# configuration settings see /usr/share/doc/cron-apt/README.gz.
MAILTO="user@company.com"
MAILON="always"


synergy

# docs
aptitude install bash-doc
aptitude install apache2-doc
aptitude install python-doc
aptitude install htmldoc

# Install pip.
apt-get install python-setuptools
root@denver:~# aptitude install python-pip
root@denver:~# easy_install pip
root@denver:~# pip install pysensors


# send email.
apt-get install mailutils
apt-get install postfix
apt-get install mutt
echo "This is the message body" | mutt -s "hello" user@company.com

# install Java plugin in Firefox
aptitude install icedtea-7-plugin
then, restart firefox

# Chinese input
aptitude install ibus-googlepinyin (NA)

sudo aptitude install libpinyin
sudo apt-get install ibus-pinyin 
sudo apt-get install ibus-sunpinyin (Optional)
ibus restart

Then go to System Settings --> Language & Region--> Input Sources --> Add Chinese

# search package
aptitude search rsync

# list all your installed packages and the automatically installed ones will be marked with A.
aptitude search '~i'

# debian network-manager not showing up
aptitude remove xdm
aptitude install lightdm
reboot

to use snmpget
# aptitude install snmp

=============
Failed to fetch http://security.debian.org/dists/wheezy/updates/Release: Unable to find expected entry 'universe/source/Sources' in Release file (Wrong sources.list entry or malformed file)
===>
vi /etc/apt/sources.list and remove all the words 'universe'. (how did they get here?)
:%s/universe//g

-----------------
Convert ogv files.

# aptitude install ffmpeg

ffmpeg -i slides.ogv -loop_output 0 -pix_fmt rgb24 -r 10 -s 640x480 slides.gif
ffmpeg -i slides.ogv slides.mp4

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

dpkg-query -l dstat

# list all files installed by a package
dpkg-query -L dstat

# check which package a file belongs to.
gengwg@neutrino:~/Dropbox$ dpkg-query -S /usr/bin/dstat
dstat: /usr/bin/dstat
gengwg@neutrino:~/Dropbox$ dpkg-query -S /etc/ganglia/gmond.conf 
ganglia-monitor: /etc/ganglia/gmond.conf


## suspend/--hibernate computer from command line.

# first check if they are supported. 
# for me laptop both works. server suspend not work.
# note one don't need su power to just check this.

gengwg@think:~$ pm-is-supported --hibernate 
gengwg@think:~$ echo $?
0
gengwg@think:~$ pm-is-supported --suspend   
gengwg@think:~$ echo $?
0

# next as root user or sudo issue following commands. 
pm-hibernate
pm-suspend

9/14/14

seems installing skype (and virtualbox?) will break the dependency for owncloud-client. libqt or something. solution seems to be remove some dependencies, such as libqtcore4. then install owncloud first, after that install skype and remove and install virutalbox again... fxxk there's no perfect distribution....

# install nfs server
aptitude install nfs-kernel-server portmap
echo "portmap: 192.168.1." >> /etc/hosts.allow
/etc/init.d/rpcbind restart

root@think:~# mkdir /share

root@think:~# echo "/share 192.168.1.0/255.255.255.0(rw,no_root_squash,subtree_check)" >> /etc/exports
root@think:~# /etc/init.d/nfs-kernel-server reload
[....] Reloading nfs-kernel-server configuration (via systemctl): nfs-kernel-ser[ ok ervice.
root@think:~# rpcinfo -p
rpcinfo: can't contact portmapper: RPC: Remote system error - No such file or directory
root@think:~# sudo service rpcbind restart
root@think:~# rpcinfo -p
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  43137  status
    100024    1   tcp  42121  status


on client:
[root@foster etc]# mkdir /mnt/share
[root@foster etc]# mount 192.168.1.101:/share /mnt/share

## debug 
[root@foster etc]# showmount -e 192.168.1.101
clnt_create: RPC: Program not registered
===>
root@think:~# /etc/init.d/nfs-kernel-server restart
[ ok ] Restarting nfs-kernel-server (via systemctl): nfs-kernel-server.service.

[root@foster etc]# showmount -e 192.168.1.101
Export list for 192.168.1.101:
/share *

## install gitlab

1. Install and configure the necessary dependencies

If you install Postfix to send email please select 'Internet Site' during setup. 

sudo apt-get install curl openssh-server ca-certificates postfix

2. Add the GitLab package server and install the package

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce

If you are not comfortable installing the repository through a piped script, you can find the entire script here and select and download the package manually and install using

curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/debian/jessie/gitlab-ce-XXX.deb/download
dpkg -i gitlab-ce-XXX.deb

3. Configure and start GitLab

sudo gitlab-ctl reconfigure

$ sudo vim /etc/gitlab/gitlab.rb 
external_url 'http://192.168.29.101:8081'
$ sudo gitlab-ctl reconfigure

4. Browse to the hostname and login

Open browser go to http://192.168.29.101:8081
IT will automatically ask you to Reset password
Use 'root' and above password to login.

5. Set up ssh 

# copy ssh key to gitlab

# set up ssh using a different port
gengwg@foster: Dropbox $ cd sysprogram/
gengwg@foster: sysprogram $ git remote set-url gitlab ssh://git@192.168.29.101:1982/Books/sysprogram.git
gengwg@foster: sysprogram $ git push gitlab master

## Ubuntu Kylin

Install Neteast Cloud Music

```
root@ideacentre:~# apt install netease-cloud-music
```

Install Cisco packet tracer:


$ sudo apt install ./Packet_Tracer822_amd64_signed.deb

