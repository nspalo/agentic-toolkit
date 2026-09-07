# Tooling Setup

> Generic setup notes for tools used across projects. Reference when setting up a new machine or project.

## GitHub CLI (gh)

### Install (WSL Ubuntu 20.04)

```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

### Authenticate

```bash
gh auth login
# Choose: GitHub.com → HTTPS → Login with browser
```

### Common Commands

```bash
gh pr create --base development --title "TITLE" --body "BODY"
gh pr list
gh pr view <number>
gh pr merge <number> --squash
```

## Git Identity (per-repo via includeIf)

Use `[includeIf]` in `~/.gitconfig` to switch identity by directory:

```gitconfig
# Default: company identity
[user]
    name = Your Name
    email = work@company.com

# Personal projects
[includeIf "gitdir:/home/user/personal-projects/"]
    path = /home/user/.gitconfig-personal
```

`.gitconfig-personal`:
```gitconfig
[user]
    name = Your Name
    email = personal@gmail.com
```

### Per-repo override (alternative)

```bash
cd ~/path/to/repo
git config user.name "Your Name"
git config user.email "specific-email@example.com"
```

## CRLF → LF (Windows/WSL)

Fix in bulk:
```bash
find . -path ./.git -prune -o -type f \( -name "*.md" -o -name "*.yml" -o -name "*.php" -o -name "*.js" -o -name "*.vue" \) -print -exec sed -i 's/\r$//' {} \;
```

Prevention: `.gitattributes` with `* text=auto eol=lf`

## Zone.Identifier Files

Windows creates these when copying files into WSL. Remove and prevent:

```bash
find . -name "*Zone.Identifier" -type f -delete
echo "*Zone.Identifier" >> .gitignore
```

## WSL Safe Directory (for cross-filesystem access)

When opening WSL repos from Windows (via `\\wsl.localhost\...`), git needs safe directory entries:

```bash
git config --global --add safe.directory '%(prefix)///wsl.localhost/Ubuntu-20.04/home/user/path/to/repo'
```

## MCP Server Setup (Kiro)

MCP servers give Kiro extra tools (JIRA, docs, etc.). Config lives at either:
- Workspace: `<workspace-folder>/.kiro/settings/mcp.json` (scoped to that workspace)
- User: `~/.kiro/settings/mcp.json` (all workspaces)

Example (JIRA/Confluence via `mcp-atlassian`):
```json
{
  "mcpServers": {
    "atlassian": {
      "command": "/home/user/.local/bin/uvx",
      "args": ["mcp-atlassian"],
      "env": {
        "JIRA_URL": "https://your-site.atlassian.net",
        "JIRA_USERNAME": "you@example.com",
        "JIRA_API_TOKEN": "<paste-token-here>",
        "FASTMCP_LOG_LEVEL": "ERROR"
      },
      "disabled": false,
      "autoApprove": ["jira_get_issue", "jira_search", "jira_get_all_projects"]
    }
  }
}
```

### Gotcha: `uvx`/`command` not found → "Connection closed"

If the MCP log shows `Error connecting to MCP server: ... Connection closed` immediately after start, the launcher usually can't find the command. Kiro does **not** source your `.bashrc`, so a `command` that works in your interactive shell (because `.bashrc` adds it to PATH) fails when Kiro launches it.

**Fix:** use the **absolute path** to the binary in `command`, not the bare name:
```bash
which uvx        # e.g. /home/user/.local/bin/uvx
```
```json
"command": "/home/user/.local/bin/uvx"
```

Pre-download the package first so the first connect isn't slow/timing out:
```bash
/home/user/.local/bin/uvx mcp-atlassian --help   # downloads + caches on first run
```

### Reconnect after editing the config

Command Palette (`Ctrl+Shift+P`) → type "MCP" → reconnect; or use the MCP Servers section in the Kiro feature panel. Kiro reconnects on config change, but a manual reconnect is reliable after edits.

### Security

- The API token sits in plaintext in `mcp.json`. Ensure it's gitignored (`.kiro/settings/*.json`) and verify with `git check-ignore -v .kiro/settings/mcp.json` and `git ls-files .kiro/settings/` (should return nothing).
- Keep write-capable tools **out** of `autoApprove` (e.g. `jira_update_issue`, `jira_add_worklog`) so creates/updates on shared systems always prompt.
- Rotate the token if it was ever committed or shared in plaintext.
