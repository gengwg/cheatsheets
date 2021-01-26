## Burn USB

```
sudo dd bs=4M if=./deepin-desktop-community-1002-amd64.iso of=/dev/sde status=progress oflag=sync
```

### Enable root account

useful when home partition got corrupted

```
sudo passwd root
```


