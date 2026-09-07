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
{
  "command": "/home/user/.local/bin/uvx"
}
```

Pre-download the package first so the first connect isn't slow/timing out:
```bash
/home/user/.local/bin/uvx mcp-atlassian --help   # downloads + caches on first run
```

### Gotcha (Windows + WSL): Kiro can't launch a Linux binary directly → "Connection closed"

If Kiro runs on **Windows** but the MCP server binary lives inside **WSL** (config path like `\\wsl.localhost\Ubuntu-20.04\...`, command like `/home/user/.local/bin/uvx`), pointing `command` straight at the Linux path fails with `MCP error -32000: Connection closed`. Windows can't execute a Linux binary, so the child process dies before the MCP handshake.

**Fix:** launch through `wsl.exe`, which crosses into the Linux environment:
```json
{
  "mcpServers": {
    "atlassian": {
      "command": "wsl.exe",
      "args": [
        "-d", "Ubuntu-20.04", "--",
        "/home/user/.local/bin/uvx", "mcp-atlassian",
        "--env-file", "/home/user/path/to/.kiro/settings/mcp-jira.env"
      ],
      "disabled": false,
      "autoApprove": ["jira_get_issue", "jira_search", "jira_get_all_projects"]
    }
  }
}
```

- The distro name after `-d` must match `wsl -l -q` **exactly** (e.g. `Ubuntu-20.04`), or the launch fails the same way.
- Paths passed to the Linux command (binary, `--env-file`) must be **Linux paths**, not Windows `\\wsl.localhost\...` paths.
- Verify the whole chain by hand before blaming Kiro: `curl -su "user:token" https://<site>.atlassian.net/rest/api/3/myself` (HTTP 200 = creds/network fine), then run the exact `uvx ... mcp-atlassian --env-file ...` command inside WSL and confirm it prints `Jira configuration loaded` / `Read-only mode: ...`.

### Keeping secrets out of `mcp.json` with `--env-file`

`mcp-atlassian` accepts `--env-file <path>`, so credentials can live in a separate env file instead of inline `env` in `mcp.json`. Cleaner, and scales when adding Confluence (same server — just add `CONFLUENCE_*` vars).

`.kiro/settings/mcp-jira.env`:
```
JIRA_URL=https://your-site.atlassian.net
JIRA_USERNAME=you@example.com
JIRA_API_TOKEN=<token>
# CONFLUENCE_URL=https://your-site.atlassian.net/wiki
# CONFLUENCE_USERNAME=you@example.com
# CONFLUENCE_API_TOKEN=<token>
READ_ONLY_MODE=true
FASTMCP_LOG_LEVEL=ERROR
```

- One env file per **server family**, not per service — Jira and Confluence are the **same** `mcp-atlassian` server, so they share one env file. There is no separate "confluence server" to configure.
- Kiro reads only `mcp.json` (workspace or user). You **cannot** split config into `jira-mcp.json` / `confluence-mcp.json` — arbitrary filenames are ignored. Multiple servers go as sibling entries under `mcpServers` in the one `mcp.json`.
- Gitignore the env file: add `*.env` and `.kiro/settings/*.env` to `.gitignore`.

### Gotcha: `READ_ONLY_MODE` controls writes, `autoApprove` does not

`READ_ONLY_MODE=true` disables all write tools (create/update/delete) **at the server level** — the server log prints `Read-only mode: ENABLED/DISABLED` on boot. `autoApprove` only controls which tools skip the confirmation prompt; it does **not** make anything read-only. Use `READ_ONLY_MODE=true` as the safe default and flip to `false` only when you actually need to create/update issues, then reconnect.

- **Typo trap:** the value must be exactly `true`/`false`. A stray character (e.g. `falses`) is not a valid boolean and silently fails to enable writes. Confirm via the boot log line, not by assuming.

### Gotcha: duplicate `atlassian` entry in user + workspace config

If the same server key (e.g. `atlassian`) exists in **both** `~/.kiro/settings/mcp.json` (user) and `<workspace>/.kiro/settings/mcp.json` (workspace), configs merge by key and the workspace wins — but the duplicate causes ambiguous/stale connection state and reconnect confusion. Keep a project-scoped credentialed server in the **workspace** config only, and remove it from the user config (`{ "mcpServers": {} }` if it was the only one).

### Reconnect after editing the config

Kiro reloads MCP config on save, but a manual reconnect is reliable after edits — **especially after editing the `--env-file`**, since env changes (like flipping `READ_ONLY_MODE`) only take effect on reconnect.

- Command Palette (`Ctrl+Shift+P`) → `Kiro: Open workspace MCP config (JSON)` (note the `Kiro:` prefix — searching just "MCP" may not surface it), then `Ctrl+S` to re-trigger the connection.
- Or use the **MCP Servers** section in the Kiro feature panel (left Activity Bar → Kiro icon) and reconnect the server row directly.

### Security

- The API token sits in plaintext in `mcp.json`. Ensure it's gitignored (`.kiro/settings/*.json`) and verify with `git check-ignore -v .kiro/settings/mcp.json` and `git ls-files .kiro/settings/` (should return nothing).
- Keep write-capable tools **out** of `autoApprove` (e.g. `jira_update_issue`, `jira_add_worklog`) so creates/updates on shared systems always prompt.
- Rotate the token if it was ever committed or shared in plaintext.
