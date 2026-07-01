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
│   ├── steering/                     # Generic steering file skeletons (13)
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

## How to Use

### First Time Setup

1. Clone this repo into `~/ai-workflow/agentic-toolkit/`
2. Create your first dev-context workspace:

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=company-dev-context
```

3. Set git identity in the new workspace:

```bash
cd ~/ai-workflow/company-dev-context
git config user.name "Your Name"
git config user.email "your-email@example.com"
```

4. Add all three to your IDE as a multi-root workspace:
   - Your project code repo(s)
   - The new dev-context workspace
   - This toolkit (`agentic-toolkit/`)

### Adding a New Project

From inside your dev-context repo:

```bash
cd ~/ai-workflow/company-dev-context
make new-project name=project-code
```

Then follow `workflows/project-initialization.md` (in the toolkit) to discover the project and customize its steering files.

### The Bootstrapping Flow

```
agentic-toolkit/                          (you have this — always)
    │
    │  make new-workspace name=xxx
    ▼
xxx-dev-context/                          (created — one per company/context)
    │
    │  make new-project name=yyy
    ▼
xxx-dev-context/projects/yyy/             (created — one per project)
    ├── project-context.md                (fill in project details)
    └── .kiro-draft/steering/             (customize per project type)
```

### During a Session

1. Open IDE workspace with: project repo(s) + dev-context + toolkit
2. Load project context: "Read `projects/{name}/project-context.md`"
3. Work normally — toolkit rules auto-enforce, workflows load on demand
4. Artifacts (reports, tickets, test cases) land in the dev-context project directory

## Relationship to Other Repos

```
IDE Workspace:
├── [project repos]              # Code (company or personal)
├── [dev-context]/               # Project knowledge + artifacts
│   ├── .kiro/steering/              # Workspace identity (auto-loaded)
│   └── projects/
│       ├── project-a/
│       │   ├── project-context.md   # Loaded at session start
│       │   ├── knowledge-base/
│       │   ├── testcases/           # (if document-based testing is active)
│       │   ├── technical-notes/
│       │   │   ├── jira/{tickets,epics,proposals}
│       │   │   └── investigation/
│       │   └── .kiro-draft/         # Steering for the project's .kiro/
│       └── project-b/
└── agentic-toolkit/             # This repo (portable, personal)
    ├── .kiro/steering/              # Auto-loaded rules
    └── ...
```

### How the Three Layers Work Together

| Layer | What it provides | Auto-loaded? | Who owns it |
|---|---|---|---|
| `agentic-toolkit/.kiro/steering/` | Universal rules (git safety, naming, development rules) | Yes — every session | You (personal, portable) |
| `[dev-context]/.kiro/steering/` | Project routing (which project is active, file placement) | Yes — every session | You (per-company/context) |
| `[project]/.kiro/steering/` | Codebase conventions (architecture, tech stack, patterns) | Yes — Kiro default | Team (in the project repo) |

**Flow:** Toolkit provides methodology → dev-context knows which project → project `.kiro/` knows the codebase.

### Where Artifacts Go

| You produce... | It goes to... |
|---|---|
| Investigation report | `[dev-context]/projects/{name}/technical-notes/investigation/` |
| JIRA ticket (bug, story, task) | `[dev-context]/projects/{name}/technical-notes/jira/tickets/` |
| Knowledge base article | `[dev-context]/projects/{name}/knowledge-base/` |
| Test case (if feature active) | `[dev-context]/projects/{name}/testcases/` |
| Code changes | `[project repo]` (the actual codebase) |
| Generic methodology improvement | `agentic-toolkit/` (via extract-to-toolkit workflow) |

## Features (Opt-In Modules)

Features are self-contained capabilities that can be activated per-project. They are **NOT active by default** — a human must explicitly choose to install them.

### Available Features

| Feature | What it does | Activate when... |
|---|---|---|
| **Document-Based Testing** | Markdown test cases (TCNNN.md) + AI-assisted simulation | Verification is file-based (CSV, reports), not standard test frameworks |
| **AI Contribution Tracking** | Track AI vs human contributions via git attribution + metrics | Team wants visibility or audit trail for AI-generated code |

### How Features Work

```
1. User decides a feature is needed
       │
       ▼
2. User says: "Set up [feature name]" or "How do I use [feature]?"
       │
       ▼
3. AI loads: templates/features/[feature-name]/README.md
       │
       ▼
4. README provides activation steps:
   - What files to copy into the project
   - What to configure
   - What changes in behavior once active
       │
       ▼
5. Feature is active for that project only
   (other projects unaffected)
```

### Feature Isolation Rules

- Features never auto-load — they require explicit human activation
- Each feature is one directory under `templates/features/`
- Activating a feature for one project doesn't affect other projects
- Features enhance existing workflows — they don't replace them
- The toolkit works fully without any features activated

## Further Reading

- `reading/agentic-ai-dev-framework-poc.md` — full POC report with testing evidence and value proposition
- `knowledge/getting-started.md` — full workflow explanation with lifecycle
- `workflows/project-initialization.md` — how to set up steering for any project type
- `workflows/workspace-setup.md` — how to create a new dev-context workspace
