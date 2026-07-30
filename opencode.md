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
