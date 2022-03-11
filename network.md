## CentOS 7 disable IPv6 SLAAC EUI-64 Address Generation

https://serverfault.com/questions/1045209/centos-disable-ipv6-slaac-eui-64-address-generation


Put `IPV6_AUTOCONF=no` both: 

- under the interface config. e.g. `/etc/sysconfig/network-scripts/ifcfg-eth0`;
- also in `/etc/sysconfig/network`.

Then the SLAAC was disabled completely and with that also the EUI-64 address

## NC Check If Port Open on Server

```
# linux
$ nc -vz theexample.com 443
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to 2a03:2880:fd44:xxxx:xxxx:xxxx:0::443.
Ncat: 0 bytes sent, 0 bytes received in 0.04 seconds.
$ nc -vz google.com 443
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connection to 2607:f8b0:4004:837::200e failed: Connection timed out.
Ncat: Trying next address...
Ncat: Network is unreachable.

# mac
$ nc -vz google.com 443
Connection to google.com port 443 [tcp/https] succeeded!
$ nc -vz google.com 6443 # twice is due to ipv6 and ipv4.
nc: connectx to google.com port 6443 (tcp) failed: Operation timed out
nc: connectx to google.com port 6443 (tcp) failed: Operation timed out
```

## Check which device and IP to use to reach an IPv6 address

```
$ dig AAAA google.com +short
2607:f8b0:4005:80e::200e
$ ip route get to 2607:f8b0:4005:813::200e
2607:f8b0:4005:813::200e via 2620:10d:xxxx:xxx dev eth0 src 2620:10d:xxxx:xxxx metric 1 pref medium
```

## Check IPv6 default route

```
ip -6 route list default
default via 2620:10d:xxxxxxxx dev eth0 metric 1 pref medium
default via fe80::200:xxxxxxx dev eth0 proto ra metric 1024 expires 466sec hoplimit 64 pref high
```

## Ipv6 show only dynamic or permanent addresses of an interface

```
$ ip -6 a sh eth0 dynamic
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 xxxxxxxx/64 scope global mngtmpaddr dynamic
       valid_lft 92sec preferred_lft 92sec
$ ip -6  a sh eth0 permanent
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP qlen 1000
    inet6 2620:xxxxxx/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::xxxx/64 scope link
       valid_lft forever preferred_lft forever
```
