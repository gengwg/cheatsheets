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
