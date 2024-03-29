## Install iTerm2

`brew install iterm2`

## Install dark theme for iTerm2

```
git clone https://github.com/dracula/iterm.git
```

### Activating theme

1.  _iTerm2 > Preferences > Profiles > Colors Tab_
2.  Open the _Color Presets..._ drop-down in the bottom right corner
3.  Select _Import..._ from the list
4.  Select the `Dracula.itermcolors` file
5.  Select the _Dracula_ from _Color Presets..._

### Warn before closing session.

Profile --> Default --> Session --> check 'always prompt before closing'.

this is to ensure command + W not accidentally closes tab. which is the same as closing tab in chrome!

### Change Font size

Profile > Default > Text > Font

![](images/iterm2/font.png)

General > Window > uncheck 'Ajust window when changing font size'

![](images/iterm2/font2.png)

### Disable the sound from iTerm2 in macOS

In the Profiles section, go to the Terminal tab in the right panel of the settings, then go down to the Notifications section and click the Silence bell option.

![](images/iterm2/bell.png)

### Enable Unlimited History in Terminal

![](images/iterm2/history.png)

### Install shell integration

```
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
```

https://gist.github.com/gengwg/71c1fe8cd9bb91752d87cd4cb7bd8656

### Integrate with password manager

https://medium.com/@ratchada.jududom/how-to-ssh-iterm2-with-password-manager-576b0452b493

## Shortcuts

`Cmd + ]` and `Cmd + [` navigates among split panes in order of use.

`⌘+⌥+←/↑/→/↓` will let you navigate split panes in the direction of the arrow.

`Cmd + <-` and `Cmd + ->` navigates among differnt tabs.

