### Keyboard shortcuts

#### Open Finder

`Cmd + Tab` and navigate to Finder.  
Then, `Cmd + Up`.  
This will take you into your Home directory.

### Fixing mac os yosemite issue "bash: fork: Resource temporarily unavailable"

see the current limits:
```
$ sysctl -a | grep maxproc
kern.maxproc: 1064
kern.maxprocperuid: 709
```

```
$ sudo sysctl -w kern.maxproc=4096
kern.maxproc: 1064
sysctl: kern.maxproc=4096: Invalid argument
```

===> maxproc is limited to 2500 with OS X unless you install OS X Server.

```
$ sudo sysctl -w kern.maxproc=2500
kern.maxproc: 1064 -> 2500
$ sudo sysctl -w kern.maxprocperuid=2400
kern.maxprocperuid: 1024 -> 2400

```

see the current limits:
```
$ sudo launchctl limit
	cpu         unlimited      unlimited
	filesize    unlimited      unlimited
	data        unlimited      unlimited
	stack       8388608        67104768
	core        0              unlimited
	rss         unlimited      unlimited
	memlock     unlimited      unlimited
	maxproc     709            1064
	maxfiles    256            unlimited
```

change to number above:
```
$ sudo launchctl limit maxproc 2400 2500
$ sudo launchctl limit maxfiles 512 unlimited
```

see the current limits:
```
$ sudo launchctl limit
	cpu         unlimited      unlimited
	filesize    unlimited      unlimited
	data        unlimited      unlimited
	stack       8388608        67104768
	core        0              unlimited
	rss         unlimited      unlimited
	memlock     unlimited      unlimited
	maxproc     2400           2500
	maxfiles    512            10240
```

Note this does not endure a reboot. To keep config after reboot:  
https://superuser.com/questions/836883/increasing-yosemite-maxfile-limit-for-application

### To override security settings and open the app from unidentified developer anyway

1. In the Finder, locate the app you want to open. 
2. Press the Control key, then click the app icon.
3. Choose Open from the shortcut menu.
4. Click Open.

### access usb disk
cd /Volumes/SANDISK

### kill a frozen program
cmd + space -> search 'monitor'
then choose Activity Monitor.
find that process and kill it, or force quit.

### get mouse out of vbox VM
press left cmd button

### view pdf from terminal
$ open myfile.pdf

### brew local install sshpass w/o access to sourceforge

On some server that has access sourceforge:
```
%) wget http://sourceforge.net/projects/sshpass/files/sshpass/1.06/sshpass-1.06.tar.gz
%) python -m SimpleHTTPServer 8000
```

On Mac:

    wget  https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb

Modify the url to the above server IP, where you set up a HTTP server.
```
  # url 'http://sourceforge.net/projects/sshpass/files/sshpass/1.06/sshpass-1.06.tar.gz'
  url 'http://10.93.81.178:8000/sshpass-1.06.tar.gz'
```

Brew local install.
```
$ brew install ./sshpass.rb
==> Downloading http://10.93.81.178:8000/sshpass-1.06.tar.gz
...
```

### connect to SMB (samba/CIFS) share
https://users.wfu.edu/yipcw/atg/apple/smb/

Go | Connect to Server

smb://servername/sharename
e.g.:
smb://192.168.1.70/gengwg


