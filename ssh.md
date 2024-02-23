### turn off agent forwarding in ssh client

```
ssh -a myserver
```

### enable agent forwarding in ssh client

```
ssh -A myserver
```

### Local Forward:

```sh
# commands are on client
$ ssh -L2001:localhost:80 webserver
$ firefox http://localhost:2001/
```

e.g. 

Start http server on remote server:

```
[remote_host] $ python3 -m http.server
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

Set up local forwarding:

```
[local_host] $ ssh -L 8000:localhost:8000 -N remote_host
```

To not use `.ssh/confg`:

```
[local_host] $ ssh -F none -L 8000:localhost:8000 -N remote_host
```

### Remote Forward:

```sh
# on server, ssh to client
$ ssh -R2001:localhost:80 client
# on client
$ curl localhost:2001
```

### Forward X, the SSH server is masquerading as an X server.

```
$ ssh rpi
# display points to X proxy established by the SSH server.
pi@raspberrypi:~$ echo $DISPLAY
localhost:10.0
```
If you disable X forwarding by the `-x` option:

```
$ ssh -x rpi
pi@raspberrypi:~$ echo $DISPLAY
<empty>
```

### Using SSH-Agent

SSH askes pass phrase for private key:

```
user@host:~$ ssh server
Enter passphrase for key '/home/user/.ssh/id_rsa':
```

```
user@host:~$ eval `ssh-agent`
Agent pid 1957614
user@host:~$ ssh-add
Enter passphrase for /home/user/.ssh/id_rsa:
Identity added: /home/user/.ssh/id_rsa (/home/user/.ssh/id_rsa)
user@host:~$ echo 'kill $SSH_AGENT_PID' >> .bash_logout
```

Now you can ssh to server w/o password:

```
user@host:~$ ssh server
```

### Using SSH Certificates to Log In

Creating Your Own CA and Signing Keys With It

```
gengwg@local:~/ssh-ca$ ssh-keygen -t ecdsa -C "The CA" -N "" -f ca
Generating public/private ecdsa key pair.
Your identification has been saved in ca
Your public key has been saved in ca.pub
The key fingerprint is:
SHA256:pMkkl29Zgf3gQmobh2flbHURvZYq5kcU+YmovtocI1s The CA
The key's randomart image is:
+---[ECDSA 256]---+
|         o.   ++ |
|       .o +..o. .|
|    . ++.=.+..+ +|
|     ====o=..o * |
|     .+*So. . o  |
|      .. . o o   |
|       ..Eo o    |
|        *.o. .   |
|       o.+. .    |
+----[SHA256]-----+
gengwg@local:~/ssh-ca$ ls
ca  ca.pub

gengwg@local:~/ssh-ca$ ssh-keygen -t ecdsa -C "My Key" -N "" -f my-key
Generating public/private ecdsa key pair.
Your identification has been saved in my-key
Your public key has been saved in my-key.pub
The key fingerprint is:
SHA256:6GWVyAmQs+3NFcMsFaBDtUnewdliYzBbkm7FCX2nnOA My Key
The key's randomart image is:
+---[ECDSA 256]---+
|    .oo.O%==     |
|    o. *o@^oo .  |
|     +o.O*+O +   |
|    . .oo.E +    |
|     ..+S.       |
|     ..oo        |
|      .          |
|                 |
|                 |
+----[SHA256]-----+
gengwg@local:~/ssh-ca$ ll
total 16
-rw------- 1 gengwg gengwg 492 May 29 11:25 ca
-rw-r--r-- 1 gengwg gengwg 168 May 29 11:25 ca.pub
-rw------- 1 gengwg gengwg 492 May 29 11:25 my-key
-rw-r--r-- 1 gengwg gengwg 168 May 29 11:25 my-key.pub

gengwg@local:~/ssh-ca$ ssh-keygen -s ./ca -I testing-my-ca -n gengwg -V +1w -z 1 ./my-key.pub
Signed user key ./my-key-cert.pub: id "testing-my-ca" serial 1 for gengwg valid from 2022-05-29T11:25:00 to 2022-06-05T11:26:37

gengwg@local:~/ssh-ca$ lr
total 20
-rw-r--r-- 1 gengwg gengwg 168 May 29 11:25 ca.pub
-rw------- 1 gengwg gengwg 492 May 29 11:25 ca
-rw-r--r-- 1 gengwg gengwg 168 May 29 11:25 my-key.pub
-rw------- 1 gengwg gengwg 492 May 29 11:25 my-key
-rw-r--r-- 1 gengwg gengwg 817 May 29 11:26 my-key-cert.pub
```

Configure SSHD to Allow CA-signed Keys

```
root@remote:~# chown root:root /etc/ssh/ca.pub
root@remote:~# vim /etc/ssh/sshd_config
....
# Any key signed with this key can log in
#
TrustedUserCAKeys /etc/ssh/ca.pub
#
# Tell the server where to get a list of authorized Principals for each user.
#
AuthorizedPrincipalsFile /etc/ssh/auth_principals/%u
....

root@remote:~# mkdir -p /etc/ssh/auth_principals/
root@remote:~# echo -e "gengwg\n" > /etc/ssh/auth_principals/gengwg
```

Test

```
gengwg@local:~/ssh-ca$ ssh -i ./my-key-cert.pub raspberrypi.local

gengwg@local:~/ssh-ca$ ssh -i ./my-key-cert.pub xyz@raspberrypi.local
xyz@raspberrypi.local's password:
```

### To remotely obtain ssh host certificate(s)

```
$ ssh-keyscan -c raspberrypi.local
```

### To only get the host key(s)

```
$ ssh-keyscan raspberrypi.local
```

### To extract the certificate details, including the Signing CA's public key

```
ssh-keygen -L -f <certfile>
```


### SSH connection sharing

Place the ssh client into “master” mode for connection sharing.

```
$ ssh -Mf -o ControlPersist=yes -S /home/gengwg/.local/share/mytunnel.sock raspberrypi.local _
```

Now you can reuse the connection on multipe terminal!

```
$ ssh -o ControlPath=/home/gengwg/.local/share/mytunnel.sock raspberrypi.local

$ sftp -o ControlPath=/home/gengwg/.local/share/mytunnel.sock raspberrypi.local
Connected to raspberrypi.local.
sftp>
```

To make it even easier, you add these to your `.ssh/config`:

```
Host rpi
    HostName raspberrypi.local
    User gengwg
    ControlPersist yes
    ControlPath="/home/gengwg/.local/share/mytunnel.sock"
```

Now you can ssh to your server w/o anything!

```
$ ssh rpi
Last login: Sun Oct 16 12:35:15 2022 from xxxx

$ sftp rpi
Connected to rpi.
sftp> ^D
```

### Use the legacy SCP protocol

> I am used to pushing entire directories between machines with scp -r. Attempting to do it today resulted in an odd error that I have never seen before.

```
$ scp -r volcano/ dev:
scp: realpath ./volcano: No such file
scp: upload "./volcano": path canonicalization failed
scp: failed to upload directory volcano/ to .
```

> It happened for me when using a newish scp/ssh client (openssh 9.0) with an older RHEL/CentOS 8 ssh server (openssh 8.0).
> What fixed it for me was to force the scp into legacy mode with the -O flag, i.e.

```
gengwg@gengwg-mbp:~$ scp -r -O volcano/ dev:
```

Confirmed this is the case.

On client:

```
gengwg@gengwg-mbp:~$ ssh -V
OpenSSH_9.0p1, LibreSSL 3.3.6
```

On server:

```
$ sshd -V
unknown option -- V
OpenSSH_8.0p1, OpenSSL 1.1.1k  FIPS 25 Mar 2021
```

Man:

```
gengwg@gengwg-mbp:~$ man 1 scp

     -O      Use the legacy SCP protocol for file transfers instead of the SFTP protocol.  Forcing the use of the SCP protocol may be necessary for servers that do not implement SFTP, for backwards-compatibility for particular filename wildcard patterns and for expanding
             paths with a ‘~’ prefix for older SFTP servers.
```

## Auto login to server w/o 2fa

### Set up systemd timer to revert changes

1. Create a service file `/etc/systemd/system/ssh_max_sessions.service`:

```bash
[Unit]
Description=Increase SSH MaxSessions to 10
[Service]
ExecStart=/bin/bash -c "sed -i 's/MaxSessions 1/MaxSessions 10/g' /etc/ssh/sshd_config && systemctl restart sshd"
```

2. Create a timer file /etc/systemd/system/ssh_max_sessions.timer:

```
[Unit]
Description=Run ssh_max_sessions.service every 5 minutes
[Timer]
OnBootSec=5min
OnUnitActiveSec=5min
[Install]
WantedBy=timers.target
```

3. After creating or modifying the service and timer files, reload the systemd manager configuration, Enable and start the timer:

```
sudo systemctl daemon-reload
sudo systemctl enable ssh_max_sessions.timer
sudo systemctl start ssh_max_sessions.timer
```

### Set up ssh client connection sharing

This is run on Macbook. This only need run once every day beginning at work.

```
gengwg@gengwg-mbp:~$ grep dtun .bash_aliases
alias dtun='ssh -Mf -o ControlPersist=yes -S "/Users/gengwg/Library/Application Support/tunnel.sock" <SERVER NAME> echo -n'
```

### Update ssh config on Macbook

```
Host myserver
    #ControlMaster auto
    hostname <SERVER NAME>
    user gengwg
    ControlPersist yes
    ControlPath="/Users/gengwg/Library/Application Support/tunnel.sock"
```

You should now have the ability to `ssh myserver` across multiple terminals without being asked for two-factor authentication!
