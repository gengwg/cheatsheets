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

## Ref

- https://www.bretfisher.com/shell/
