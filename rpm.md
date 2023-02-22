Use following syntax to list the files for RPM package:

    rpm -qlp package.rpm
    or
    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -t

List all info of a package:

    rpm -qipl redis-3.2.8-1.x86_64.rpm

List content of a single file from RPM (NOTE the dot infront of path):

    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -iv --to-stdout ./opt/labs/redis/etc/redis7379.conf

In general config files should be marked `%config(noreplace)`, unless the change being implimented is sufficiently major that a config file derived from a previous install is simpy not going to work. Even then it seens questionalble to me if installing a new 'default' configuration files is better or worse than leaving behind an edited one that may not work. 


## RPM or yum or dnf processes hang

Occasionally, the RPM database on a machine can become corrupted. It can happen when an RPM transaction is interrupted at a critical time. 

1. Kill all RPM and yum processes

```
ps -axwww | grep rpm
ps -axwww | grep yum
ps -axwww | grep dnf
```

In the list of processes, the first number on each line is the PID. 

```
kill -9 <PID>
```

2. Remove any RPM lock files (`/var/lib/rpm/__db*`):

```
[root@myhost ]# ll /var/lib/rpm/__db*
ls: cannot access /var/lib/rpm/__db*: No such file or directory
[root@myhost ]# ls /var/lib/rpm/.dbenv.lock
/var/lib/rpm/.dbenv.lock
[root@myhost ]# ll /var/lib/rpm/__db*
-rw-r--r-- 1 root root  442368 Mar 26 18:42 /var/lib/rpm/__db.001
-rw-r--r-- 1 root root  106496 Mar 26 18:42 /var/lib/rpm/__db.002
-rw-r--r-- 1 root root 1318912 Mar 26 18:42 /var/lib/rpm/__db.003

[root@myhost ]# rm /var/lib/rpm/__db*
rm: remove regular file ‘/var/lib/rpm/__db.001’? y
rm: remove regular file ‘/var/lib/rpm/__db.002’? y
rm: remove regular file ‘/var/lib/rpm/__db.003’? y
```

Or save it to some dir:

```
# mkdir rpm
# cd rpm
# mv /var/lib/rpm/__db* .
```

3. Rebuild the RPM database:

```
[root@myhost ]# rpm --rebuilddb
# db_verify /var/lib/rpm/Packages
BDB5105 Verification of /var/lib/rpm/Packages succeeded.
```

4. Now `yum` should bed able to run.

```
[root@myhost ]# # yum clean expire-cache
Cache was expired
0 files removed
```

[Ref](https://unix.stackexchange.com/questions/198703/yum-errorrpmdb-open-failed).


### Check package updates

```
[sudo] dnf check-update
```

## DNF

### Find what module provides a rpm package

```
# get module name
$ dnf module provides podman | grep Module

# search for the streams for the module
$ dnf module list | grep container-tools
```

### Enable dnf modules

```
$ sudo dnf module enable container-tools:rhel8
```

### List dependencies of a rpm package

```
dnf repoquery --requires <your package name>
```

### List the package contents for a rpm

```
dnf repoquery -l vim-enhanced
```

Or download and use rpm to query:

```
$ dnf download vim-enhanced
vim-enhanced-8.0.1763-19.el8.4.x86_64.rpm                                                                                    16 MB/s | 1.4 MB     00:00
$ rpm -qlp vim-enhanced-8.0.1763-19.el8.4.x86_64.rpm
/etc/profile.d/vim.csh
/etc/profile.d/vim.sh
/usr/bin/rvim
/usr/bin/vim
/usr/bin/vimdiff
....
```

If the package is installed, you can simply use: 

```
rpm -ql mypackage
```

You can also use --installed to query already installed packages using dnf repoquery:

```
$ dnf repoquery -l  mypackage --installed
```


### List all RPM packages in a repo

(RHEL 8 only.)

```
dnf repo-pkgs epel list
```

List  all RPM packages installed from a repo:
```
dnf repo-pkgs epel list installed
```

### List all software repositories ids and names

```
$ dnf repolist --all
```

### Mirror remote repo

Find repo id from above command, then:

```
dnf reposync --repoid=<repo id> --download-metadata -p <download path>
```

[Example](https://gist.github.com/gengwg/9eece444ca1757be307a7a7a32573279)


### Find which rpm package provides a specific file or library

```
# rpm -qf /etc/hosts
setup-2.8.71-11.el7.noarch
# rpm -q --whatprovides /etc/hosts
setup-2.8.71-11.el7.noarch
# yum whatprovides /etc/hosts
setup-2.8.71-11.el7.noarch : A set of system configuration and setup files
Repo        : centos-os
Matched from:
Filename    : /etc/hosts
```
