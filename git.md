## Notes

### clone only some directories from a git repository

```
git init <repo>
cd <repo>
git remote add -f origin <url>

git config core.sparseCheckout true

echo "some/dir/" >> .git/info/sparse-checkout
echo "another/sub/tree" >> .git/info/sparse-checkout

git pull origin master
```

### Create a tag and push to remote

```
$ git tag -a v0.0.1 -m "release version 0.0.1"
$ git push origin --tags
```
### Enable Git Tab Autocomplete for Bash

```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```

Add the following line to the `~/.bashrc` file:

```
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
```

### Clone only the .git directory

Clone to a different location:

```
$ git clone git@github.com:gengwg/cheatsheets.git /tmp/cheatsheets
```

Move the .git to current location:

```
$ mv /tmp/cheatsheets/.git .
```

Clean up:

```
$ rm -rf /tmp/cheatsheets/
```

### Fix issue after merge PR

Put in commmit message or PR:

```
Fixes #88
```

### Add deploy key to a github repo

Generate the public and private rsa key pair.

```
$ ssh-keygen -t ed25519 -f .ssh/my-deploy-key -C "gengwg@example.com"
```

Copy the content of `.ssh/my-deploy-key.pub`.

From your repository, click Settings.

In the sidebar, click Deploy Keys, then click Add deploy key.

Example:

https://github.com/gengwg/cheatsheets/settings/keys

Provide a title, paste in your public key `.ssh/my-deploy-key.pub`.

Select Allow write access if you want this key to have write access to the repository. A deploy key with write access lets a deployment push to the repository.


## Workflow for creating pull request

check out repo and make changes

```
$ vim src/mycode.py
```

Create a new branch:

```
git checkout -b fix-foo
```

Commit changes:

```
git commit -am 'fix foo flaky'
```

push to upstream:

```
git push --set-upstream origin  fix-foo
```

This will create a pull request for you:

```
$ git push --set-upstream origin  fix-foo
....
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 495 bytes | 495.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
remote:
remote: Create a pull request for 'fix-foo' on GitHub by visiting:
remote:      https://github.com/gengwg/myrepo/pull/new/fix-foo # <-----
remote:
To github.com:gengwg/myrepo.git
 * [new branch]      fix-foo -> fix-foo
Branch 'fix-foo' set up to track remote branch 'fix-foo' from 'origin'.
```

### Add SSH Keys to GitHub

Without SSH Keys, one can not clone repo using git:

```
gengwg-mbp:~ gengwg$ git clone git@github.com:gengwg/cheatsheets.git
Cloning into 'cheatsheets'...
The authenticity of host 'github.com (64:ff9b::c01e:ff70)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
```

Steps:

1. Generate SSH Keys:

```
gengwg-mbp:~ gengwg$ ssh-keygen -f id_rsa_github_fb
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in id_rsa_github_fb
Your public key has been saved in id_rsa_github_fb.pub
The key fingerprint is:
The key's randomart image is:
```

Copy the *public* key:

```
gengwg-mbp:~ gengwg$ pbcopy < id_rsa_github_fb.pub
```

And paste it here:

https://github.com/settings/keys

Move the keys to .ssh where the permission is more strict. A more secure way is to add those keys to a password manager, and delete them. Only retrieve them from keepass when needing access. After adding them to keychain, and delete the retrieved copy. This way no local copy exists on your disk, only in memory. But that seems overkill.

```
drwx------    6 gengwg  staff   192 Nov 16 10:56 .ssh
gengwg-mbp:~ gengwg$ mv id_rsa_github_fb* .ssh/
```

Add *private* key to keychain:

```
gengwg-mbp:~ gengwg$ ssh-add .ssh/id_rsa_github_fb
Enter passphrase for .ssh/id_rsa_github_fb:
Identity added: .ssh/id_rsa_github_fb (gengwg@gengwg-mbp)
```

Now you can clone the repo using git:

```
gengwg-mbp:~ gengwg$ git clone git@github.com:gengwg/cheatsheets.git
Cloning into 'cheatsheets'...
remote: Enumerating objects: 1451, done.
remote: Counting objects: 100% (268/268), done.
remote: Compressing objects: 100% (135/135), done.
remote: Total 1451 (delta 155), reused 228 (delta 132), pack-reused 1183
Receiving objects: 100% (1451/1451), 5.07 MiB | 5.44 MiB/s, done.
Resolving deltas: 100% (862/862), done.
```

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


