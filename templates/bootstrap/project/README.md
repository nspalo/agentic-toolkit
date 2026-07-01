# {{PROJECT_NAME}}

Project working directory for AI-assisted development on {{PROJECT_NAME}}.

## Directory Structure

```
{{PROJECT_NAME}}/
├── project-context.md          ← Load this at session start
├── knowledge-base/             ← Engineering lessons learned
├── testcases/                  ← Structured test cases
├── technical-notes/
│   ├── jira/
│   │   ├── tickets/            ← JIRA ticket specs
│   │   ├── epics/              ← Epic definitions
│   │   └── proposals/          ← Design proposals
│   └── investigation/          ← Investigation reports
├── system-diagrams/            ← Architecture diagrams
├── documentation/              ← System docs, methodology
├── generated-files/            ← Output files (gitignored)
└── .kiro-draft/                ← Suggested steering for project's .kiro/
    ├── steering/
    └── hooks/
```

## Getting Started

1. Edit `project-context.md` with project-specific details
2. Load it at the start of each AI session
3. Place artifacts in the correct directories per conventions
