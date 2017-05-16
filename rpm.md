Use following syntax to list the files for RPM package:

    rpm -qlp package.rpm
    or
    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -t

List all info of a package:

    rpm -qipl redis-3.2.8-1.x86_64.rpm

List content of a single file from RPM (NOTE the dot infront of path):

    rpm2cpio redis-3.2.8-5.x86_64.rpm | cpio -iv --to-stdout ./opt/labs/redis/etc/redis7379.conf
