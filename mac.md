## MacOS First Time Setup

### Install Homebrew

cmd + Tab search for 'terminal'

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### Install Cask

```
brew tap homebrew/cask
```

#### Brew Install Packages

```
brew cask install iterm2
brew cask install keepassx
brew cask install firefox
brew cask install caffeine
brew cask install docker

brew install watch
brew install trash-cli
brew install ansible
brew install wget
brew install nmap
brew install git
brew install mosh
brew install dict
brew install telnet
brew install vlc
(“VLC” can’t be opened because Apple cannot check it for malicious software.
Go to Security and click on 'Open Anyway')

# install latest java (10)
brew cask install java
# install latest java8
# To get a list of all older versions of java:  
brew tap caskroom/versions 
# then 
brew cask search java
brew cask install java8
```
### Configure iTerm2

Follow [here](https://github.com/gengwg/cheatsheets/blob/master/iterm2.md).

### Set up Shell/Vim/SSH

* Copy .bash_profile, .bashrc, .bash_aliases file to home dir.
* Copy vimrc to .vimrc
* Copy ssh_config

### Change default web browser to Chrome

* Choose System Preferences from the Apple () menu.
* Click General.
* Choose your web browser from the ”Default web browser” pop-up menu.

### Modify Key Mapping

* 'System Preferences' --> 'Keyboard' --> 'Modify Keys' --> Change 'Caps Lock' to 'Control'
* 'System Preferences' --> 'Keyboard': Touch Bar shows 'Extended Control Strip'


### Add Chinese Input Method

1. `System Preferences` --> Keyboard --> Input Sources --> + --> Choose `Chinese` on the left --> Select `Pinyin - Simplified`, press `Add`
2. Set up shortcut for switching input method: 
	* `System Preferences` --> `Keyboard` --> `Shortcuts` --> Check `Select previous input source`

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


### Keyboard shortcuts

|             Press             |                      Do This                      |
|:-----------------------------:|:--------------------------------------------------|
|         cmd + ctrl + q        | lock screen                                       |
| Command + Control + 4         | Save a Screenshot to local file                   |
| Command + Control + Shift + 4 | Save a Screenshot to the Clipboard                |
| Command + Shift + 5           | Screen recording                                  |

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

### To override security settings and open the app from unidentified developer

1. In the Finder, locate the app you want to open. 
2. Press the Control key, then click the app icon.
3. Choose Open from the shortcut menu.
4. Click Open.


###  Bypass running only apps from App store

> Your security preferences allow installation of only apps from the App Store and identified developers

If above methold not work,

Typically for a MacOS app, you have an executable under "<your.app>/Contents/MacOS". For example:
`/Applications/VNote.app/Contents/MacOS/VNote`

Finally you may want to add in `~/.bash_aliases`:  
```alias vnote='/Applications/VNote.app/Contents/MacOS/VNote'```

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


### connect to SMB (samba/CIFS) share
https://users.wfu.edu/yipcw/atg/apple/smb/

Go | Connect to Server

smb://servername/sharename
e.g.:
smb://192.168.1.70/gengwg

```
$ brew install htop
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
Error: Failure while executing: git config --local --replace-all homebrew.private true
===>
$ xcode-select --install
It will call the XCode installer for the command line developer tools. A window will open requesting for you to install them. All you have to do is click the install button
```

### Modify host file 
sudo vim /private/etc/hosts

