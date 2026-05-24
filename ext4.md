**All command run as root. So pay attention to disk label when copy/pasting.**

Find new drive:

```
# fdisk -l

Model: ST1000DX 001-1CM162 (scsi)
Disk /dev/sde: 1000GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  525MB   524MB   primary  xfs          boot
 2      525MB   1000GB  1000GB  primary               lvm
# lsblk /dev/sde
NAME                            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sde                               8:64   0 931.5G  0 disk 
├─sde1                            8:65   0   500M  0 part 
└─sde2                            8:66   0   931G  0 part 
```

Create new partition:

```
# wipefs /dev/sde

# parted /dev/sde mklabel gpt
Warning: The existing disk label on /dev/sde will be destroyed and all data on this disk will be lost. Do you want to continue?

Yes/No? Yes                                                               
Information: You may need to update /etc/fstab.

# parted -a opt /dev/sde mkpart primary ext4 0% 100%
Information: You may need to update /etc/fstab.

# lsblk /dev/sde
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sde      8:64   0 931.5G  0 disk 
└─sde1   8:65   0 931.5G  0 part 
```

Create the Filesystem:

```
# mkfs.ext4 -L pidata /dev/sde1
mke2fs 1.45.5 (07-Jan-2020)
/dev/sde1 contains a xfs file system
Proceed anyway? (y,N) y
Creating filesystem with 244190208 4k blocks and 61054976 inodes
Filesystem UUID: 6b83142f-374a-43d5-996a-a0bab5c3c56f
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
	102400000, 214990848

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done

# lsblk --fs /dev/sde
NAME   FSTYPE FSVER LABEL  UUID                                 FSAVAIL FSUSE% MOUNTPOINT
sde                                                                            
└─sde1 ext4   1.0   pidata 6b83142f-374a-43d5-996a-a0bab5c3c56f

```

Test:

```
# mkdir -p /mnt/data
# mount -o defaults /dev/sde1 /mnt/data/
# mount | grep sde1
/dev/sde1 on /mnt/data type ext4 (rw,relatime)

# cd /mnt/data/
# cd -
# umount /dev/sde1
```

### NTFS

```
[root@elaine ~]# parted -l
Model: SABRENT  (scsi)
Disk /dev/sdd: 120GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name                  Flags
 1      1049kB  630MB   629MB   fat32        EFI System Partition  boot, esp
 2      630MB   1704MB  1074MB  ext4
 3      1704MB  120GB   118GB  

[root@elaine ~]# parted /dev/sdd  mklabel msdos
Warning: The existing disk label on /dev/sdd will be destroyed and all data on this disk will be lost. Do you want to continue?

Yes/No? Yes                                                               
Information: You may need to update /etc/fstab.

[root@elaine ~]# parted /dev/sdd
GNU Parted 3.3
Using /dev/sdd
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) print
Model: SABRENT  (scsi)
Disk /dev/sdd: 120GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:

Number  Start  End  Size  File system  Name  Flags


[root@elaine ~]# lsblk /dev/sdd
NAME MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdd    8:48   0 111.8G  0 disk


[root@elaine ~]# mkfs.ntfs -L adata /dev/sdd1
Cluster size has been automatically set to 4096 bytes.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.

[root@elaine ~]# lsblk  /dev/sdd
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdd      8:48   0 111.8G  0 disk
└─sdd1   8:49   0 111.8G  0 part
[root@elaine ~]# lsblk -f /dev/sdd
NAME   FSTYPE FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINT
sdd
└─sdd1 ntfs         adata 1F37C1C72EA97858

[root@elaine ~]# mount -o defaults  /dev/sdd1 /mnt/data/
[root@elaine ~]# cd /mnt/data/
[root@elaine data]# ll
total 0
[root@elaine data]# touch aa
[root@elaine data]# ll
total 0
-rwxrwxrwx 1 root root 0 Jan  9 21:04 aa

```
