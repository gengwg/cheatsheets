Use following syntax to list the files for RPM package:

    rpm -qlp package.rpm
    or
    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -t

List all info of a package:

    rpm -qipl redis-3.2.8-1.x86_64.rpm

List content of a single file from RPM (NOTE the dot infront of path):

    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -iv --to-stdout ./opt/labs/redis/etc/redis7379.conf

In general config files should be marked `%config(noreplace)`, unless the change being implimented is sufficiently major that a config file derived from a previous install is simpy not going to work. Even then it seens questionalble to me if installing a new 'default' configuration files is better or worse than leaving behind an edited one that may not work. 


## RPM or yum processes hang

Occasionally, the RPM database on a CloudLinux machine can become corrupted. It can happen when an RPM transaction is interrupted at a critical time. 

1. Kill all RPM and yum processes

```
ps -axwww | grep rpm
ps -axwww | grep yum
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

3. Rebuild the RPM database:

```
[root@myhost ]# rpm --rebuilddb
```

Now `yum` should bed able to run.

```
[root@myhost ]# yum clean expire-cache
Loaded plugins: fastestmirror
Cleaning repos: fb-runtime fbit-centos-fasttrack fbit-centos-hpe-mcp fbit-centos-hpe-mcp-old fbit-centos-os fbit-centos-updates fbit-fb-runtime fbit-fbit fbit-fbit-runtime
0 metadata files removed
```
### Check package updates

```
[sudo] dnf check-update
```
