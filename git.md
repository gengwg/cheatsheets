

## Errors

```
$ git push -u origin master
git@ghe.example.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```
===>

```
$ ssh-add /Users/gengwg/.ssh/id_rsa_ghe
Enter passphrase for /Users/gengwg/.ssh/id_rsa_ghe:
Identity added: /Users/gengwg/.ssh/id_rsa_ghe (ghe_ssh_key)
```
