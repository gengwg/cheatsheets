Resume the last session (run from the same project directory — sessions are project-scoped):
```
opencode -c          # short for --continue
```

Pick a specific session:
```
opencode session list          # shows all sessions + IDs for this project
opencode -s <sessionID>        # resume it
```

Inside the TUI itself you can also switch between sessions from the session list dialog, without exiting.                                                                                                  
## Authenticat MCPs using interactive OAuth

```
opencode mcp auth notion
opencode mcp auth granola
```

Each one opens your browser for the OAuth consent flow — approve access, and opencode stores the tokens for future sessions.

Handy related commands:

```
opencode mcp list           # shows all servers + connection/auth status
opencode mcp debug notion   # troubleshooting if the flow misbehaves
opencode mcp logout notion  # revoke stored credentials
```

`.config/opencode/opencode.jsonc`

```
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "slack": {
      "type": "local",
      "command": [
        "zsh",
        "-c",
        "set -a; source ~/.config/slack-mcp/token.env; set +a; exec npx -y slack-mcp-server@1.3.0 --transport stdio"
      ],
      "enabled": true
    },
    "gitlab": {
      "type": "remote",
      "url": "https://gitlab.com/api/v4/mcp",
      "enabled": true
    },
    "context7": {
      "type": "local",
      "command": ["npx", "-y", "@upstash/context7-mcp"],
      "enabled": true
    },
    "filesystem": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/home/gengwg/myfiles"],
      "enabled": true
    },
    "pdf": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-pdf", "--stdio"],
      "enabled": true
    },
    "blender": {
      "type": "local",
      "command": ["uvx", "blender-mcp"],
      "enabled": true
    },
    "kubernetes": {
      "type": "local",
      "command": ["npx", "-y", "mcp-server-kubernetes"],
      "enabled": true
    },
    "grafana": {
      "type": "local",
      "command": [
        "zsh",
        "-c",
        "set -a; source ~/.config/grafana-mcp/token.env; set +a; exec $HOME/.local/bin/mcp-grafana"
      ],
      "enabled": true
    },
    "desktop-commander": {
      "type": "local",
      "command": ["npx", "-y", "@wonderwhy-er/desktop-commander@latest"],
      "enabled": true
    },
    "notion": {
      "type": "remote",
      "url": "https://mcp.notion.com/mcp",
      "enabled": true
    },
    "granola": {
      "type": "remote",
      "url": "https://mcp.granola.ai/mcp",
      "enabled": true
    }
  }
}
```

Verify all connected:

```
❯ kubectl config view --flatten > ~/.kube/mcp-merged.yaml
❯ oc mcp list

┌  MCP Servers
│
●  ✓ slack connected
│      zsh -c set -a; source ~/.config/slack-mcp/token.env; set +a; exec npx -y slack-mcp-server@1.3.0 --transport stdio
│
●  ✓ gitlab connected
│      https://gitlab.com/api/v4/mcp
│
●  ✓ context7 connected
│      npx -y @upstash/context7-mcp
│
●  ✓ filesystem connected
│      npx -y @modelcontextprotocol/server-filesystem /home/gengwg/Aranya
│
●  ✓ pdf connected
│      npx -y @modelcontextprotocol/server-pdf --stdio
│
●  ✓ blender connected
│      uvx blender-mcp
│
●  ✓ kubernetes connected
│      npx -y mcp-server-kubernetes
│
●  ✓ grafana connected
│      zsh -c set -a; source ~/.config/grafana-mcp/token.env; set +a; exec $HOME/.local/bin/mcp-grafana
│
●  ✓ desktop-commander connected
│      npx -y @wonderwhy-er/desktop-commander@latest
│
●  ✓ notion connected
│      https://mcp.notion.com/mcp
│
●  ✓ granola connected
│      https://mcp.granola.ai/mcp
│
└  11 server(s)
```
