## Install Vim-Plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Uninstall plugins:

Delete the Plug line(s) from your .vimrc, source the .vimrc and call :PlugClean

## Install Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then, Launch vim and run `:Plugin Install`

## Shortcuts

Replace from current line till the end of file:

```
:.,$s/8080/9090/gc
```

Replace tabs with spaces:

```
:retab
```

Delete all empty lines:

```
:g/^$/d
```
