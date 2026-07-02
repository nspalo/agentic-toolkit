# Getting Started — Agentic Development Workflow

## Overview

This document explains the full agentic AI-assisted development workflow — how the pieces fit together, how to start from scratch, and how the system evolves over time.

## The Three Layers

```
┌─────────────────────────────────────────────────────────┐
│  [project]/.kiro/              WHAT you're working with  │
│  (in the project repo)         Codebase conventions,     │
│                                architecture, tech stack   │
├─────────────────────────────────────────────────────────┤
│  [dev-context]/projects/{name}  WHERE work lives          │
│  (per-context repo)             Test cases, reports,      │
│                                 tickets, knowledge base   │
├─────────────────────────────────────────────────────────┤
│  agentic-toolkit/               HOW to work               │
│  (personal, portable)           Rules, workflows,         │
│                                 templates, methodology    │
└─────────────────────────────────────────────────────────┘
```

**Information flows:**
- Toolkit teaches the AI how to behave and what formats to use
- Project `.kiro/` teaches the AI about this specific codebase
- Dev-context receives the artifacts produced during work

## First Time Setup

### 1. Clone the toolkit

```bash
mkdir -p ~/ai-workflow
cd ~/ai-workflow
git clone <your-toolkit-repo> agentic-toolkit
```

### 2. Create your first dev-context workspace

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=company-dev-context context="Company projects"
```

This creates a new workspace repo alongside the toolkit with all scaffolding ready.

### 3. Set git identity

```bash
cd ~/ai-workflow/company-dev-context
git config user.name "Your Name"
git config user.email "your-email@example.com"
```

### 4. Bootstrap and link your project

```bash
cd ~/ai-workflow/company-dev-context
make new-project name=project-code
make link-project name=project-code repo=~/projects/my-project
```

### 5. Open IDE workspace

Add all three folders to one multi-root workspace:

```
IDE Workspace:
├── ~/projects/my-project/         # Code
├── ~/ai-workflow/company-dev-context/  # Artifacts
└── ~/ai-workflow/agentic-toolkit/      # Methodology
```

### 6. Start first session

Tell the AI: "Read `projects/project-code/.detected-stack.md` and help me fill in `project-context.md`"

Setup is complete when `project-context.md` has real content. Then you can commit.

## Starting a New Project

From inside your dev-context repo:

```bash
cd ~/ai-workflow/company-dev-context
make new-project name=project-code
make link-project name=project-code repo=/path/to/code
```

This scaffolds:
- `projects/{name}/project-context.md` — fill with project details
- `projects/{name}/.detected-stack.md` — auto-detected tech info from the linked repo
- `projects/{name}/.kiro-draft/` — suggested steering files to customize
- Empty directories for knowledge-base, testcases, etc.

Then start a session and say: "Read `projects/{name}/.detected-stack.md` and help me fill in `project-context.md`"

For deeper customization of steering files, see `workflows/project-initialization.md` which guides:
1. Which steering files the project needs based on its type
2. How to set inclusion types (auto vs manual vs fileMatch)
3. When to promote `.kiro-draft/` to the actual project `.kiro/`

## Starting a Session

1. Open workspace
2. Say: "Read `projects/{name}/project-context.md`"
3. Kiro auto-loads:
   - `agentic-toolkit/.kiro/steering/` (behavioral rules, naming conventions)
   - Dev-context `.kiro/steering/workspace-identity.md` (knows which project is active)
4. Work normally — artifacts land in the correct project directory

## During Work

| You want to... | What happens |
|---|---|
| Investigate a bug | Toolkit's investigation workflow. Report lands in `projects/{name}/technical-notes/investigation/` |
| Write a report | Toolkit's report standards + template. File: `REPORT-NN-short-name.md` in investigation dir |
| Groom tickets | Toolkit's JIRA templates (epic, story, task, bug). Files go to `projects/{name}/technical-notes/jira/` |
| Fix a bug | Toolkit's bug-fix workflow. Code changes in project repo, verified against test cases |
| Write tests | Tests live in the project repo (PHPUnit, Jest, Playwright). Follow project's testing conventions in `.kiro/steering/` |
| Document a test scenario | Toolkit's test-case template. File goes to `projects/{name}/testcases/TCNNN.md`. Use when verification is file-based (CSV compare, snapshot) rather than automated test code |
| Document a lesson | Toolkit's KB article template. File goes to `projects/{name}/knowledge-base/` |
| Create a PR | Toolkit's PR workflow. Commit conventions from toolkit. |

## The Investigation → Report → Ticket Flow

```
Investigation (gather facts, trace code)
        │
        ▼
   Gate 1: Is the report factual?
   (all claims backed by evidence, user acknowledges)
        │
        ▼
Report created (REPORT-NN-short-name.md)
        │
        ▼
   Gate 2: Is the report ready to become a ticket?
   (root cause verified, fix direction approved)
        │
        ▼
Ticket created (PROJ-XXX-description.md)
        │
        ▼
Implementation (bug-fix or spec workflow)
```

## The Lifecycle

```
Day 1:     make new-workspace → make new-project → empty skeleton
Week 1:    First investigation, first test cases, project-context filling up
Month 1:   Knowledge base growing, .kiro-draft refined for this project
Month 3:   .kiro-draft → promoted to project's actual .kiro/
Month 6:   Extract generic patterns back into toolkit (extract-to-toolkit workflow)
```

## How the Toolkit Adapts to New Projects

The toolkit provides **generic scaffolding**. When a new project starts:

1. Bootstrap creates the structure from templates
2. AI reads the project's initial code and docs
3. Based on what it learns, it customizes:
   - The project-context with specific commands, tables, architecture
   - The .kiro-draft/steering with project-specific conventions
   - Test case format based on how verification works for this project type

The toolkit doesn't need to know about Laravel vs React vs Python. It provides the **process** (investigate → validate → fix → verify → document). The project-specific details live in the dev-context and the project's `.kiro/`.

## Multiple Workspaces

You can have as many dev-context repos as needed:

```
~/ai-workflow/
├── agentic-toolkit/               # Always — methodology (one)
├── company-dev-context/           # Company projects
├── personal-dev-context/          # Personal projects
└── freelance-dev-context/         # Freelance work
```

Each follows the same structure. The toolkit serves all of them.

## Key Principles

1. **Toolkit = portable.** Works at any company, any project. Never put company/project info here.
2. **Dev-context = per-scope.** One per company or context. All real artifacts, data, and project knowledge stay here.
3. **Project .kiro/ = codebase.** Conventions that travel with the code itself.
4. **Validate before escalating.** Investigation must be factual before becoming a report. Report must be verified before becoming a ticket.
5. **Extract regularly.** After big learnings, pull the generic pattern into the toolkit.
6. **Bootstrap fast.** A new workspace + project should be operational in minutes, not days.
