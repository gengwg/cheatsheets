Linux bash.

#### hostname

If a machine has multiple network interfaces/addresses or is used in a mobile environment, then it may either have multiple FQDNs/domain  names  or  none  at
all.  Therefore  avoid  using `hostname --fqdn`, `hostname --domain` and `dnsdomainname`.  `hostname --ip-address` is subject to the same limitations so it should be avoided as well.

```
-A, --all-fqdns
       Displays all FQDNs of the machine. This option enumerates all configured network addresses on all configured network interfaces, and  translates  them
       to  DNS  domain names. Addresses that cannot be translated (i.e. because they do not have an appropriate reverse IP entry) are skipped. Note that dif‐
       ferent addresses may resolve to the same name, therefore the output may contain duplicate entries. Do not make any assumptions about the order of  the
       output.

-i, --ip-address
       Display  the  network  address(es) of the host name. Note that this works only if the host name can be resolved. Avoid using this option; use hostname
       --all-ip-addresses instead.

-I, --all-ip-addresses
       Display all network addresses of the host. This option enumerates all configured addresses on all network interfaces. The loopback interface and  IPv6
       link-local  addresses  are omitted. Contrary to option -i, this option does not depend on name resolution. Do not make any assumptions about the order
       of the output.
```

e.g.:
```
# hostname -i
127.0.1.1
# hostname -I
172.22.55.44

# hostname -A
gengwg.homeoffice.example.com
```
