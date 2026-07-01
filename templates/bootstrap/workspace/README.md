# {{WORKSPACE_NAME}}

AI-assisted development workspace. Contains project-specific knowledge, artifacts, and context organized by project.

## Structure

```
{{WORKSPACE_NAME}}/
├── .kiro/
│   └── steering/
│       └── workspace-identity.md   # What this workspace is, project routing
├── projects/
│   ├── project-a/                  # First project
│   └── project-b/                  # Next project
├── scripts/
│   └── bootstrap-project.sh        # Scaffold new projects
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
make new-project name=project-code
```

## Projects

| Project | Directory | Code Repo | Status |
|---------|-----------|-----------|--------|
| — | — | — | — |
