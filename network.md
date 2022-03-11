## CentOS 7 disable IPv6 SLAAC EUI-64 Address Generation

https://serverfault.com/questions/1045209/centos-disable-ipv6-slaac-eui-64-address-generation


Put `IPV6_AUTOCONF=no` both: 

- under the interface config. e.g. `/etc/sysconfig/network-scripts/ifcfg-eth0`;
- also in `/etc/sysconfig/network`.

Then the SLAAC was disabled completely and with that also the EUI-64 address
