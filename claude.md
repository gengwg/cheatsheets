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

- only available in cc
- highest level contstruct. a fundle of features include mcp servers, skills, commands.
- most simple
- commands explicitly triggered
- most of the time start with plugins. e.g. ralph-loop.


```
/plugin marketplace update <marketplace>
/plugin update <plugin>@<marketplace>
/reload-plugins
```


## Skills

skills primarily focused on instuctions as markdown rather than tools.

- lightweight and simple
- 'progressive disclosure'; reduces context overhead
  - metadata: name + description
  - instructions: instructions
  - resources + code: 
- supports running scripts locally; an alternative to tools
- easy to make and share
- usually install as plugin
- triggering a skill is ad-hoc
- might replace mcp in claude code

- implemented with file system architecture: 
  - `.claude/skills/my-great-skill/{SKILL.md, more_stuff.md, scripts/scripts_in_any_lang.py}`
  - script itself is out of context.
  - works in home dir (all projects) or one projet only



## Print mode

`claude -p --tools "" "prompt"` fails with `Input must be provided`: `--tools` consumes the prompt. Pipe it instead:

```
echo "prompt" | claude -p --tools ""
```

Use your limit reset to reset it now: clau.de/reset

/usage-credits to request more usage from your admin.



    CLAUDE.md — always-on project standards
    Skills — task-specific expertise that loads on demand
    Hooks — automated operations triggered by events
    Subagents — isolated execution contexts for delegated work
    MCP servers — external tools and integrations

