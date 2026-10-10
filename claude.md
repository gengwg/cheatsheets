## Install

https://code.claude.com/docs/en/desktop-linux

https://code.claude.com/docs/en/quickstart

`claude --continue` continues last session
`claude --resume` choose which session to continue
if already in claude code, use `/resume` to choose.

`/compact` for 

```
Tip: You're 92 turns deep and tracing a complex incident across multiple systems — context is getting heavy. /compact summarizes the earlier work so you can keep investigating without re-sending stale deta
```

`/rename [name]`: give another name for current session.

`/rewind`: to previous checkpoints.

`/resume`: to previous sessions.

`claude --dangerously-skip-permissions`: YOLO mode


## Using free models in claude code

```
export ANTHROPIC_DEFAULT_HAIKU_MODEL="z-ai/glm-5.2:free"
export ANTHROPIC_DEFAULT_SONNET_MODEL="z-ai/glm-5.2:free"
export ANTHROPIC_DEFAULT_OPUS_MODEL="z-ai/glm-5.2:free"
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
export ANTHROPIC_AUTH_TOKEN="sk-or-put-your-or-key-here"
export ANTHROPIC_API_KEY=""
claude --model z-ai/glm-5.2:free
```

## Claude Code Routines

https://claude.ai/code/routines


## Attribution trailers

In `settings.json` (user, project or local scope):

```json
{ "attribution": { "commit": "", "pr": "" } }
```

Empty strings drop the `Co-Authored-By` commit trailer and the PR description line. `includeCoAuthoredBy` is deprecated.

## Plugins

```
/plugin marketplace update <marketplace>
/plugin update <plugin>@<marketplace>
/reload-plugins
```

## Print mode

`claude -p --tools "" "prompt"` fails with `Input must be provided`: `--tools` consumes the prompt. Pipe it instead:

```
echo "prompt" | claude -p --tools ""
```
