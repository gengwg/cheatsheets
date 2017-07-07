#### List all the files managed by `puppet`
```bash
$ sudo puppet agent --configprint resourcefile
/var/lib/puppet/state/resources.txt
$ cat /var/lib/puppet/state/resources.txt
```
or in one command:
```
$ sudo cat $(sudo puppet agent --configprint resourcefile)
```
