# Workspace Setup

## Purpose

Create a new workspace repository for AI-assisted development. A workspace holds project-specific artifacts (investigations, test cases, tickets, knowledge) organized by project. Each company or personal context gets its own workspace.

## When to Use

- Starting at a new company
- Starting a personal development workspace
- Separating contexts that shouldn't share a git repo

## What a Workspace Is

A workspace repo is a **container** for project knowledge. It:
- Holds one or more project directories
- Has its own `.kiro/steering/` that routes artifacts to the correct project
- Has a bootstrap script for adding new projects
- Is independent of the toolkit (toolkit provides methodology, workspace stores output)

## Setup Steps

### Step 1: Create the repo

```bash
mkdir ~/ai-workflow/your-workspace-name
cd ~/ai-workflow/your-workspace-name
git init
git config user.name "Your Name"
git config user.email "appropriate-email@example.com"
```

### Step 2: Copy the workspace template

```bash
# From the toolkit
cp -r path/to/agentic-toolkit/templates/bootstrap/workspace/* .
cp -r path/to/agentic-toolkit/templates/bootstrap/workspace/.kiro .
cp path/to/agentic-toolkit/templates/bootstrap/workspace/.gitignore .
```

### Step 3: Customize

1. Edit `README.md` — describe what this workspace is for
2. Edit `.kiro/steering/workspace-identity.md` — set the workspace context
3. Set up git remote on appropriate account (company or personal)

### Step 4: Add to IDE workspace

Add the new repo folder to your multi-root workspace alongside:
- The project code repo(s)
- The agentic-toolkit

### Step 5: Bootstrap first project

```bash
make new-project name=project-code
```

Then follow `workflows/project-initialization.md` to set up the project's steering.

## Workspace Naming Suggestions

Name it based on context:

| Context | Possible names |
|---|---|
| Company work | `biz-agentic`, `company-dev-notes`, `work-workspace` |
| Personal projects | `personal-dev`, `dev-lab`, `side-projects` |
| Freelance client | `client-workspace`, `freelance-notes` |

The name doesn't matter to the toolkit — the `.kiro/steering/workspace-identity.md` inside tells the AI what this workspace is.

## Multiple Workspaces

You can have as many workspace repos as you need:

```
~/ai-workflow/
├── agentic-toolkit/           # Always — methodology
├── company-workspace/         # Company projects
├── personal-workspace/        # Personal projects
└── freelance-workspace/       # Freelance work
```

Each follows the same internal structure. The toolkit serves all of them.
