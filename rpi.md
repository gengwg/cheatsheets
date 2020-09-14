## Burn Raspbian to SD card

```
root@elaine: pi $ unzip -p raspbian_latest | dd of=/dev/sdb bs=4M status=progress conv=fsync
4822335488 bytes (4.8 GB) copied, 526.777348 s, 9.2 MB/ss
0+43165 records in
0+43165 records out
4823449600 bytes (4.8 GB) copied, 614.552 s, 7.8 MB/s
```

## Configuration

update the mirror from here:

http://www.raspbian.org/RaspbianMirrors

```
$ cat  /etc/apt/sources.list
#deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi
deb http://mirrors.ocf.berkeley.edu/raspbian/raspbian stretch main contrib non-free rpi
```


## Nextcloud Installation on Raspberry Pi

http://unixetc.co.uk/2016/11/20/simple-nextcloud-installation-on-raspberry-pi/

### IP changes

```
pi@raspberrypi:/var/www/html/nextcloud/config $ sudo vim config.php
  array (
    0 => '192.168.1.76',
    1 => '162.228.89.113',
    0 => '192.168.1.104', <---
  ),
  'datadirectory' => '/var/nextcloud/data',
  'overwrite.cli.url' => 'http://192.168.1.104/nextcloud', <---
```

root@raspberrypi:/media/pi/Touro/nextcloud# mount --bind /media/pi/Touro/nextcloud/ /var/nextcloud/data/

### motion change data directory

```
sudo chown motion:adm /media/pi/Touro/motion/
sudo chmod 2750 /media/pi/Touro/motion/

# To test permission:
sudo -u motion touch /media/pi/Touro/motion/a
```

```
pi@raspberrypi:~ $ chromium-browser
 --disable-quic --enable-tcp-fast-open --disable-gpu-compositing --ppapi-flash-path=/usr/lib/chromium-browser/libpepflashplayer.so --ppapi-flash-args=enable_stagevideo_auto=0 --ppapi-flash-version=
[25247:25247:0829/154903.721881:ERROR:browser_main_loop.cc(670)] Failed to put Xlib into threaded mode.

(chromium-browser:25247): Gtk-WARNING **: cannot open display:
===>
pi@raspberrypi:~ $ export DISPLAY=:0.0

# install docker 
curl -sSL https://get.docker.com | sh

# install docker-compose
sudo pip install docker-compose
pi@raspberrypi:~$ docker-compose --version
docker-compose version 1.23.2, build 1110ad0
```
------------------------------------------------------
### 给树莓派安装中文输入法Fcitx及Google拼音输入法
```
sudo apt-get install fcitx fcitx-googlepinyin fcitx-module-cloudpinyin fcitx-sunpinyin

安装完毕，重启。
在preference那里找到Fcitx Configuration，点开，然后点击左下角的”+”号，找到你刚安装的google pinyin，添加之，It’s done, guys.
```

### disable the blank screen

```
vi /etc/lightdm/lightdm.conf
and in the [SeatDefaults] section add or uncomment this line:
xserver-command=X -s 0 -dpms

reboot
```

### connect rpi to tv or monitor via hdmi. picture doesn't fill the enire size of the screen.
```
===>
vim /boot/config.txt
uncomment
# disable_overscan = 1

In TV remote, 'Home' > 'Picture' > 'Aspect Ratio' > Choose 'Just Scan'.
```

recover/reset forgotten Gnome Keyring Password

```
cd ~/.local/share/
cp -rp keyrings keyrings.bak
cd keyrings
rm -f *
```

Next time you log in, it will ask to create a new keyring with new password.


Add user

```
$ sudo adduser username
```
