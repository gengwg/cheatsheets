## Configuring systemd user timer

https://www.xf.is/2020/06/27/configuring-systemd-user-timer/

By default, systemd will only run timers if the user is logged in so to be able to run timer jobs without logged in use we enable lingering session:

```
$ loginctl enable-linger gengwg
Could not enable linger: Access denied
$ sudo loginctl enable-linger gengwg
```

create a systemd service folder as the user:

```
$ mkdir -p ~/.config/systemd/user
$ cd ~/.config/systemd/user
```

Create a test script:

```
$ cat ~/bin/test.sh
#!/bin/bash

date > /tmp/mydate
```

Then you can drop the .service and .timer files in the ~/.config/systemd/user folder.

```
~/.config/systemd/user$ vim test.service
[Unit]
Description=Gengwg Test
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /home/gengwg/bin/test.sh
Environment=MY_CERT_PATH=/tmp

[Install]
WantedBy=default.target

~/.config/systemd/user$ vim test.timer
[Unit]
Description=Test

[Timer]
OnCalendar=*:0/5
Persistent=true

[Install]
WantedBy=timers.target
```

To pick up the job you’ll need to run (as the user)

```
$ systemctl --user daemon-reload
```

and then you can enable the timer with

```
$ systemctl --user enable test.timer --now
Created symlink /home/gengwg/.config/systemd/user/timers.target.wants/test.timer → /home/gengwg/.config/systemd/user/test.timer.
```

view the result with:


```
$ systemctl --user list-timers

$ systemctl --user status test.service
○ test.service - Gengwg Test
     Loaded: loaded (/home/gengwg/.config/systemd/user/test.service; disabled; preset: enabled)
     Active: inactive (dead) since Wed 2022-10-12 10:48:01 PDT; 11s ago
   Duration: 6ms
TriggeredBy: ● test.timer
    Process: 2322264 ExecStart=/bin/bash /home/gengwg/bin/test.sh (code=exited, status=0/SUCCESS)
   Main PID: 2322264 (code=exited, status=0/SUCCESS)
        CPU: 6ms
~/.config/systemd/user$ systemctl --user status test.timer
● test.timer - Test
     Loaded: loaded (/home/gengwg/.config/systemd/user/test.timer; enabled; preset: enabled)
     Active: active (waiting) since Wed 2022-10-12 10:45:33 PDT; 2min 42s ago
      Until: Wed 2022-10-12 10:45:33 PDT; 2min 42s ago
    Trigger: Wed 2022-10-12 10:50:00 PDT; 1min 44s left
   Triggers: ● test.service
```


Verify it creates the test file:

```
$ cat /tmp/mydate
Wed Oct 12 10:48:01 PDT 2022
```

To stop the systemd timer:

```
# seems disable doesn't work

$ systemctl --user disable backup-k8s.timer
Removed "/home/gengwg/.config/systemd/user/timers.target.wants/backup-k8s.timer".
$ systemctl --user list-timers backup-k8s.timer
NEXT                        LEFT          LAST                        PASSED  UNIT             ACTIVATES
Tue 2022-10-18 00:00:00 PDT 5h 48min left Mon 2022-10-17 00:00:04 PDT 18h ago backup-k8s.timer backup-k8s.service

1 timers listed.
Pass --all to see loaded but inactive timers, too.

# had to stop it

$ systemctl --user stop backup-k8s.timer
$ systemctl --user list-timers backup-k8s.timer
NEXT LEFT LAST PASSED UNIT ACTIVATES

0 timers listed.
Pass --all to see loaded but inactive timers, too.
```
