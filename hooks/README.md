# Hooks

Reusable Kiro hooks for safety guardrails. Copy these into any project's `.kiro/hooks/` directory.

## Available Hooks

| Hook | Event | Purpose |
|------|-------|---------|
| `git-commit-guard.json` | `preToolUse` (shell) | Blocks git commit/push/merge without explicit permission |

## How to Use

1. Copy the hook file into your project's `.kiro/hooks/` directory
2. Kiro will automatically enforce it during sessions

```bash
cp /path/to/agentic-toolkit/hooks/git-commit-guard.json /path/to/project/.kiro/hooks/
```

Or reference from the project's `.kiro-draft/hooks/` for staging before activation.

## Creating New Hooks

Hook schema:

```json
{
  "name": "Hook Name",
  "version": "1.0.0",
  "description": "What it does",
  "when": {
    "type": "preToolUse | postToolUse | fileEdited | fileCreated | promptSubmit | agentStop",
    "toolTypes": ["shell", "write", "read", "web", "*"],
    "patterns": ["*.ts", "*.php"]
  },
  "then": {
    "type": "askAgent | runCommand",
    "prompt": "For askAgent — instruction to the AI",
    "command": "For runCommand — shell command to execute"
  }
}
```

See Kiro documentation for full event types and tool categories.
