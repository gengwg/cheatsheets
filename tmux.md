# tmux shortcuts & cheatsheet

```
❯ sudo apt install tmuxp
```

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

### Enable mouse support

```
❯ cat .tmux.conf

# Enable mouse support (scroll, select panes/windows, resize panes)
set -g mouse on
```

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


## tmuxp dev session (`~/.tmuxp/dev.yaml`)

Start the session (configs in `~/.tmuxp/` are found by name):

    ❯ tmuxp load dev

Detached (build now, attach later with `tmux attach -t dev`):

    ❯ tmuxp load dev -d

If the session already exists, tmuxp just re-attaches — safe to run twice.

```yaml
# ~/.tmuxp/dev.yaml — a beginner-friendly general-purpose dev session.
#
# Load it with:    tmuxp load dev        (configs in ~/.tmuxp/ are found by name)
# Detached:        tmuxp load dev -d     (build it, attach later with: tmux attach -t dev)
# If the session already exists, tmuxp just re-attaches — safe to run twice.

# The tmux session name (shows in `tmux ls` and the status bar).
session_name: dev

# Every window/pane starts in this directory unless overridden per-window.
# Change this to whatever project you're working on.
start_directory: ~/Aranya/metarepo

# Session-level tmux options (same names as in .tmux.conf).
options:
  allow-rename: false   # keep window names as defined here

windows:
  # ── Window 1: editor ─────────────────────────────────────────────
  # A single full-size pane running your editor.
  # `focus: true` makes the session open on this window.
  - window_name: edit
    focus: true
    panes:
      - nvim

  # ── Window 2: shell + git ────────────────────────────────────────
  # Two panes side by side: a working shell on the left, and a pane
  # that shows git status on the right. `layout` controls the split:
  #   even-horizontal = side by side, even-vertical = stacked,
  #   main-vertical  = one big left pane + small ones on the right.
  - window_name: shell
    layout: even-horizontal
    panes:
      - blank                      # "blank" = just an empty shell prompt
      - shell_command:
          - git status             # you can run several commands in order
          - git log --oneline -10

  # ── Window 3: kubernetes ─────────────────────────────────────────
  # k9s for browsing the cluster, plus a spare shell below it for
  # ad-hoc kubectl commands. main-horizontal = big top pane, small bottom.
  - window_name: k8s
    layout: main-horizontal
    panes:
      - k9s
      - blank

  # ── Window 4: monitor ────────────────────────────────────────────
  # Simple system monitor in a single pane.
  - window_name: top
    panes:
      - top
```
