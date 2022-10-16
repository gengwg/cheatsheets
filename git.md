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

