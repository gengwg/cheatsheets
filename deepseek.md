Upgrade Deepseek Harness

```
npm install -g @deepseek-ai/dsh@latest
```

Then, Control C and restart.

Headless mode:

```
❯ dsh --profile headless "What is 17 * 23?"
17 × 23 = **391**
```

Silence the `allow-scripts` warning on every global install:

```
npm config set allow-scripts=@deepseek-ai/dsh-subprocess-local,koffi,node-pty,@google/genai,protobufjs --location=user
```

The remaining `node-domexception` deprecation is a transitive dep of
`@google/genai`; unfixable locally, harmless.

Profiles live in `~/.dsh/profiles/<name>`. A profile is created on first use:

```
dsh --profile headless "..."     # scaffolds ~/.dsh/profiles/headless
```

Check what a profile actually composes to, without booting it:

```
dsh --profile web --dump-config
```

Plugins need pnpm. Install, then activate in the profile's
`cordis.patch.yml`:

```
npm install -g pnpm
dsh plugin --profile web add dsh-kubectl-guard
```

```yaml
- insert:
    - id: kubectl-guard
      name: dsh-kubectl-guard
```

Add plugin:

```
dsh plugin --profile web list dsh-cursor-subscription --depth 0
```

Disable one plugin for a single run:

```
dsh web --patch <(echo '- id: kubectl-guard
  disabled: true')
```

`EADDRINUSE` on 3080 means an instance is already up, not a bug:

```
ss -ltnp | awk '$4 ~ /:3080$/'
```

## Start `dsh web` at boot

Create `~/.config/systemd/user/dsh-web.service`:

```ini
[Unit]
Description=DeepSeek Harness Web UI

[Service]
Type=simple
WorkingDirectory=/home/gengwg/projects
Environment=PATH=/home/gengwg/.local/bin:/usr/local/bin:/usr/bin:/bin
ExecStart=/home/gengwg/.local/bin/dsh web --no-open
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

Enable it for future boots. Lingering lets it start before login:

```
sudo loginctl enable-linger "$USER"
systemctl --user daemon-reload
systemctl --user enable dsh-web.service
```

To replace a manually running instance now, stop it with Control C, then run:

```
systemctl --user start dsh-web.service
```

Check status and logs, including the fresh browser launch URL:

```
systemctl --user status dsh-web.service
journalctl --user -u dsh-web.service -n 50 --no-pager
```

## Prompts

See [prompts.md](prompts.md).
