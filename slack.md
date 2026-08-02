## Commands 

https://necessary-eucalyptus-012.notion.site/Slack-Cheat-Sheet-Essential-Shortcuts-Tips-1a8cc15ed0d580bbb93be4ee7fe504f7

- `/remind` me to Breath in 10 minutes.
- `/remind @channel` to Breath at 10:20pm.
- `/dm @username` start a direct message with someone
- `/collapse` to hide all images and files in chat
- `/expande` to hide all images and files in chat
- `/mute #channel`
- `/leave #channel`
- `/search [keyword]`

(Keyboard shortcuts moved to the section below.)

you can transfer a public channel to private, but not private channel to public. by design.

## Keyboard shortcuts

Linux/Windows use `Ctrl`; on macOS swap in `Cmd`. `Ctrl + /` opens Slack's own full list in-app.

### Navigation

| Shortcut | Action |
|---|---|
| `Ctrl + K` | Quick switcher — jump to any channel/DM by typing |
| `Ctrl + <number>` | Switch between workspaces |
| `Ctrl + G` | Search |
| `Ctrl + F` | Search within the current channel |
| `Ctrl + Shift + D` | Toggle / hide the left sidebar (channels view) |
| `Ctrl + .` | Toggle the right pane (thread/details) |
| `Ctrl + [` / `Ctrl + ]` | History back / forward |
| `Alt + ↑` / `Alt + ↓` | Previous / next conversation |
| `Alt + Shift + ↑` / `Alt + Shift + ↓` | Previous / next **unread** conversation |

### Triage (unread sweeps, alert channels)

| Shortcut | Action |
|---|---|
| `Ctrl + Shift + A` | All unreads |
| `Ctrl + Shift + T` | Threads view |
| `Ctrl + Shift + M` | Activity (mentions & reactions) |
| `Ctrl + Shift + K` | DM list |
| `Ctrl + Shift + S` | Later / saved items |
| `C` | Clear the hovered/focused Activity item (the eraser icon) |
| `↓` / `Tab` in Activity | Move focus between items — chain with `C` to clear the whole list keyboard-only |
| `Esc` | Mark current channel read |
| `Shift + Esc` | Mark **all** channels read |
| `Alt + Click` a message | Mark unread from that message down |

Highest-leverage pair: `Ctrl + K` to never touch the sidebar again, and
`Alt + Shift + ↓` to walk unread channels one at a time, `Esc` to clear each as you go.

Draining Activity: `Ctrl + Shift + M`, then `↓` `C` `↓` `C` … all the way down. There is no
clear-**all** shortcut — the only batch path is the checkbox dropdown at the far left of the
Activity toolbar (*Select all* → clear), which is mouse-only.

### Composing

| Shortcut | Action |
|---|---|
| `↑` (empty input) | Edit your last message (`Cmd + ^` also works on macOS) |
| `Ctrl + Z` | Undo / unsend a message |
| `Ctrl + Shift + \` | Emoji reaction picker for the last message |
| `Ctrl + U` | Upload a file |
| `Shift + Enter` | Newline without sending |
| `Ctrl + B` / `Ctrl + I` | Bold / italic |
| `Ctrl + Shift + C` | Inline code |
| `Ctrl + Alt + Shift + C` | Code block |
| `Ctrl + Shift + Enter` | Insert a code snippet |
| `Ctrl + Shift + 9` | Blockquote |
| `Ctrl + Shift + 8` / `Ctrl + Shift + 7` | Bulleted / numbered list |
| `Ctrl + Shift + X` | Strikethrough |

### Misc

| Shortcut | Action |
|---|---|
| `Ctrl + Shift + H` | Start / join a huddle |
| `Ctrl + Shift + Space` | Mute / unmute in a huddle |
| `Ctrl + Shift + Y` | Set your status |
| `Ctrl + /` | Show all keyboard shortcuts |

## Apps

- Google Calendar (Turn on auto status update)
- Google Drive
- Forkable

## Notes

Pro Tip: Can forward company Emails to Slack channels!

Admin page:
https://<workspace>.slack.com/admin

team/project/task/1:1(coach)/channel

https://gale.udemy.com/certificate/UC-4ddb28fe-a52f-4cc1-8dff-eba0812c5d7d/

### quick way to send output of a command to a slack channel
https://github.com/juanpabloaj/slacker-cli

```bash
pip install slacker-cli

# you may add this to .bashrc
export SLACK_TOKEN="slack_token_string"

echo 'hello world' | slacker -c testhubot

# Use custom Sender name and custom Sender emoji icon
date | slacker -n SlackerBot -i :dancer: -c testhubot
echo 'This is a test' | slacker -n 'Your Name' -i :congratulations: -c testhubot
```

### emoji-cheat-sheet

https://www.webpagefx.com/tools/emoji-cheat-sheet/

- check
- looking into it

### # Channel Description Template

📌 **Purpose:** For updates, discussions, and progress tracking on Project X.

👥 **Who Should Join:** Team leads, designers, and developers.

🚀 **Guidelines:** Weekly check-ins, async updates only, no memes (unless really good).

## Message management

inbox 0:
  - notifications clear when responded
  - long term task add to 'save for later', then clear

