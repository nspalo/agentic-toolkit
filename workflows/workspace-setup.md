# Workspace Setup

## Purpose

Create a new dev-context workspace repository for AI-assisted development. A workspace holds project-specific artifacts (investigations, test cases, tickets, knowledge) organized by project.

## When to Use

- Starting at a new company or context
- Starting a personal development workspace
- Separating contexts that shouldn't share a git repo

Most users should use the automated command:

```bash
cd ~/ai-workflow/agentic-toolkit
make workspace-new name=my-dev-context about="My projects"
```

This workflow documents what happens behind the scenes and provides a manual alternative.

## What a Workspace Is

A workspace repo is a **container** for project knowledge. It:
- Holds one or more project directories
- Has its own `.kiro/steering/` that routes artifacts to the correct project
- Has bootstrap scripts for adding/linking projects
- Is independent of the toolkit (toolkit provides methodology, workspace stores output)

## Automated Setup (Recommended)

```bash
cd ~/ai-workflow/agentic-toolkit
make workspace-new name=my-dev-context about="My projects"
```

What the script does:
1. Creates the workspace directory as a sibling to the toolkit
2. Copies the workspace template (Makefile, README, .gitignore, steering, scripts)
3. Initializes a git repository
4. Prints next steps

After running, follow the "Getting Started" steps in the main README (step 4 onward).

## Manual Setup (Alternative)

Use this if you need to place the workspace somewhere other than alongside the toolkit, or if the automated script isn't suitable.

### Create the directory structure

```bash
mkdir -p ~/ai-workflow/my-dev-context
cd ~/ai-workflow/my-dev-context
```

### Copy from template

```bash
TOOLKIT=~/ai-workflow/agentic-toolkit

cp "$TOOLKIT/templates/bootstrap/workspace/Makefile" ./Makefile
cp "$TOOLKIT/templates/bootstrap/workspace/README.md" ./README.md
cp "$TOOLKIT/templates/bootstrap/workspace/.gitignore" ./.gitignore

mkdir -p .kiro/steering
cp "$TOOLKIT/templates/bootstrap/workspace/.kiro/steering/workspace-identity.md" ./.kiro/steering/

mkdir -p scripts
cp "$TOOLKIT/templates/bootstrap/workspace/scripts/bootstrap-project.sh" ./scripts/
cp "$TOOLKIT/templates/bootstrap/workspace/scripts/link-project.sh" ./scripts/
cp "$TOOLKIT/templates/bootstrap/workspace/scripts/scaffold-steering.sh" ./scripts/
chmod +x ./scripts/*.sh

mkdir -p projects
```

### Customize templates

1. Edit `README.md` — replace `{{WORKSPACE_NAME}}` with your workspace name
2. Edit `.kiro/steering/workspace-identity.md` — replace placeholders with workspace name and context description

### Initialize git

```bash
git init
git config user.name "Your Name"
git config user.email "your-email@example.com"
```

### Continue with project setup

```bash
make project-new name=project-code
make project-link name=project-code repo=/path/to/code
```

Then open IDE and start a session (see main README steps 7-8).

## Workspace Naming

Name it based on context:

| Context | Possible names |
|---|---|
| Company work | `company-dev-context`, `work-workspace` |
| Personal projects | `personal-dev-context`, `dev-lab` |
| Freelance client | `client-dev-context`, `freelance-workspace` |

The name doesn't affect functionality — `.kiro/steering/workspace-identity.md` tells the AI what this workspace is.

## Multiple Workspaces

You can have as many workspace repos as needed:

```
~/ai-workflow/
├── agentic-toolkit/               # Always — methodology
├── company-dev-context/           # Company projects
├── personal-dev-context/          # Personal projects
└── freelance-dev-context/         # Freelance work
```

Each follows the same internal structure. The toolkit serves all of them.

## Path Requirement

The toolkit and dev-context must be siblings (same parent directory) because:
- `make project-new` calls `bootstrap-project.sh` which resolves the toolkit at `../agentic-toolkit`
- Templates are copied from the toolkit during project scaffolding

If you must place them elsewhere, update the `TOOLKIT_PATH` variable in the workspace's Makefile.
