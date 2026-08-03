$ tmux source-file ~/.tmux.conf
set option: prefix -> C-a


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
