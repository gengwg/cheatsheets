## Install and configure zsh

```
sudo apt install -y zsh
```

Make zsh default shell:
(Optional. OMZ will ask to do it.)

```
chsh -s $(which zsh)
```

## Install Oh My Zsh

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install OMZ Plugins 

```zsh
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Configure zsh

```
➜  ~ mv .zshrc .zshrc.orig
➜  ~ ln -s ./Nextcloud/bash_conf/zshrc .zshrc
➜  ~ ln -s ~/Nextcloud/bash_conf/aliases.zsh $ZSH_CUSTOM/aliases.zsh
```

## Install Powerlevel10k Theme

https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh

## Enable vi-mode

Add `vi-mode` to the plugins list in `~/.zshrc`:

```
plugins=(
  git
  vi-mode
  ...
)
```

Usage: `Esc` for Normal mode (`hjkl`, `w`/`b`, `dd`, `yy`, `p`, `u`, `v` to edit cmd in $EDITOR), `i`/`a` back to Insert mode.

vi-mode drops some default emacs bindings — restore history search at the end of `~/.zshrc`:

```
# vi-mode: restore emacs-style history bindings (Ctrl+R search, Ctrl+P/N)
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
```

Full-featured alternative (text objects, surround, visual mode): https://github.com/jeffreytse/zsh-vi-mode

## Keep tmux window names stable

oh-my-zsh auto-renames the terminal title on every command. Disable it so tmuxp window names stick (exported so tmuxp sees it):

```
export DISABLE_AUTO_TITLE="true"
```

## Ref

- https://www.bretfisher.com/shell/
