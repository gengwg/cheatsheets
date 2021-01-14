// vim: noai:ts=2:sw=2

remove `Icon?` files on mac

```
find ~/Documents -type f -name 'Icon?' -print -delete;
```

find default mail exchange server

```
$ dig dig +short qq.com MX
30 mx1.qq.com.
10 mx3.qq.com.
20 mx2.qq.com.
```

Show username with First letter capitalized:

```
$ echo ${USER^}
Gengwg
```

generate paste from command line

```
# need jf auth first
cat /var/chef/outputs/chef.last.out | pastry
# or-
pastry < /var/chef/outputs/chef.last.out
```

get username from userid

```
# getent passwd 3251333
gengwg:*:3251333:100:Tom Geng:/home/gengwg:/bin/bash
```

show all versions of rpm package:

```
yum --showduplicates list git
```

trim leading and trailing whitespace from each line of some output:

    $ cat slurm19.txt | awk '{$1=$1;print}'
    
Run command and output to stdout and file simultaneously.

```
sudo apt install mlnx-ofed-kernel-dkms mlnx-ofed-kernel-utils -y | tee ofed_update.log
```

use cut to separate by multiple whitespace.

```
cat file | tr -s ' ' | cut -d ' ' -f 8
```

Check installed memory information

```
sudo dmidecode -t memory

# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.

Handle 0x0036, DMI type 16, 23 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: Single-bit ECC
        Maximum Capacity: 512 GB
        Error Information Handle: Not Provided
        Number Of Devices: 4

Handle 0x0038, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0036
        Error Information Handle: Not Provided
        Total Width: 72 bits
        Data Width: 64 bits
        Size: 32 GB
        Form Factor: DIMM
        Set: None
        Locator: DIMM_A0
        Bank Locator: _Node0_Channel0_Dimm0
        Type: DDR4
        Type Detail: Synchronous
        Speed: 2400 MHz
        Manufacturer: Samsung
        Serial Number: 3697D2DC
        Asset Tag: DIMM_A0_AssetTag
        Part Number: M393A4K40BB1-CRC
        Rank: 2
        Configured Clock Speed: 2133 MHz
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V
```

Check System Information:

```
$ sudo dmidecode -t1
# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 3.0.0 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: NVIDIA
        Product Name: DGX-1 with V100
        Version: v1.0
        Serial Number: QTFCOU73900E8
        UUID: 91BD6617-DA9D-E711-AB21-A81E84C47E67
        Wake-up Type: Power Switch
        SKU Number: Default string
        Family: Default string
```

replace spaces in file names with underscore:

```
for f in *\ *; do mv "$f" "${f// /_}"; done
```

format python script

```
$ black -v rename.py
reformatted rename.py
All done! ✨ 🍰 ✨
1 file reformatted.
```

Grep show lines Both before and after the match

```
<command> | grep -2 ecc
```

Copy paste on command line:

```
sudo apt install xclip
date | xclip
xclip -o

date | xclip -selection clipboard
```

convert whitespace to new line:


```
$ echo * | tr [:blank:] "\n"
```

Use similar Mac `open` command on linux

```
alias open='xdg-open'
```

Find Exact Installation Date And Time Of Your CentOS:

```
$ rpm -qi basesystem
Name        : basesystem
Version     : 11
Release     : 5.el8
Architecture: noarch
Install Date: Sun 26 Apr 2020 11:03:28 PM PDT   <-------
Group       : System Environment/Base
Size        : 0
License     : Public Domain
Signature   : RSA/SHA256, Mon 01 Jul 2019 01:45:35 PM PDT, Key ID 05b555b38483c65d
Source RPM  : basesystem-11-5.el8.src.rpm
Build Date  : Fri 10 May 2019 05:19:04 PM PDT
Build Host  : aarch64-02.mbox.centos.org
Relocations : (not relocatable)
Packager    : CentOS Buildsys <bugs@centos.org>
Vendor      : CentOS
Summary     : The skeleton package which defines a simple centos system
Description :
Basesystem defines the components of a basic centos system
(for example, the package installation order to use during bootstrapping).
Basesystem should be in every installation of a system, and it
should never be removed.

# Or display the installation date only
$ rpm -qi basesystem | grep "Install Date"
Install Date: Sun 26 Apr 2020 11:03:28 PM PDT
```

Launch a shell for as a nologin user:

```
sudo -u www-data bash
```

make gpg prompt for passphrase on CLI instead of using a GUI dialog box:

```
$ sudo apt install pinentry-tty

# choose 3
$ sudo update-alternatives --config pinentry
There are 3 choices for the alternative pinentry (providing /usr/bin/pinentry).

  Selection    Path                      Priority   Status
------------------------------------------------------------
* 0            /usr/bin/pinentry-gnome3   90        auto mode
  1            /usr/bin/pinentry-curses   50        manual mode
  2            /usr/bin/pinentry-gnome3   90        manual mode
  3            /usr/bin/pinentry-tty      30        manual mode

# restart gpg-agent
$ gpgconf --kill gpg-agent
```

Find all files that have the SUID or SGID access mode set:

```
$ sudo find /usr/bin \( -perm -2000 -o -perm -4000 \) -type f -print
```

Delete large number of files:

```
$ rm *.jpg
bash: /bin/rm: Argument list too long
$ find . -maxdepth 1 -type f -name "*.jpg" -delete
```

Delete large number of directories:

```

$ sudo find . -maxdepth 1 -type d -name "tmp_dir.*" -exec rm -r "{}" \;
```

`eval` executes its argument as a shell command:

```
$ cmd=date
$ eval $cmd
```

Check SSH Key Fingerprint

```
ssh-keygen -l -E md5 -f /etc/ssh/ssh_host_rsa_key.pub
```

Delete a word on the left on command line:
```
Ctrl + w
```

Ubuntu install OpenGL

```
$ sudo apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev
$ sudo apt install mesa-utils
# test install succeeds
$ glxgears
$ glxheads
```

Test Postfix/mailx config:

```
echo "Testing sending mail"  | mailx -v -s "Sending mail from "$(hostname -s)  gengwg@email.com
```

Find files newer than a certain file.
Then create a backup on them.

```
$ touch backup_touch
$ touch newerfile
$ find . -newer backup_touch -print
./newerfile
$ find . -newer backup_touch -print |cpio -o > /tmp/backup1
1 block
$ rm newerfile
# recover from backup
$ cpio -im 'newerfile' </tmp/backup1
1 block
$ ls newerfile
newerfile
```

Examing existing TCP connections:

```
lsof -i tcp
```

Restart Network Interface

```
# ifdown eth0
# ifup eth0
```

Debian / Ubuntu Linux restart network interface

```
sudo /etc/init.d/networking restart
```

Redhat (RHEL) / CentOS :

```
# /etc/init.d/network restart
```

Determine all available network interfaces on my system:

```
netstat -ain
```

Empty a file:

```
> myfile.txt
```

Obtain info about exported directories from NFS server:

```
showmount -e <hostname>
```

Get CentOS distribution:

```
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ echo $distribution
centos7
```
Get user default login shell:

```
$ getent passwd $LOGNAME | cut -f 7 -d:
/bin/bash
```

`/usr/local/bin` in `PATH` is from bash internals!
Not from those environment scripts such as `/etc/profile`.

```
$ strings /bin/bash | grep /usr/local/bin
/usr/local/bin:/usr/bin
```

It's hardcoded in `/bin/bash`.
From `bash-4.4` in `config-top.h`:

```
 63 /* The default value of the PATH variable. */
 64 #ifndef DEFAULT_PATH_VALUE
 65 #define DEFAULT_PATH_VALUE \
 66   "/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:."
 67 #endif
```

Remove empty lines from file:

```
awk 'NF' file.txt
```

Remove last line from file:

```
sed -i '$ d' file.txt
```


`No bootable device Detected.` error.

===>

BIOS was set to Legacy Boot. Change to UEFI Boot instead.

Set MTU;

```
sudo ip link set dev eth0 mtu 9000
```

Check swap status:

```
swapon -s
```

Check swappiness

```
$ sysctl vm.swappiness
vm.swappiness = 60
```

Linux's network stack uses the NO CARRIER status for a network interface that is turned on ("up") but cannot be connected because the Physical Layer is not operating properly, e.g. because an ethernet cable is not plugged in.
