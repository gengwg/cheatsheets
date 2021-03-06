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
