// vim: noai:ts=2:sw=2

Convert DOS file to UNIX format

```
dos2unix myfile.txt
```

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

Check installed memory information:

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

Similar commands:

```
dmidecode -t memory
dmidecode -t 16
lshw -class memory
```

Check which memory slots are empty:

```
# lshw -class memory | grep empty -B 1
# dmidecode -t memory | grep "No Module Installed" -A 3
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

Find size 0 files in current directory and delete them:

```
$ find -maxdepth 1 -size 0 -type f  -delete
$ find -maxdepth 1 -type f -empty -delete
```

Find DHCP Server address:

```
sudo dhclient -d -nw <enoX>

Internet Systems Consortium DHCP Client 4.4.2b1
Copyright 2004-2019 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eno1/<mac>
Sending on   LPF/eno1/<mac>
Sending on   Socket/fallback
DHCPDISCOVER on eno1 to 255.255.255.255 port 67 interval 8 (xid=0xebb26f74)
DHCPOFFER of 192.168.0.xxx from 192.168.0.1   # <--- DHCP Server address (usually your router)
DHCPREQUEST for 192.168.0.xxx on eno1 to 255.255.255.255 port 67 (xid=0xebb26f74)
DHCPACK of 192.168.0.xxx from 192.168.0.1 (xid=0xebb26f74)
bound to 192.168.0.xxx -- renewal in 70890 seconds.
```

Check missing nvme ssd disk:

```
[root@server ~]# dmesg | grep nvme9
[    3.649794] nvme nvme9: pci function 0000:bc:00.0
[11847942.588502] nvme nvme9: I/O 42 QID 50 timeout, aborting
[11847972.533745] nvme nvme9: I/O 42 QID 50 timeout, reset controller
[11847972.534445] nvme nvme9: Abort status: 0x7
[11848032.989938] nvme nvme9: Device not ready; aborting initialisation
[11848032.989967] nvme nvme9: Removing after probe failure status: -19
[11848032.990132] nvme9n1: detected capacity change from 6401252745216 to 0
[11848032.990381] blk_update_request: I/O error, dev nvme9n1, sector 6227719040
```
Convert dmesg time to human readable:

```
[root@server ~]# dmesg -T | grep nvme9
[Mon Aug 17 09:08:40 2020] nvme nvme9: pci function 0000:bc:00.0
[Fri Jan  1 11:14:19 2021] nvme nvme9: I/O 42 QID 50 timeout, aborting
[Fri Jan  1 11:14:49 2021] nvme nvme9: I/O 42 QID 50 timeout, reset controller
[Fri Jan  1 11:14:49 2021] nvme nvme9: Abort status: 0x7
[Fri Jan  1 11:15:49 2021] nvme nvme9: Device not ready; aborting initialisation
[Fri Jan  1 11:15:49 2021] nvme nvme9: Removing after probe failure status: -19
[Fri Jan  1 11:15:49 2021] nvme9n1: detected capacity change from 6401252745216 to 0
[Fri Jan  1 11:15:49 2021] blk_update_request: I/O error, dev nvme9n1, sector 6227719040
```
https://sleeplessbeastie.eu/2013/10/31/how-to-deal-with-dmesg-timestamps/

Parse /proc/pid/cmdline:

```
$ cat /proc/self/cmdline | strings -1
```

```
       /proc/[pid]/cmdline
              This read-only file holds the complete command line for
              the process, unless the process is a zombie.  In the
              latter case, there is nothing in this file: that is, a
              read on this file will return 0 characters.  The command-
              line arguments appear in this file as a set of strings
              separated by null bytes ('\0'), with a further null byte
              after the last string.
```

print a sequence of numbers with equal width by padding with leading zeroes:

```
$ seq -w 07 10
07
08
09
10
```

In some permission systems additional symbols in the `ls -l` display represent additional permission features:

```
    + (plus) suffix indicates an access control list that can control additional permissions.
    . (dot) suffix indicates an SELinux context is present. Details may be listed with the command ls -Z.
    @ suffix indicates extended file attributes are present.
```

Grep error log using bracket expessions:

```
$ sudo lsof -p `pidof -s apache2` | grep "err[^/]*log"
apache2 14051 www-data    2w      REG  179,2      561  518214 /var/log/apache2/error.log
```

Grep leading white spaces:

```
$ grep -c "^\s* \"node_" metadata.json
298
```

Combine multiple pictures into a single PDF file:

```
$ sudo dnf install ImageMagick
$ convert *.jpg outputfile.pdf
```

Merge multiple PDFs into a single PDF file:

```
$ pdfunite scan00*.pdf output.pdf
```

Create a large file:

```
$ dd if=/dev/zero of=file1.out bs=1M count=1024
$ fallocate -l 1G file2.out   # fastest
```

Follow logs:

```
journalctl -u kube-apiserver -f
```

Check physical block size for a disk

```
$ cat /sys/block/sdc/queue/physical_block_size
4096
$ cat /sys/block/sda/queue/physical_block_size
512
```

Check logical block size for a disk

```
$ cat /sys/block/sda/queue/logical_block_size
512
$ cat /sys/block/sdb/queue/logical_block_size
512
```

理论上应该是 logical_block_size >= physical_block_size，但是有时候我们会看到 physical_block_size = 4K，logical_block_size = 512B 情况，其实这是因为磁盘上做了一层 512B 的仿真（emulation）

Determine if filesystem or partition is mounted ReadOnly:

```
grep "[[:space:]]ro[[:space:],]" /proc/mounts 

awk '$4 ~ /^ro/ { print $2 }' /proc/mounts
# only check certain filesystem types
awk '$3 ~ /ext[0-9]|xfs|btrfs/ && $4 ~ /^ro/ { print $2 }' /proc/mounts
```

Generate a token:

```
head -c 16 /dev/urandom | od -An -t x | tr -d ' '
```

vmstat columns doesn't align.
use a wider output:

```
$ vmstat -w 1 5
--procs-- -----------------------memory---------------------- ---swap-- -----io---- -system-- --------cpu--------
   r    b         swpd         free         buff        cache   si   so    bi    bo   in   cs  us  sy  id  wa  st
   0    0      2709504      1115492       308724      3241616    1    3    15    65    2   11  11  32  57   0   0
   0    0      2709504      1115244       308724      3242804    0    0     0     0 10115 15880   9  37  54   0   0
   1    0      2709504      1115004       308724      3243536    0    0     0     0 14245 23454   6  51  43   0   0
   4    0      2709504      1110220       308724      3243740    0    0     0  1064 12036 20503   6  34  59   0   0
   0    0      2709504      1110976       308724      3241816    0    0     0     0 10302 16535   6  35  58   0   0
```

Find out which cpus allowed to run the process:

```
$ grep Cpus /proc/self/status
Cpus_allowed:	f
Cpus_allowed_list:	0-3
```

Find out total number of cpus:

```
$ nproc
4
```

keep environment variables when using sudo:

```
-E, --preserve-env

$ export HTTP_PROXY=foof
$ sudo -E bash -c 'echo $HTTP_PROXY'
foof
$ sudo -E echo $HTTP_PROXY
foof
```

exclude multiple directories in ncdu when scanning

```
ncdu / --exclude home --exclude media --exclude mnt --exclude var --exclude proc
```

Convert markdown to html

```
pandoc -o output.html README.md
pandoc -t html java.md > /tmp/output.html
```

Sort file by 2nd column

```
sort -u -k2 myfile.txt
```

Append string to the end of each line in a file

```
$ cat myfile.txt
host1
host2
host3
# verify changes
$ sed -e 's/$/.example.com/' myfile.txt
host1.example.com
host2.example.com
host3.example.com
# change in place
$ sed -e 's/$/.example.com/' -i myfile.txt
$ cat myfile.txt
host1.example.com
host2.example.com
host3.example.com
```

One way to check vm vs. pm:

vm:

```
# hostnamectl
   Static hostname: myhost
         Icon name: computer-vm
           Chassis: vm # <------------------------------
        Machine ID: xxxxxx
           Boot ID: xxxxxx
    Virtualization: vmware # <------------------------------
  Operating System: CentOS Linux 7 (Core)
            Kernel: Linux 3.10.0-1160.62.1.el7.x86_64
      Architecture: x86-64
```

pm:

```
$ hostnamectl
   Static hostname: myserver
         Icon name: computer-server
           Chassis: server # <------------------------------
        Machine ID: xxxxx
           Boot ID: xxxxx
  Operating System: CentOS Linux 7 (Core)
            Kernel: Linux 3.10.0-1127.el7.x86_64
      Architecture: x86-64
```

Find non-empty binary files and move them to another directory:

```
find . -type f ! -size 0 -exec grep -IL . "{}" \; | xargs -I '{}' mv {} /tmp/
```

Extract password protected zip in Linux:

```
$ sudo dnf install p7zip
$ 7za x wechat-file.part0.zip -pmypass
```

A few useful commands to use when debugging a Linux server:

```
uptime
dmesg | tail
vmstat 1
mpstat -P ALL 1
pidstat 1
iostat -xz 1
free -m
sar -n DEV 1
sar -n TCP,ETCP 1
top
```

https://netflixtechblog.com/linux-performance-analysis-in-60-000-milliseconds-accc10403c55

The NUMA node is a hardware node in a computer that consists of a local memory and a set of processors, and is used to improve performance by reducing latency when accessing local memory.

How to check the CPU to NUMA node mapping:

```
$ lscpu | grep NUMA
NUMA node(s):        8
NUMA node0 CPU(s):   0-15,128-143
NUMA node1 CPU(s):   16-31,144-159
NUMA node2 CPU(s):   32-47,160-175
NUMA node3 CPU(s):   48-63,176-191
NUMA node4 CPU(s):   64-79,192-207
NUMA node5 CPU(s):   80-95,208-223
NUMA node6 CPU(s):   96-111,224-239
NUMA node7 CPU(s):   112-127,240-255

$ cat /sys/devices/system/node/node0/cpulist
0-15,128-143
$ cat /sys/devices/system/node/node0/cpumap
00000000,00000000,00000000,0000ffff,00000000,00000000,00000000,0000ffff
$ cat /sys/devices/system/node/node3/cpulist
48-63,176-191
$ cat /sys/devices/system/node/node3/cpumap
00000000,00000000,ffff0000,00000000,00000000,00000000,ffff0000,00000000

# It is important to note that little-endian byte ordering is being used, 
# meaning that the least significant bytes are stored before the more significant bytes. 
# As a result, this indicates that CPUs 48-63 and 176-191 are present on NUMA node 0.

$ lscpu | grep Byte
Byte Order:          Little Endian

## Another example from a 2-numa node system

$ cat /sys/devices/system/node/node0/cpulist
0-63,128-191
$ cat /sys/devices/system/node/node0/cpumap
00000000,00000000,ffffffff,ffffffff,00000000,00000000,ffffffff,ffffffff

$ cat /sys/devices/system/node/node1/cpulist
64-127,192-255
$ cat /sys/devices/system/node/node1/cpumap
ffffffff,ffffffff,00000000,00000000,ffffffff,ffffffff,00000000,00000000

## Example of NUMA for a VMware VM 
## These usually just contain 1 default numa node0

$ lscpu | grep NUMA
NUMA node(s):        1
NUMA node0 CPU(s):   0-3
$ cat /sys/devices/system/node/node0/cpulist
0-3
$ cat /sys/devices/system/node/node0/cpumap
f
```

Decode JWT token:

```
jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "<token_here>"
```


Command to resolve name using hosts file:

```
## ping
$ ping google.com
PING google.com(google.com (2401:db00:25ff:c83::)) 56 data bytes
^C
--- google.com ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1061ms

## getent

$ getent hosts google.com
2401:db00:25ff:c83:: google.com
```

Curl with timeout using the "-m" or "--max-time" option followed by the number of seconds.

```
$ curl -kL -m 5 https://myexample.com/
curl: (28) Connection timed out after 5001 milliseconds
```

Check if a file is statically or dynamically compiled:

```
$ file /bin/ps
/bin/ps: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=1b9bc86e2f74266d21817c934048e842d975628a, stripped
```

Check what external libraries are being used:

```
$ ldd /bin/ps
	linux-vdso.so.1 (0x00007fffce573000)
	libprocps.so.7 => /lib64/libprocps.so.7 (0x00007fc893600000)
	libsystemd.so.0 => /lib64/libsystemd.so.0 (0x00007fc893200000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fc892e00000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fc892a00000)
	libcap.so.2 => /lib64/libcap.so.2 (0x00007fc892600000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007fc892200000)
	liblz4.so.1 => /lib64/liblz4.so.1 (0x00007fc891e00000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fc891a00000)
	librt.so.1 => /lib64/librt.so.1 (0x00007fc891600000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fc891200000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fc890e00000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fc893e00000)
```

Or 

```
$ sudo dnf install pax-utils
$ lddtree /bin/ps
ps => /bin/ps (interpreter => /lib64/ld-linux-x86-64.so.2)
    libprocps.so.7 => /lib64/libprocps.so.7
    libsystemd.so.0 => /lib64/libsystemd.so.0
        libcap.so.2 => /lib64/libcap.so.2
        libzstd.so.1 => /lib64/libzstd.so.1
        liblz4.so.1 => /lib64/liblz4.so.1
        libpthread.so.0 => /lib64/libpthread.so.0
        librt.so.1 => /lib64/librt.so.1
        liblzma.so.5 => /lib64/liblzma.so.5
        libgcc_s.so.1 => /lib64/libgcc_s.so.1
        ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2
    libdl.so.2 => /lib64/libdl.so.2
    libc.so.6 => /lib64/libc.so.6
```


## Modify the file creation timestamp

For example, to test delete files older than certain time.

```
touch -t YYYYMMDDhhmm.ss /path/to/your/file

touch -t 202110050000.00 /path/to/your/file
```
