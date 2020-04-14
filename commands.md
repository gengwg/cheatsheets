remove `Icon?` files on mac

```
find ~/Documents -type f -name 'Icon?' -print -delete;
```

find default mail exchange server

```
$ dig dig +short qq.com MX
30 mx1.qq.com.
10 mx3.qq.com.
20 mx2.qq.com.
```

Show username with First letter capitalized:

```
$ echo ${USER^}
Gengwg
```

generate paste from command line

```
# need jf auth first
cat /var/chef/outputs/chef.last.out | pastry
# or-
pastry < /var/chef/outputs/chef.last.out
```

get username from userid

```
# getent passwd 3251333
gengwg:*:3251333:100:Tom Geng:/home/gengwg:/bin/bash
```

show all versions of rpm package:

```
yum --showduplicates list git
```

trim leading and trailing whitespace from each line of some output:

    $ cat slurm19.txt | awk '{$1=$1;print}'
    
  
