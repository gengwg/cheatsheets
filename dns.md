### Dig Reverse Lookup

Works for both IPv4 and IPv6.

```
dig -x <ipv4|ipv6> +short
```

Example:

```
$ dig AAAA google.com +short
2607:f8b0:4005:813::200e
$ dig -x 2607:f8b0:4005:813::200e +short
sfo03s27-in-x0e.1e100.net.
```
