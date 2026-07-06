# {{WORKSPACE_NAME}}

AI-assisted development workspace. Contains project-specific knowledge, artifacts, and context organized by project.

## Structure

```
{{WORKSPACE_NAME}}/
├── .kiro/
│   └── steering/
│       └── workspace-identity.md   # What this workspace is, project routing
├── domain-knowledge/               # Shared knowledge across all projects
├── projects/
│   ├── project-a/                  # First project
│   └── project-b/                  # Next project
├── scripts/
│   ├── bootstrap-project.sh        # Scaffold new projects
│   ├── link-project.sh             # Scan repo and generate .detected-stack.md
│   └── scaffold-steering.sh        # Generate/select steering templates
├── Makefile                         # Project management commands
└── README.md
```

## Quick Start

### Start a session

1. Open workspace with project repo(s) + this repo + agentic-toolkit
2. Load project context: "Read `projects/{name}/project-context.md`"
3. Work normally — artifacts land in the project's directory

### Add a new project

```bash
make project-new name=project-code
make project-link name=project-code repo=/path/to/code
```

Then in a session: "Read `projects/project-code/project-context.md`"

### Generate steering files (optional)

```bash
make steering-generate project=project-code
```

Then in a Kiro session, the AI scans the codebase and fills the templates with real content.

## What Can I Do?

Once project-context.md is filled, you can use any of these toolkit workflows:

| Say... | What happens |
|---|---|
| "Investigate this issue" | Full investigation workflow → report in `technical-notes/investigation/` |
| "Fix this bug" | Bug-fix workflow → code changes in project repo |
| "Start a new feature" | Spec-driven development → requirements → design → tasks → code |
| "Create a PR" | PR workflow → branch → commit → push → PR |
| "Write a ticket" | JIRA template → ticket in `technical-notes/jira/tickets/` |

See `agentic-toolkit/knowledge/getting-started.md` for the full lifecycle.

## Projects

| Project | Directory | Code Repo | Status |
|---------|-----------|-----------|--------|
| — | — | — | — |

## Commands

```bash
make help               # Show available commands
make project-new        # Scaffold a new project (name= required)
make project-link       # Scan a repo and pre-fill context (name= repo= required)
make project-list       # List all project directories
make steering-generate  # AI-detected steering files (project= required)
make steering-select    # Pick from template list (project= required)
```
