# {{PROJECT_NAME}}

Project working directory for AI-assisted development on {{PROJECT_NAME}}.

## Directory Structure

```
{{PROJECT_NAME}}/
├── project-context.md          ← Load this at session start
├── .detected-stack.md          ← (temporary) Auto-detected info, delete after context is filled
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
└── .kiro-draft/                ← Draft steering files (see below)
    ├── steering/
    ├── hooks/
    └── skills/
```

## Getting Started

1. Fill `project-context.md` using `.detected-stack.md` (AI can help)
2. Delete `.detected-stack.md` once done
3. Load `project-context.md` at the start of each AI session
4. Place artifacts in the correct directories per conventions

## About .kiro-draft/

This directory contains **starter steering templates** for your project's `.kiro/` directory. They're scaffolded with placeholders — you don't need to fill them all immediately.

**When to use them:**
- After working on the project for a week or two and patterns emerge
- When you notice the AI making the same mistake repeatedly (that's a steering file waiting to happen)
- When you want to codify team conventions into the project repo

**How to use:**
1. Customize the templates based on your project's real conventions
2. Copy the useful ones into the project repo's `.kiro/steering/`
3. The originals stay here as backup/reference

You can also delete `.kiro-draft/` entirely if the project already has good `.kiro/steering/` files, or if you prefer to create steering files organically as needed.

See `agentic-toolkit/workflows/project-initialization.md` for guidance on which files different project types need.
