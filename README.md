# Agentic Toolkit

A portable AI development framework. Structured methodology for AI-assisted software development — with safety guardrails, quality gates, and consistent process. Company and project agnostic.

## What This Is

This repo defines **how to work** with AI development tools as a system:

- **Steering** — behavioral rules for AI sessions (git safety, documentation format)
- **Workflows** — step-by-step procedures (bug fix, investigation, spec-driven development)
- **Hooks** — automated safety guardrails (git commit guard)
- **Templates** — scaffolding for workspaces, projects, and documentation
- **Knowledge** — portable learnings and methodology

What it's NOT: project-specific, company-specific, or a code library. The toolkit provides the **process**. Your project's specific details live elsewhere (see Architecture below).

## Architecture

Three repos work together in one IDE workspace:

```
┌──────────────────────────────────────────────────────────┐
│  [project]/.kiro/steering/      WHAT you're working with  │
│  (in your code repo)            Codebase conventions,     │
│                                 architecture, tech stack   │
├──────────────────────────────────────────────────────────┤
│  [dev-context]/projects/{name}  WHERE artifacts live       │
│  (per-context repo)             Reports, tickets, test    │
│                                 cases, project knowledge   │
├──────────────────────────────────────────────────────────┤
│  agentic-toolkit/               HOW to work                │
│  (this repo — portable)         Rules, workflows,          │
│                                 templates, methodology     │
└──────────────────────────────────────────────────────────┘
```

| Layer | Auto-loaded? | Who owns it |
|---|---|---|
| `agentic-toolkit/.kiro/steering/` | Yes — every session | You (personal, portable) |
| `[dev-context]/.kiro/steering/` | Yes — every session | You (per-company/context) |
| `[project]/.kiro/steering/` | Yes — Kiro default | Team (in the project repo) |

Toolkit provides methodology → dev-context routes artifacts → project `.kiro/` knows the codebase.

## Getting Started

Follow in order. Do not commit until setup is complete.

### 1. Clone or locate your project repo

If you already have the project cloned, skip this step. Otherwise:

```bash
git clone <your-project-repo> ~/projects/my-project
```

The project repo can live anywhere on your filesystem — it doesn't need to be inside `~/ai-workflow/`.

### 2. Clone this toolkit

```bash
mkdir -p ~/ai-workflow
git clone <your-toolkit-repo> ~/ai-workflow/agentic-toolkit
```

The `~/ai-workflow/` directory is the parent folder for the toolkit and all dev-context workspaces. You can name it anything (`~/dev-tools/`, `~/workspace/`, etc.) — just keep the toolkit and dev-contexts as siblings in the same parent.

### 3. Create a dev-context workspace

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=my-dev-context context="My projects"
```

A **dev-context** is a companion repo that stores all AI-generated artifacts for your projects — investigation reports, tickets, test cases, project knowledge, and draft steering files. It keeps your project repo clean while preserving everything the AI produces during work.

Creates `~/ai-workflow/my-dev-context/` as a sibling directory (required — bootstrap scripts resolve the toolkit at `../agentic-toolkit`).

### 4. Open IDE workspace

Open Kiro (or VS Code) and create a multi-root workspace with all three folders:

1. File → Add Folder to Workspace (repeat for each):
   - `~/projects/my-project/` — your code
   - `~/ai-workflow/my-dev-context/` — artifacts & knowledge
   - `~/ai-workflow/agentic-toolkit/` — methodology (this repo)
2. Save as a `.code-workspace` file for easy reopening

All three must be open together. The toolkit's steering files auto-load into Kiro sessions, and the AI needs visibility into all three layers to route work correctly.

### 5. Bootstrap and link your project

```bash
cd ~/ai-workflow/my-dev-context
make new-project name=my-project
make link-project name=my-project repo=~/projects/my-project
```

`make new-project` scaffolds the project directory structure (empty folders for artifacts).

`make link-project` scans the repo, auto-detects the tech stack, and **fills `project-context.md` directly**. Expected output:

```
Scanning project repo: /home/user/projects/my-project
...
=== Detected ===
Language: PHP
Framework: Laravel 8.x
Database: MySQL
...

✅ project-context.md filled with detected data.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✅ Setup complete — my-project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  project-context.md: filled with detected stack info
  .detected-stack.md: supplementary reference (can delete)

  You're ready to work. In a Kiro session, load context:
    Read projects/my-project/project-context.md

  Then use any toolkit workflow:
    - Investigate a bug
    - Fix a bug
    - Start a new feature (spec-driven)
    - Create a PR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Done

That's it. `project-context.md` already has useful content — tech stack, key commands, file placement conventions. You can refine it further as you learn the project, but it's immediately usable.

To start working, load the context in a Kiro session:

> "Read `projects/my-project/project-context.md`"

Then use any workflow (see Usage below).

**Optional cleanup:** Delete `.detected-stack.md` (supplementary reference only). Set git identity before first commit: `git config user.name/email` in the dev-context.

## Usage

### Available Workflows

| Say this | What happens |
|---|---|
| "Investigate this issue" | Full investigation process → report |
| "Fix this bug" | Understand → scope → implement → verify |
| "Start a new feature" | Spec-driven: requirements → design → tasks → execute |
| "Create a PR" | Branch → commit → push → PR |
| "Run tests" | Tiered testing (smoke → unit → functional → acceptance) |
| "Write a bug ticket" | JIRA-style ticket from template |
| "Add {type} steering" | Generate a new steering file for the project |

### Where Things Go

| Output | Destination |
|---|---|
| Code changes | Project repo |
| Reports, tickets, test cases | `[dev-context]/projects/{name}/` |
| Methodology improvements | `agentic-toolkit/` (via extract-to-toolkit workflow) |

### Steering Lifecycle

`make link-project` creates Day 1 steering files in `.kiro-draft/steering/`. As you work:

1. **Day 1** — system-overview, tech-stack, coding-standards filled automatically
2. **Week 1+** — add more steering as complexity is discovered ("Add database steering")
3. **When proven** — promote drafts to `[project]/.kiro/steering/` so they travel with the code

See `workflows/project-initialization.md` for which steering files to add and when.

## Repo Structure

```
agentic-toolkit/
├── .kiro/steering/        # Auto-loaded behavioral rules
├── workflows/             # Step-by-step procedures (investigation, bug-fix, PR, spec-driven)
├── hooks/                 # Safety guardrails (git commit guard)
├── templates/
│   ├── bootstrap/         # Scaffolding for new workspaces and projects
│   ├── steering/          # Steering file skeletons
│   ├── documentation/     # Report and article formats
│   ├── jira/              # Ticket templates (epic, story, task, bug)
│   ├── prompts/           # Structured AI prompts
│   └── features/          # Opt-in modules (document-based testing, AI tracking)
├── scripts/               # Bootstrap automation
├── knowledge/             # Portable learnings and methodology
├── reading/               # External references
└── Makefile               # `make new-workspace name=xxx`
```

## Multiple Workspaces

```
~/ai-workflow/
├── agentic-toolkit/           # One copy — serves all workspaces
├── company-dev-context/       # Company projects
├── personal-dev-context/      # Personal projects
└── freelance-dev-context/     # Freelance work
```

## Further Reading

| Document | What it covers |
|---|---|
| `knowledge/getting-started.md` | Full lifecycle, steering setup, validation, session workflow |
| `workflows/project-initialization.md` | Which steering files a project needs and when |
| `knowledge/kiro-steering-patterns.md` | Inclusion types, sizing, layering patterns |
| `templates/features/` | Opt-in modules (document-based testing, AI contribution tracking) |
| `reading/agentic-ai-dev-framework-poc.md` | POC report with testing evidence |
