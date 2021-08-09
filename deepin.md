## Burn USB

```
sudo dd bs=4M if=./deepin-desktop-community-1002-amd64.iso of=/dev/sde status=progress oflag=sync
```

### Enable root account

useful when home partition got corrupted

```
sudo passwd root
```

### Swap Caps Lock and Esc

1. To change mapping of Caps Lock, do this fist:

```
    gsettings set com.deepin.dde.keybinding.mediakey capslock '[]'
```

2. Then, you can re-map capslock with prefered layout-options.

Swap Caps Lock and Esc:

```
    gsettings set com.deepin.dde.keyboard layout-options '["caps:swapescape"]'
```

### Can not find boot device

Enable Compatibility Support Module in BIOS:

```
F12 --> Startup --> CSM mode --> Choose 'Enable'
```

