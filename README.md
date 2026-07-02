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

### 4. Set git identity in the new workspace

```bash
cd ~/ai-workflow/my-dev-context
git config user.name "Your Name"
git config user.email "your-email@example.com"
```

If you use `includeIf` in `~/.gitconfig`, this is automatic per directory. See `knowledge/tooling-setup.md`.

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

This scans the repo, auto-detects the tech stack, and writes `projects/my-project/.detected-stack.md`. The AI uses this to help you fill in project context.

### 7. Open your IDE workspace

Add all three folders to one multi-root workspace:

- `~/projects/my-project/` — your code
- `~/ai-workflow/my-dev-context/` — project knowledge and artifacts
- `~/ai-workflow/agentic-toolkit/` — methodology (this repo)

In VS Code/Kiro: File → Add Folder to Workspace for each folder.

### 8. Start your first AI session

Tell the AI:

> "Read `projects/my-project/.detected-stack.md` and help me fill in `project-context.md`"

The AI will read the detected stack info and guide you through filling in the project context file with architecture, key commands, models, and conventions.

### Done

Setup is complete when `project-context.md` has real content (not placeholders). At that point you can make your initial commit to the dev-context repo.

Do NOT commit during setup steps 3-8 — the workspace isn't ready until project-context is filled.

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
2. Load project context: "Read `projects/{name}/project-context.md`"
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
    ├── project-context.md                (AI fills with your help)
    └── .kiro-draft/steering/             (customize per project type)
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

- `knowledge/getting-started.md` — full workflow explanation with lifecycle and evolution over time
- `workflows/project-initialization.md` — how to determine which steering files a project needs
- `workflows/workspace-setup.md` — alternative manual workspace creation (without `make new-workspace`)
- `reading/agentic-ai-dev-framework-poc.md` — full POC report with testing evidence and value proposition
