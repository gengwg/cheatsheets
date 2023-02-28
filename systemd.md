## Notes

After= only tells Systemd what order it should start and stop services in. It doesn't tell it to automatically start the service. You should add Requires=google-startup-scripts.service to the redis unit file and then enable it. It will automatically run the google-startup-scripts first. If google-startup-scripts fails, then so will the redis service.

### Enabled vs Running

`systemctl list-unit-files | grep enabled` will list all enabled ones.

If you want which ones are currently running, you need `systemctl | grep running`.

Use the one you're looking for. Enabled, doesn't mean it's running. And running doesn't mean it's enabled. They are two different things.

`Enabled` means the system will run the service on the next boot. So if you enable a service, you still need to manually start it, or reboot and it will start.

`Running` means it's actually running right now, but if it's not enabled, it won't restart when you reboot.

### Using systemd drop-in units

There are two methods of overriding default Container Linux settings in unit files: 

- copying the unit file from /usr/lib64/systemd/system to /etc/systemd/system and modifying the chosen settings. 
- Alternatively, one can create a directory named unit.d within /etc/systemd/system and place a drop-in file overwrite.conf there that only changes the specific settings one is interested in. 
    * Note that multiple such drop-in files are read if present.

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
# run every 5 minutes
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

To start the systemd service immediately (vs wait for the timer to start it):

```
$ systemctl --user start backup-k8s.service
```

To check the status of the service:

```
$ systemctl --user status backup-k8s.service
● backup-k8s.service - Backup Kubernetes Clusters
     Loaded: loaded (/home/gengwg/.config/systemd/user/backup-k8s.service; disabled; preset: enabled)
     Active: active (running) since Tue 2022-10-18 13:38:51 PDT; 2s ago
TriggeredBy: ● backup-k8s.timer # not sure why it still says triggered by timer
   Main PID: 1320155 (bash)
         IO: 1.8M read, 12.0K written
      Tasks: 26
     Memory: 22.1M
        CPU: 981ms
     CGroup: /user.slice/user-193433.slice/user@193433.service/app.slice/backup-k8s.service
             ├─1320155 /bin/bash /home/gengwg/bin/backup-k8s.sh
             ├─1320157 bash ./kube-dump all -d mybackup
....
```

## Configuring systemd system timer

Exactly the same xxx.service and xxx.timer files, but located in `/etc/systemd/system`.

To enable it:

```
root@myserver:/etc/systemd/system# systemctl daemon-reload
root@myserver:/etc/systemd/system# systemctl enable test.timer
Created symlink /etc/systemd/system/timers.target.wants/test.timer → /etc/systemd/system/test.timer.
root@myserver:/etc/systemd/system# systemctl start test.timer
root@myserver:/etc/systemd/system# systemctl list-timers --all | grep test
Sat 2022-10-29 11:20:00 PDT 46s left       n/a                         n/a          test.timer                      test.service
```

Wait unti it ran at least once:

```
root@myserver:/etc/systemd/system# systemctl list-timers --all | grep test
Sat 2022-10-29 11:22:00 PDT 1min 34s left  Sat 2022-10-29 11:20:09 PDT 15s ago      test.timer                      test.service
```

Check it writes to the root dir (system managers runs as the root permission):

```
root@myserver:/etc/systemd/system# cat /mydate
2022年 10月 29日 星期六 11:20:09 PDT
```

If you specify the Install location at:

```
[Install]
WantedBy=multi-user.target
```

It will tell systemd to pull in the unit when starting the multi-user.target.

```
root@myserver:/etc/systemd/system# systemctl enable test.timer
Created symlink /etc/systemd/system/multi-user.target.wants/test.timer → /etc/systemd/system/test.timer.
```

To stop the system timer:

```
root@myserver:/etc/systemd/system# systemctl disable test.timer
Removed /etc/systemd/system/multi-user.target.wants/test.timer.
Removed /etc/systemd/system/timers.target.wants/test.timer.
root@myserver:/etc/systemd/system# systemctl list-timers --all | grep test
Sat 2022-10-29 11:32:00 PDT 1min 8s left   Sat 2022-10-29 11:30:02 PDT 48s ago      test.timer                      test.service
root@myserver:/etc/systemd/system# systemctl stop test.timer
root@myserver:/etc/systemd/system# systemctl list-timers --all | grep test
<nothing>

# cleanup
root@myserver:/etc/systemd/system# cat /mydate
2022年 10月 29日 星期六 11:30:02 PDT
root@myserver:/etc/systemd/system# rm /mydate
```

## Commands

systemd-cgls  provides a tree-style listing of the cgroups and processes that are running within them on the system.

systemd-cgtop. This shows a live display of current resource usage,

### Cat a service config:

```
sudo systemctl cat kube-apiserver
```

### Check journals disk usage

```
journalctl --disk-usage
Archived and active journals take up 11.2M in the file system.
````

### =- (equals minus) in systemd unit files

```
EnvironmentFile=-/run/sysconfig/mdadm
```

> The argument passed should be an absolute filename or wildcard expression, optionally prefixed with "-", which indicates that if the file does not exist, it will not be read and no error or warning message is logged.

### To list failed units/services

```
$ systemctl --failed
```

### Service does not start on reboot even if enabled

Add Restart=on-failure to your systemd unit file. e.g.:

```
[Service]
Restart=on-failure
RestartSec=5
```

> Restart=

> If set to on-failure, the service will be restarted when the process exits with a non-zero exit code

### See all runtime drop-in changes for system units

```
$ systemd-delta --type=extended
[EXTENDED]   /usr/lib/systemd/system/kubelet.service → /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
[EXTENDED]   /usr/lib/systemd/system/systemd-hostnamed.service → /usr/lib/systemd/system/systemd-hostnamed.service.d/disable-privatedevices.conf
[EXTENDED]   /usr/lib/systemd/system/systemd-logind.service → /usr/lib/systemd/system/systemd-logind.service.d/10-grub2-logind-service.conf
[EXTENDED]   /usr/lib/systemd/system/systemd-udev-trigger.service → /usr/lib/systemd/system/systemd-udev-trigger.service.d/systemd-udev-trigger-no-reload.conf
```

### Redirect log to different location

By default some logs are located in syslog, where they are polluted together with various other types of logs. You may want to move them to their separate location for easier management. To do that use this systemd drop-in file, e.g. '/etc/systemd/system/kubelet.service.d/10-redirect_log.conf':

```
[Service]
StandardOutput=append:/var/log/kubernetes/kubelet.log
StandardError=append:/var/log/kubernetes/kubelet.err
```

It's important to note that this feature [requires systemd version 236](https://github.com/systemd/systemd/pull/7198) or later. Therefore, you may consider restricting it to CentOS 8+ , which meets this requirement.

As this is a directory change, it is important to ensure that downstream consumers of the logs are made aware of this change and can adjust accordingly. However, I believe that this change will make it easier for them to filter the logs, as they will no longer need to use pattern matching in system logs. Instead, they will be able to work with pure Kubernetes logs, which should simplify the process.


