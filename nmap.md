Scan a single Port  

    nmap -p 22 192.168.1.1

Scan a range of ports

    nmap -p 1-100 192.168.1.1

Scan 100 most common ports (Fast)

    nmap -F 192.168.1.1

Scan all 65535 ports  

    nmap -p- 192.168.1.1

Scan a subnet

    nmap 192.168.1.0/24

Scan targets from a text file

    nmap -iL list-of-ips.txt

If host is blocking ping probe:
    
    nmap -Pn abc.example.com

Quick way to find live hosts on my network

    nmap -sP 192.168.1.103/24

Scan all resolved ip addresses for a given domain name:
```
nmap -Pn  --script resolveall --script-args newtargets,resolveall.hosts=gwg.example.com

Starting Nmap 6.40 ( http://nmap.org ) at 2017-07-26 12:49 PDT
Pre-scan script results:
| resolveall:
|   Host 'opscnt-customer-crm.oneops.walmart.com' resolves to:
|     10.9.224.241
|     10.9.196.93
|_  Successfully added 2 new targets
Nmap scan report for 10.9.224.241
Host is up (0.0028s latency).
Not shown: 997 filtered ports
PORT     STATE  SERVICE
22/tcp   open   ssh
8443/tcp closed https-alt
8888/tcp open   sun-answerbook

Nmap scan report for 10.9.196.93
Host is up (0.00051s latency).
Not shown: 997 filtered ports
PORT     STATE  SERVICE
22/tcp   open   ssh
8443/tcp closed https-alt
8888/tcp closed sun-answerbook

Nmap done: 2 IP addresses (2 hosts up) scanned in 6.47 seconds
```

Usually the reason a port will appear as closed is that there is a no service listening on it but the firewall is not filtering access to the port. may be because a piece of software has at some point requested that these ports are opened and now no longer uses them.

```
Starting Nmap 6.40 ( http://nmap.org ) at 2017-07-26 12:03 PDT
Nmap scan report for xyz.abc.com (10.9.196.93)
Host is up (0.00056s latency).
Other addresses for xyz.abc.com (not scanned): 10.9.224.241
Not shown: 997 filtered ports
PORT     STATE  SERVICE
22/tcp   open   ssh
8443/tcp closed https-alt
8888/tcp closed sun-answerbook

Nmap scan report for 10.65.200.121
Host is up (0.052s latency).
Not shown: 997 filtered ports
PORT    STATE  SERVICE
22/tcp  open   ssh
443/tcp open   https
515/tcp closed printer
```
