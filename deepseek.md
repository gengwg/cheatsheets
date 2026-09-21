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

Disable one plugin for a single run:

```
dsh web --patch <(echo '- id: kubectl-guard
  disabled: true')
```

`EADDRINUSE` on 3080 means an instance is already up, not a bug:

```
ss -ltnp | awk '$4 ~ /:3080$/'
```

## Add a new agent preset for code review

Paste this in dsh web.

```
Add a new agent preset for code review
```
