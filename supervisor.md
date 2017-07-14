### Install and Manage Supervisor Debian 8
My debian version:
```bash
$ cat /etc/debian_version
8.8
```

#### Installation
```
# aptitude install supervisor
```

#### Create a simple script for test

```bash
$ vim radio.sh
#!/usr/bin/env bash
mplayer http://109.123.116.202:8022/stream

$ chmod +x radio.sh
```

#### Create Supervisor configuration files for the script
```
# cd /etc/supervisor/conf.d/
# vim radio.conf
[program:radio]
command=/home/gengwg/radio.sh
autostart=true
autorestart=true
# the log dirs must exist before start the program,
# supervisor will not create the missing dirs.
stderr_logfile=/var/log/radio.err.log
stdout_logfile=/var/log/radio.out.log
```

#### Read the configuration and reload Supervisor
```
# supervisorctl reread
radio: available
# supervisorctl update
radio: added process group
# supervisorctl status
radio                            RUNNING    pid 5381, uptime 0:00:06
```
Voila!
