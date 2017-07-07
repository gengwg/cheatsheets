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
