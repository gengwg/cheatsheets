### Shortcuts
```
9   decrease volume
0   increase volume
```

### mplayer has no sound

```
aptitude install alsa-utils
```

then, run `alsamixer` as root, and press `m` in each channel to unmute!

may also need install `pulseaudio`.

### play online radio

`mplayer <radio url>`

The IP-address of an online radio station can be found over at Xat radio search:  
https://www.xatworld.com/radio-search/

For example, search 'classical', then 'Get IP':  
http://184.173.142.117:30228/stream

Then,  
mplayer http://184.173.142.117:30228/stream
