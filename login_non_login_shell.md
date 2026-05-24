# Login vs Non Login Shells

The shell program, for example Bash, uses a collection of startup scripts to create an environment. Each script has a specific use and affects the login environment differently. Every subsequent script executed can override the values assigned by previous scripts.

## Login shells

A Login shell is started after a successful login, using `/bin/login`, by reading the `/etc/passwd` file. Login shell is the first process that executes under our user ID when we log in to a session. The login process tells the shell to behave as a login shell with a convention: passing argument 0, which is normally the name of the shell executable, with a “-” character prepended. For example, for Bash shell it will be `-bash`.


When Bash is invoked as a Login shell;

1. Login process calls `/etc/profile`
2. `/etc/profile` calls the scripts in `/etc/profile.d/`
3. Login process calls `~/.bash_profile`
4. `~/.bash_profile` calls `~/.bashrc`
5. `~/.bashrc calls` /etc/bashrc`

Login shells include the following:

* Shells created by explicitly telling to login.

examples: `# su - | # su -l | # su --login | # su - USERNAME | # su -l USERNAME | # su --login USERNAME | # sudo -i`

* Shells created at login, including X login.

When you log in on a text console, or through SSH, or with su -, you get an interactive login shell. When you log in in graphical mode (on an X display manager), you don't get a login shell, instead you get a session manager or a window manager.

It's rare to run a non-interactive login shell, but some X settings do that when you log in with a display manager, so as to arrange to read the profile files. Other settings (this depends on the distribution and on the display manager) read /etc/profile and ~/.profile explicitly, or don't read them. Another way to get a non-interactive login shell is to log in remotely with a command passed through standard input which is not a terminal, e.g. `ssh example.com
<my-script-which-is-stored-locally` (as opposed to `ssh example.com my-script-which-is-on-the-remote-machine, which runs a non-interactive, non-login shell`).


On OSX, by default, the Terminal application runs a login shell. (As I explain, the program that starts the shell decides whether the shell acts as a login shell.) That's not the normal way to do things.

##  Non login shells

A Non login shell is started by a program without a login. In this case, the program just passes the name of the shell executable. For example, for a Bash shell it will be simply `bash`.

When bash is invoked as a Non login shell:

1. Non-login process(shell) calls ~/.bashrc
2. ~/.bashrc calls /etc/bashrc
3. /etc/bashrc calls the scripts in /etc/profile.d/

Non login shells include the following:

* Shells created using the below command syntax. examples: `# su | # su USERNAME`
* Graphical terminals
* Executed scripts
* Any other bash instances

When you start a shell in a terminal in an existing session (screen, X terminal, Emacs terminal buffer, a shell inside another, etc.), you get an interactive, non-login shell. That shell might read a shell configuration file (~/.bashrc for bash invoked as bash, /etc/zshrc and ~/.zshrc for zsh, /etc/csh.cshrc and ~/.cshrc for csh, the file indicated by the ENV variable for POSIX/XSI-compliant shells such as dash, ksh, and bash when invoked as sh, $ENV if set and ~/.mkshrc for mksh,
        etc.).

When a shell runs a script or a command passed on its command line, it's a non-interactive, non-login shell. Such shells run all the time: it's very common that when a program calls another program, it really runs a tiny script in a shell to invoke that other program. Some shells read a startup file in this case (bash runs the file indicated by the BASH_ENV variable, zsh runs /etc/zshenv and ~/.zshenv), but this is risky: the shell can be invoked in all sorts of contexts, and there's
hardly anything you can do that might not break something.

e.g. to start non-login shell

```
$ bash -lx
$ echo $0
+ echo bash
bash
```

## To tell if you are in a login shell

To tell if you are in login shell or non-login shell run: `echo $0`.

If the output is the name of our shell, prepended by a dash, then it is a login shell.
For example `-bash, -su, -l` etc. If the output is the name of our shell, does not prepend by a dash, then it is a Non login shell.
For example `bash, su` etc.

e.g:

```
$ echo $0
bash
$ exec -l bash

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
$ echo $0
-bash
```

In Bash, you can also use `shopt login_shell`:

```
$ shopt login_shell
login_shell     on
$ sudo su abc
[abc@server]$ shopt login_shell
login_shell     off
```
or

```
shopt -q login_shell && echo 'Login shell' || echo 'No login shell'
```

## Types of shells

* login shell: A login shell logs you into the system as a specified user, necessary for this is a username and password. When you hit ctrl+alt+F1 to login into a virtual terminal you get after successful login a login shell.
* non-login shell: A shell that is executed without logging in, necessary for this is a currently logged-in user. When you open a graphic terminal in gnome it is a non-login shell.
* interactive shell: A shell (login or non-login) where you can interactively type or interrupt commands. For example a gnome terminal.
* non-interactive shell: A (sub)shell that is probably run from an automated process. You will see neither input nor output.

So the cases are:

* `sudo su` Calls sudo with the command su. Bash is called as interactive non-login shell. So bash only executes `.bashrc`. You can see that after switching to root you are still in the same directory:

```
user@host:~$ sudo su
root@host:/home/user#
```

* `sudo su -` This time it is a login shell, so `/etc/profile, .profile and .bashrc` are executed and you will find yourself in root's home directory with root's environment.

* `sudo -i` It is nearly the same as `sudo su -` The `-i` (simulate initial login) option runs the shell specified by the password database entry of the target user as a login shell. This means that login-specific resource files such as .profile, .bashrc or .login will be read and executed by the shell.

* `sudo /bin/bash` This means that you call sudo with the command `/bin/bash`. `/bin/bash` is started as non-login shell so all the dot-files are not executed, but bash itself reads `.bashrc` of the calling user. Your environment stays the same. Your home will not be root's home. *So you are root, but in the environment of the calling user.*

* `sudo -s` reads the `$SHELL` variable and executes the content. If `$SHELL` contains `/bin/bash` it invokes `sudo /bin/bash` (see above).


