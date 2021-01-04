## Install Vim-Plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Uninstall plugins:

Delete the Plug line(s) from your .vimrc, source the .vimrc and call :PlugClean

Replace from current line till the end of file:

```
:.,$s/8080/9090/gc
```

Replace tabs with spaces:

```
:retab
```
