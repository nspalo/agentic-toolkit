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

Follow in order. Do not commit until ingestion completes.

### 1. Clone this toolkit

```bash
mkdir -p ~/ai-workflow
git clone <your-toolkit-repo> ~/ai-workflow/agentic-toolkit
```

### 2. Create a dev-context workspace

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=my-dev-context context="My projects"
```

Creates `~/ai-workflow/my-dev-context/` as a sibling directory (required — bootstrap scripts use `../agentic-toolkit`).

### 3. Open IDE workspace

Add all three folders to one multi-root workspace:

```
~/projects/my-project/              # Your code
~/ai-workflow/my-dev-context/       # Artifacts & knowledge
~/ai-workflow/agentic-toolkit/      # Methodology (this repo)
```

### 4. Bootstrap and link your project

```bash
cd ~/ai-workflow/my-dev-context
make new-project name=my-project
make link-project name=my-project repo=~/projects/my-project
```

This scaffolds the project directory and auto-detects the tech stack.

### 5. Ingest the project

In a Kiro session, say:

> "Ingest my-project"

This reads the detected stack, fills `project-context.md`, customizes steering files, and outputs a validation handshake:

```
✅ Workspace Validation — my-project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Layer 1 (Project):    /path/to/my-project — [framework, language]
Layer 2 (Context):    dev-context/projects/my-project/ — artifacts & knowledge
Layer 3 (Toolkit):    agentic-toolkit/ — methodology & workflows

Ready for: investigation, bug-fix, spec-driven development, PR creation
```

When you see this, setup is complete. Delete `.detected-stack.md` and start working.

## Usage

### Available Workflows

| Say this | What happens |
|---|---|
| "Ingest {project}" | First-time project setup (context + steering + validation) |
| "Validate workspace for {project}" | Re-confirm three-layer setup is understood |
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

Ingestion creates Day 1 steering files in `.kiro-draft/steering/`. As you work:

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
