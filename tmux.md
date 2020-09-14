# tmux shortcuts & cheatsheet

// vim: tabstop=4 expandtab shiftwidth=4 softtabstop=4

start new session with name:

    tmux new -s myname

attach to named session:

    tmux a -t myname

detach a session:

    Ctrl + 'b', then press 'd'

list sessions:

    tmux ls

enter scroll mode:

    Ctrl+b [

then you can use your normal navigation keys to scroll around (eg. Up Arrow or PgDn). Press q to quit scroll mode, or Ctrl + C.

quit scroll mode:

    q

create another window:

    Ctrl+b c

list windows:

    Ctrl+b w

go to window #:

    Ctrl+b #

### Managing split panes

Creating a new pane by splitting an existing one:

    C-a "          split vertically (top/bottom)
    C-a %          split horizontally (left/right)

Switching between panes:

    C-a left       go to the next pane on the left
    C-a right      (or one of these other directions)
    C-a up
    C-a down
    C-a o          go to the next pane (cycle through all of them)
    C-a ;          go to the ‘last’ (previously used) pane

## Remap prefix to Control + a

```
$ cat .tmux.conf
# remap prefix to Control + a
set -g prefix C-a
# bind 'C-a C-a' to type 'C-a'
bind C-a send-prefix
unbind C-b
```

After you have made changes to your tmux configuration file in the ``~/.tmux.conf`` file, it shouldn’t be necessary to start the server up again from scratch with `kill-server`. Instead, you can prompt the current tmux session to reload the configuration with the source-file command.

This can be done either from within tmux, by pressing `Ctrl+B` and then ``:`` to bring up a command prompt, and typing:
```
:source-file ~/.tmux.conf
```
Or simply from a shell:
```
$ tmux source-file ~/.tmux.conf
set option: prefix -> C-a
```
