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
- `cmd + ^` to edit last message.
- `cmd + z` to unsend a message
- `cmd + <number>` to switch between workspaces
- `cmd + shift + enter` to add code snipts

you can transfer a public channel to private, but not private channel to public. by design.



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

