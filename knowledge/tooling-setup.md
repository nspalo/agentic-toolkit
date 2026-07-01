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
