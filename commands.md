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
