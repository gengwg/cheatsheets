## Install
yum install gcc
yum install rpm-build
yum install rubygem
yum install ruby-devel  (in debian: aptitude install ruby-dev)
gem install fpm

## Examples
```
[gengwg@proxy-1 temp]$ fpm -s gem -t deb fpm
Created package {:path=>"rubygem-fpm_1.1.0_all.deb"}
[gengwg@proxy-1 temp]$ ls
rubygem-fpm_1.1.0_all.deb
```

Option to remove directories after uninstall:
```
--directories /opt/redis \
```
