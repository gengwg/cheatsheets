IPMI is a protocol for interacting with the Baseboard Management Controller. It's frequently used to query/toggle power states, check for hardware failures, and in an emergency can provide console (KVM) access.

You can directly connect to ipmi from the deploy server by specifying the hostname (or ip), the username, and password. IPMI should respond (by default) on UDP/623.

### query current power state

```
$ ipmitool -I lanplus -H <oob ip> -U root -P calvin chassis power status
Chassis Power is on
```
### set power on|off or reboot

```
$ ipmitool -I lanplus -H <oob ip> -U root -P calvin chassis power reset
Chassis Power Control: Reset
```

### activate serial console

```
$ ipmitool -I lanplus -H <oob ip> -U root -P calvin sol activate
[SOL Session operational.  Use ~? for help]
```

### query the system event log

```
$ ipmitool -I lanplus -H <oob ip> -U root -P calvin sel list
   1 | 12/17/2019 | 02:57:25 | Event Logging Disabled #0x72 | Log area reset/cleared | Asserted
   ...
  11 | 02/06/2020 | 18:30:50 | Power Supply #0xfb | Power Supply AC lost | Asserted
```

### Clear System Event Log

```
$ ipmitool -I lanplus -H <oob ip> -U root -P calvin sel clear
Clearing SEL.  Please allow a few seconds to erase.

$ ipmitool -I lanplus -H <oob ip> -U root -P calvin sel list
   1 | 02/10/2020 | 19:25:53 | Event Logging Disabled #0x72 | Log area reset/cleared | Asserted
```

### In order not to input password each time

put the password in the environment variable

```
$ read -p 'Password: ' -s IPMI_PASSWORD && export IPMI_PASSWORD
Password:
$ ipmitool -N1 -R1 -U <oob user> -E -I lanplus -H <oob ip> fru print 0x00
```

### Check OOB IPMI network info:

```
admin@<host>:~$  sudo ipmitool lan print 1
```

or check other hosts over LAN:

```
$ ipmitool -I lanplus -H <oob ip> -U <oob user> -P <oob password> lan print 1
```

### Fix SOL payload already active on another session

```
$ ipmitool -I lanplus -H <oob ip> -U <oob user> -P <oob pass> sol activate
[SOL Session operational.  Use ~? for help]
SOL session closed by BMC
$ ipmitool -I lanplus -H <oob ip> -U <oob user> -P <oob pass> sol activate
Info: SOL payload already active on another session
```

===>

Cold reset BMC:

```
$ ipmitool -I lanplus -H <oob> -U <oob user> -P <oob pass>  bmc reset cold
Sent cold reset command to MC
```

Wait a few minutes for it to reset, then try again.


### Check power supply PSU status

```
# ipmitool sdr type "Power Supply"
```

### List SEL as CSV format

```
$ sudo ipmitool -c sel list
```

### List IPMI users

```
$ sudo ipmitool user list 1
```

### To check BMC firmware version

```
# ipmitool mc info
```

### Error: Unable to establish IPMI v2 / RMCP+ session

```
$ ipmitool -I lanplus -H <oob> -U <oob user> -P <oob pass>  chassis power status
Error: Unable to establish IPMI v2 / RMCP+ session
```
===>

Specify IPMI to Use only IPv4 (using `-4` option)!

```
$ ipmitool -4 -I lanplus -H <oob> -U <oob user> -P <oob pass>  chassis power status
Chassis Power is on
```
