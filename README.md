# Agentic Toolkit

A portable AI development framework. Provides rules, workflows, templates, and knowledge for structured AI-assisted software development — company and project agnostic.

## What This Is

This repo defines **how to work** with AI development tools as a system — not ad-hoc prompts, but structured methodology with safety guardrails, quality gates, and consistent process.

It's the portable layer of the Agentic AI Development Framework.

- **Steering** — behavioral rules for AI sessions (git safety, documentation format)
- **Workflows** — step-by-step procedures (bug fix, investigation, testing)
- **Hooks** — automated safety guardrails (git commit guard)
- **Templates** — scaffolding for new workspaces, projects, and documentation
- **Features** — opt-in modules for specific needs (document-based testing, AI tracking)
- **Knowledge** — portable learnings and methodology

## What This Is Not

- Not project-specific (that lives in your dev-context workspace)
- Not company-specific (no internal systems, URLs, credentials)
- Not a code library (no runtime dependencies)

## Getting Started

Follow these steps in order. Do not skip ahead or commit until step 7 says you're done.

### 1. Have your project repo ready

Skip if already cloned.

```bash
git clone <project-repo> ~/projects/my-project
```

### 2. Clone this toolkit

```bash
git clone <your-toolkit-repo> ~/ai-workflow/agentic-toolkit
```

The toolkit and dev-context must be siblings (same parent directory) because bootstrap scripts use `../agentic-toolkit` to locate templates. Your project code repo can live anywhere.

### 3. Create a dev-context workspace

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=my-dev-context context="My projects"
```

This creates `~/ai-workflow/my-dev-context/` with all scaffolding. The `context=` parameter is optional — auto-generates from the name if omitted.

### 4. Open your IDE workspace

Add all three folders to one multi-root workspace:

- `~/projects/my-project/` — your code
- `~/ai-workflow/my-dev-context/` — project knowledge and artifacts
- `~/ai-workflow/agentic-toolkit/` — methodology (this repo)

In VS Code/Kiro: File → Add Folder to Workspace for each folder.

### 5. Bootstrap your project

```bash
cd ~/ai-workflow/my-dev-context
make new-project name=my-project
```

This creates `projects/my-project/` with empty templates (project-context.md, .kiro-draft/, artifact directories).

### 6. Link the project repo

```bash
make link-project name=my-project repo=~/projects/my-project
```

This scans the repo, auto-detects the tech stack (language, framework, database, build tool, testing), and writes `projects/my-project/.detected-stack.md`.

### 7. Ingest the project (AI-assisted)

In a Kiro session, say:

> "Ingest my-project"

Behind the scenes, this:
1. Reads the auto-detected stack from `.detected-stack.md`
2. Fills `project-context.md` with real architecture, commands, models, and conventions
3. Customizes `.kiro-draft/steering/` templates (tech-stack, coding-standards, system-overview)
4. Outputs a **workspace validation** confirming the three-layer setup is understood

You don't need to know which files are involved — just say "Ingest" and the project name.

### Done

Ingestion is complete when the AI outputs a validation handshake like:

```
✅ Workspace Validation — my-project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Layer 1 (Project):    /path/to/my-project — [framework, language]
Layer 2 (Context):    dev-context/projects/my-project/ — artifacts & knowledge
Layer 3 (Toolkit):    agentic-toolkit/ — methodology & workflows

Ready for: investigation, bug-fix, spec-driven development, PR creation
```

At that point:
- `.detected-stack.md` can be deleted (served its purpose)
- `project-context.md` has real content
- `.kiro-draft/steering/` files are customized (at least tech-stack, coding-standards, system-overview)
- You're ready to work

Do NOT commit during setup steps 3-7 — the workspace isn't ready until ingestion validates.

## What Now? (After Ingestion)

### Steering Setup

During ingestion, the AI fills `.kiro-draft/steering/` with project-specific content. These files live in the dev-context as drafts until you're confident they work well, then they get promoted to the project repo's `.kiro/steering/`.

**What gets filled during ingestion (Day 1):**

| File | What it contains |
|---|---|
| `system-overview.md` | What the system does, key commands, environment |
| `tech-stack.md` | Framework, language, DB, tools, constraints |
| `coding-standards.md` | Code style, patterns, anti-patterns |
| `conventions.md` | Naming, file placement (pre-filled from template) |
| `repository-map.md` | Repo boundaries (pre-filled from template) |

**What gets added as you work (Week 1+):**

As you encounter complexity, tell the AI to add more steering files. See `workflows/project-initialization.md` for the full decision matrix of when each file type is needed.

**Promoting drafts to the project repo:**

Once a steering file is refined and proven useful (usually after 1-2 weeks of real work):
1. Copy from `.kiro-draft/steering/` to `[project-repo]/.kiro/steering/`
2. Verify it auto-loads correctly in sessions
3. Commit to the project repo — now it travels with the codebase

### Validation

After ingestion, the AI outputs a validation confirming it understands the workspace. If you ever need to re-validate (new session, new project), say:

> "Validate workspace for my-project"

The AI checks:
- ✅ Can locate and read `project-context.md`
- ✅ Knows the three layers (project repo → dev-context → toolkit)
- ✅ Knows where code changes go vs where artifacts land
- ✅ Can identify available workflows (investigation, bug-fix, spec-driven, PR)

### Working with the Project

| You want to... | Say this |
|---|---|
| Investigate a bug | "Investigate this issue" |
| Fix a bug | "Fix this bug" |
| Build a new feature | "Start a new feature" (loads spec-driven workflow) |
| Create a PR | "Create a PR" |
| Run/validate tests | "Run tests" |
| Write a ticket | "Write a bug ticket" |
| Add a steering file | "Add [type] steering for this project" |

The toolkit's steering auto-loads every session and provides:
- **Git safety** — AI won't commit without your approval
- **File boundaries** — AI won't write outside your workspace
- **Development rules** — AI reads before writing, explains reasoning
- **Naming conventions** — consistent file naming across artifacts

For the full routing table (what triggers what), see `.kiro/steering/toolkit-usage.md`.

For the project lifecycle and how things evolve over time, see `knowledge/getting-started.md`.

## How It Works

### The Three Layers

```
┌────────────────────────────────────────────────────────────┐
│  [project]/.kiro/steering/       WHAT you're working with   │
│  (in the project repo)           Codebase conventions,      │
│                                  architecture, tech stack    │
├────────────────────────────────────────────────────────────┤
│  [dev-context]/.kiro/steering/   WHERE artifacts live        │
│  (per-context repo)              Project routing, file       │
│                                  placement, workspace rules  │
├────────────────────────────────────────────────────────────┤
│  agentic-toolkit/.kiro/steering/ HOW to work                 │
│  (personal, portable)            Rules, workflows,           │
│                                  templates, methodology      │
└────────────────────────────────────────────────────────────┘
```

| Layer | Auto-loaded? | Who owns it |
|---|---|---|
| `agentic-toolkit/.kiro/steering/` | Yes — every session | You (personal, portable) |
| `[dev-context]/.kiro/steering/` | Yes — every session | You (per-company/context) |
| `[project]/.kiro/steering/` | Yes — Kiro default | Team (in the project repo) |

**Flow:** Toolkit provides methodology → dev-context routes artifacts → project `.kiro/` knows the codebase.

### During a Session

1. Open the IDE workspace (all three folders)
2. Load project context: "Read `projects/{name}/project-context.md`" (or just start working)
3. Work normally — toolkit steering auto-enforces safety rules, workflows load on demand
4. Artifacts (reports, tickets, test cases) land in the dev-context project directory
5. Code changes go in the project repo

### Where Artifacts Go

| You produce... | It goes to... |
|---|---|
| Code changes | `[project repo]` (the actual codebase) |
| Investigation report | `[dev-context]/projects/{name}/technical-notes/investigation/` |
| JIRA ticket (bug, story, task) | `[dev-context]/projects/{name}/technical-notes/jira/tickets/` |
| Knowledge base article | `[dev-context]/projects/{name}/knowledge-base/` |
| Test case (if feature active) | `[dev-context]/projects/{name}/testcases/` |
| Generic methodology improvement | `agentic-toolkit/` (via extract-to-toolkit workflow) |

### The Bootstrap Flow (Visual)

```
agentic-toolkit/                          (you have this)
    │
    │  make new-workspace name=xxx
    ▼
xxx-dev-context/                          (created as sibling)
    │
    │  make new-project name=yyy
    ▼
xxx-dev-context/projects/yyy/             (scaffolded — empty templates)
    │
    │  make link-project name=yyy repo=/path/to/code
    ▼
xxx-dev-context/projects/yyy/
    ├── .detected-stack.md                (auto-detected tech info)
    ├── project-context.md                (empty — ready for ingestion)
    └── .kiro-draft/steering/             (templates — ready for ingestion)
    │
    │  In Kiro: "Ingest yyy"
    ▼
xxx-dev-context/projects/yyy/
    ├── project-context.md                (✅ filled with real data)
    ├── .kiro-draft/steering/             (✅ customized for this project)
    └── [validation handshake output]     (✅ three-layer workspace confirmed)
```

## Structure

```
agentic-toolkit/
├── .kiro/
│   └── steering/                  # Behavioral rules (auto + manual)
│       ├── toolkit-usage.md           # (auto) Routing table — what to load when
│       ├── git-safety.md              # (auto) Never commit without permission
│       ├── filesystem-boundaries.md   # (auto) Never write outside workspace
│       ├── development-rules.md       # (auto) Read before write, minimal changes
│       ├── naming-conventions.md      # (auto) File naming rules
│       ├── documentation-standards.md # (manual) Doc structure format
│       └── report-standards.md        # (manual) Investigation report format
├── workflows/                     # Step-by-step procedures
│   ├── workspace-setup.md            # Create a new dev-context workspace
│   ├── project-initialization.md     # Set up steering for a new project
│   ├── investigation.md              # Full investigation process
│   ├── bug-fix.md                    # Understand → scope → implement → verify
│   ├── pr-creation.md                # Branch → code → review → commit → push → PR
│   ├── spec-driven-development.md    # Requirements → design → tasks → execute
│   ├── tiered-testing.md             # Smoke → Unit → Functional → Acceptance
│   └── extract-to-toolkit.md         # Pull learnings back into toolkit
├── hooks/                         # Safety guardrails
│   └── git-commit-guard.json         # Blocks git commit/push without permission
├── templates/
│   ├── bootstrap/
│   │   ├── workspace/                # Template for new dev-context repos
│   │   └── project/                  # Template for new projects
│   ├── steering/                     # Generic steering file skeletons
│   ├── skills/                       # AI role definition template
│   ├── hooks/                        # Hook templates
│   ├── prompts/                      # Structured AI prompts
│   ├── documentation/                # Report, article formats
│   ├── jira/                         # Ticket templates (epic, story, task, bug)
│   ├── automation/                   # Makefile targets, commit conventions
│   └── features/                     # Opt-in feature modules
│       ├── document-based-testing/       # Markdown test cases + AI simulation
│       └── ai-contribution-tracking/    # Track AI vs human contributions
├── scripts/
│   └── bootstrap-workspace.sh        # Creates a new workspace repo
├── knowledge/                     # Portable learnings
├── reading/                       # External articles and references
├── Makefile                       # `make new-workspace name=xxx`
└── README.md
```

## Features (Opt-In Modules)

Features are self-contained capabilities activated per-project. They are NOT active by default — a human must explicitly choose to install them.

| Feature | What it does | Activate when... |
|---|---|---|
| **Document-Based Testing** | Markdown test cases (TCNNN.md) + AI-assisted simulation | Verification is file-based (CSV, reports), not standard test frameworks |
| **AI Contribution Tracking** | Track AI vs human contributions via git attribution + metrics | Team wants visibility or audit trail for AI-generated code |

To activate a feature, tell the AI: "Set up [feature name]" — it will load the feature's README and guide you through installation for that project only.

Features never auto-load, never affect other projects, and the toolkit works fully without any features activated.

## Multiple Workspaces

You can have as many dev-context repos as needed:

```
~/ai-workflow/
├── agentic-toolkit/               # Always — methodology (one copy)
├── company-dev-context/           # Company projects
├── personal-dev-context/          # Personal projects
└── freelance-dev-context/         # Freelance work
```

Each follows the same internal structure. The toolkit serves all of them. One toolkit, many workspaces, many projects.

## Further Reading

- `knowledge/getting-started.md` — full workflow explanation with lifecycle, steering setup, and validation
- `workflows/project-initialization.md` — how to determine which steering files a project needs
- `workflows/workspace-setup.md` — alternative manual workspace creation (without `make new-workspace`)
- `reading/agentic-ai-dev-framework-poc.md` — full POC report with testing evidence and value proposition
