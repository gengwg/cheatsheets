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
