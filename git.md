## Notes

## Git ignore files

https://github.com/github/gitignore

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

### Generate a Git patch for a commit

```
git format-patch -1 <sha>
```

Example:

```
$ git format-patch -1 HEAD
0001-Fix-slurmd-fails-to-autostart-by-systemd-on-boot.patch

$ cat 0001-Fix-slurmd-fails-to-autostart-by-systemd-on-boot.patch
From e4965bd270df3ac149ec14e31755693ab15d5608 Mon Sep 17 00:00:00 2001
From: W Geng <gengwg@users.noreply.github.com>
Date: Tue, 31 Jan 2023 23:55:48 -0800
Subject: [PATCH] Fix slurmd fails to autostart by systemd on boot

Slurm fails to autostart by systemd on CentOS 8 machines after reboot. Had to manually start the service.

It seems some transient network or some other problems during the boot time caused slurmd to fail to start. However later it doesn't try restart after failing. This is to add a retry, so that slurmd can be started after some transient error.
---
 etc/slurmd.service.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/etc/slurmd.service.in b/etc/slurmd.service.in
index 0a69d4cd63..250e2dce36 100644
--- a/etc/slurmd.service.in
+++ b/etc/slurmd.service.in
@@ -16,6 +16,8 @@ LimitMEMLOCK=infinity
 LimitSTACK=infinity
 Delegate=yes
 @SYSTEMD_TASKSMAX_OPTION@
+Restart=on-failure
+RestartSec=5

 # Uncomment the following lines to disable logging through journald.
 # NOTE: It may be preferable to set these through an override file instead.
--
2.31.1
```

To generate n patches from the topmost commits:

```
$ git format-patch -2 HEAD
0001-Fix-slurmd-fails-to-autostart-by-systemd-on-boot.patch
0002-Fix-slurmd-fails-to-autostart-by-systemd-on-boot-on-.patch
```

### Revert a commit already pushed

Reverting a commit means to create a new commit that undoes all changes that were made in the bad commit. Just like above, the bad commit remains there, but it no longer affects the the current master and any future commits on top of it.

Find the commit by:

```
$ git log
```

Revert it:

```
$ git revert 8c6f4c6b903851e6c37a70f87438e3a08183a434
[master e310ff9] Revert "Fix error rejected connection from EOF ServerName xxx"
 1 file changed, 1 insertion(+), 8 deletions(-)
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
```

Push to remote:

```
$ git push
```

### Update pull request in github

Just push more commits into the repo the request is for. The pull request will pick this up.

Example: 

```
$ git remote  -v
origin	git@github.com:gengwg/volcano.git (fetch)
origin	git@github.com:gengwg/volcano.git (push)
$ git add example/integrations/mpi/Dockerfile
$ git commit -m 'Update image to 22.04'
[master fb86b3476] Update image to 22.04
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git push
```

The PR will include those commits:

https://github.com/volcano-sh/volcano/pull/2714/commits

### How to Squash multiple commits into one

I followed the instructions [here](https://gist.github.com/lpranam/4ae996b0a4bc37448dc80356efbca7fa).

```
$ git rebase -i HEAD~3
[detached HEAD ada51107c] Fix MPI example not working in IPv6
 Author:
 Date: Mon Feb 27 19:35:17 2023 -0800
 1 file changed, 2 insertions(+), 2 deletions(-)
Successfully rebased and updated refs/heads/master.
```

You will see an output like this:

```
pick e3485e314 Fix MPI example not working in IPv6
pick f2a402e39 Update image to 22.04
pick c900b071e remove --mca option
```

Change it to like this. Note we can only squash newer commits into older commits.

```
pick e3485e314 Fix MPI example not working in IPv6
s f2a402e39 Update image to 22.04
s c900b071e remove --mca option
```

Here we will squash commit 2 and 3 into commit 1.

Verify by git log:

```
$ git log
commit ada51107c6717287d23c8cc1571bfb0f731fe595 (HEAD -> master)
Author: 
Date:   Mon Feb 27 19:35:17 2023 -0800

    Fix MPI example not working in IPv6

commit ada51107c6717287d23c8cc1571bfb0f731fe595 (HEAD -> master)
Author:
Date:   Mon Feb 27 19:35:17 2023 -0800

    Fix MPI example not working in IPv6

    Signed-off-by: gengwg <genwg@users.noreply.github.com>

    Update image to 22.04

    Signed-off-by: gengwg <genwg@users.noreply.github.com>

    remove --mca option

    Signed-off-by: gengwg <genwg@users.noreply.github.com>
```

Now to anytime after squashing if we want to push this changes into our origin/remote repository we need to push forcefully as we have rewritten the history.

```
$ git push -f
```

### Append sign off messages to commits

```
$ git rebase HEAD~3 --signoff
Current branch master is up to date, rebase forced.
Successfully rebased and updated refs/heads/master.
$ git push --force-with-lease origin master
# verify
$ git log
commit c900b071eaab86f3fc893c176828b11738ed4803 (HEAD -> master, origin/master, origin/HEAD)
Author: gengwg <genwg@users.noreply.github.com>
Date:   Tue Feb 28 23:26:18 2023 -0800

    remove --mca option

    Signed-off-by: gengwg <genwg@users.noreply.github.com>
```

### automatically set the upstream when pushing

If you often create new branches, you can tell Git to automatically set the upstream when pushing the first time:

git config --global push.autoSetupRemote true


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


