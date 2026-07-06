# Project Initialization Workflow

## Purpose

When a new project starts or when first engaging with an existing codebase, this workflow guides how to set up the agentic workflow for that project. The toolkit provides the base scaffolding; this workflow explains how to adapt it based on what the AI learns about the project.

## When to Use

- After running `make project-new name=xxx` (scaffold is empty)
- First session on an existing project that doesn't have a workspace yet
- When adapting the workflow to a new tech stack or project type

## Prerequisites

You should already have:
- A workspace created (`make workspace-new`)
- A project scaffolded within it (`make project-new name=xxx`)
- The project linked to its code repo (`make project-link name=xxx repo=/path/to/code`)
- The project code repo in your IDE workspace

After linking, you have:
- `projects/{name}/.detected-stack.md` — auto-detected tech info (use as starting point)
- `projects/{name}/project-context.md` — filled with detected stack data

Optionally, if you ran `make steering-generate`:
- `projects/{name}/.kiro-draft/steering/` — steering files to review and customize

This workflow guides you through filling the context and determining which additional steering files are needed.

## Phase 1: Discover the Project

### Read the codebase first

Before customizing anything, understand:

1. **What is the project?** (API, batch system, frontend, monolith, microservice)
2. **What tech stack?** (framework, language, database, deployment)
3. **What's the architecture pattern?** (MVC, CQRS, layered, hexagonal)
4. **How is it tested?** (PHPUnit, Jest, Playwright, manual QA)
5. **How is it deployed?** (CI/CD, manual, containers)
6. **Is it multi-tenant?** (multiple brands/services from one codebase)
7. **What are the key commands?** (artisan, make targets, npm scripts)

### Sources to read

- `README.md` in the project repo
- `composer.json` / `package.json` (dependencies reveal patterns)
- `.env.example` (environment shape)
- `Makefile` (if exists — shows common operations)
- Existing `.kiro/` directory (if the project already has one)
- Existing docs in the repo

## Phase 2: Fill the Project Context

Based on discovery, fill in `project-context.md`:

| Section | What to write |
|---|---|
| Workspace Overview | Which repos are involved, their roles |
| System Overview | What it does, key commands/endpoints |
| Key Tables/Models | The important data structures |
| Testing & Verification | How correctness is validated |
| Naming & File Conventions | Branch names, file placement |
| Recent Work | Current sprint/tickets |
| Environment | How to run locally, deploy |

## Phase 3: Determine Which Steering Files Are Needed

Based on project type, select from the toolkit's base patterns:

### Always needed (every project)

These are the minimum viable steering files. Every project gets them:

| File | Purpose | Source |
|---|---|---|
| `system-overview.md` | What the system does, key commands/endpoints, environment | Discovered from codebase |
| `tech-stack.md` | Framework, language, DB, tools, constraints | Discovered from config files |
| `conventions.md` | Naming, file placement, cross-references | Adapted from toolkit template |
| `rules.md` | Git safety, development rules, project-specific rules | Adapted from toolkit + project needs |
| `coding-standards.md` | Code style, patterns, do/don't | Discovered from existing code |

### Needed based on project characteristics

Determine which apply by reading the codebase:

| If the project... | Add... | Why |
|---|---|---|
| Spans multiple repos | `repository-map.md` | Without it, AI writes files in wrong repos and guesses names from wrong sources |
| Has multiple tenants/brands | `multi-tenancy.md` | Without it, fixes get applied to one tenant only, naming inconsistencies cause silent bugs |
| Has non-standard architecture | `backend-patterns.md` | If AI assumes standard framework patterns, it generates wrong code for unusual architectures |
| Involves database work | `database-standards.md` | Need to know who owns schema, where migrations go, which tables are read-only |
| Is a batch/cron system | `batch-execution-flow.md` | Command dependencies, date logic, pre/final lifecycle — invisible without docs |
| Generates files (CSV, PDF, etc.) | `file-generation.md` | Which function generates which file, which tables feed into which output |
| Has complex core logic | `[logic-name]-reference.md` | Complex pipelines need their own reference doc when they exceed ~200 lines |
| Has specialized domain terms | `glossary.md` | Domain-specific terminology causes misunderstandings without a glossary |
| Has a specific bug-fix pattern | `fix-bug.md` | When fixes must be applied in N locations, a checklist prevents incomplete fixes |
| Has non-standard testing | `testing.md` | AI needs to know what "run tests" means for this specific project |
| Has accumulated troubleshooting | `troubleshooting.md` | After 5+ issues, patterns emerge. Document common symptoms and fixes |

### When to add each file

Not everything is needed on day 1. Files should emerge as the project matures:

```
Day 1 (bootstrap):
  ├── system-overview.md
  ├── tech-stack.md
  ├── conventions.md
  ├── rules.md
  └── coding-standards.md

Week 1-2 (first real work):
  ├── repository-map.md         (if multi-repo)
  ├── multi-tenancy.md          (if multi-tenant)
  ├── backend-patterns.md       (if architecture is unusual)
  └── database-standards.md     (if DB work is involved)

Month 1+ (as complexity is discovered):
  ├── [domain-logic]-reference.md  (when core logic is complex enough to need a reference)
  ├── batch-execution-flow.md      (when batch command dependencies are confusing)
  ├── glossary.md                  (when domain terms cause misunderstandings)
  └── fix-bug.md                   (when a fix pattern emerges)

Month 2+ (after accumulated experience):
  ├── testing.md                   (when verification approach is documented)
  └── troubleshooting.md           (when common issues are catalogued)
```

## Phase 4: Create the .kiro-draft

Place customized steering files in `.kiro-draft/steering/`:

```
projects/{name}/.kiro-draft/
├── steering/
│   ├── conventions.md          # Always
│   ├── repository-map.md       # Always (if multi-repo)
│   ├── rules.md                # Always
│   ├── [type-specific].md      # Based on project type
│   └── [team-specific].md      # Based on team needs
├── hooks/
│   └── git-commit-guard.json   # Always
└── skills/
    └── [role].md               # Optional — role definition
```

### Setting inclusion types

Based on real project experience, here's how to decide:

- `inclusion: auto` — files needed every session regardless of task:
  - `system-overview.md`, `tech-stack.md`, `conventions.md`, `rules.md`, `coding-standards.md`
  - `multi-tenancy.md`, `database-standards.md`, `backend-patterns.md` (if always relevant)
  - `glossary.md` (if domain terms appear constantly)

- `inclusion: manual` — files only relevant for specific tasks:
  - `fix-bug.md` (only when fixing bugs)
  - `investigate-issue.md` (only when investigating)
  - `testing.md` (only when running simulations)
  - `troubleshooting.md` (only when debugging)
  - `batch-execution-flow.md` (only when running/debugging commands)

- `inclusion: fileMatch` — files relevant when working on specific code:
  - A pipeline/query reference → `fileMatchPattern: "**/relevant-logic-files*.ext"`
  - A file generation reference → `fileMatchPattern: "**/relevant-util-files*.ext"`

**Rule of thumb:** If the AI would make a mistake without this file in 80%+ of sessions, it's `auto`. If it only matters for specific activities, it's `manual`. If it only matters when editing certain files, it's `fileMatch`.

## Phase 5: Promote to Project .kiro/

Once the `.kiro-draft/` files are refined and proven useful:

1. Copy them to the actual project repo's `.kiro/steering/`
2. Test that they work correctly (auto-load, manual reference)
3. Commit to the project repo

The `.kiro-draft/` in the dev-context remains as a reference/backup.

## Decision Matrix: Where Does It Live?

| Content | Lives in... | Why |
|---|---|---|
| "Always use strict_types" | Project `.kiro/steering/` | Codebase convention |
| "Branch format is feature/PROJ-XXX" | Project `.kiro/steering/` | Team convention |
| "Never commit without review" | Toolkit `.kiro/steering/` | Universal rule |
| "Investigation reports use this header" | Toolkit `.kiro/steering/` | Universal format |
| "The CTE pipeline has 7 stages" | `[workspace]/projects/{name}/project-context.md` | Project knowledge |
| "TC013 tests B2B REST expiry" | `[workspace]/projects/{name}/testcases/` | Project artifact |

## Example: Batch Processing System

After discovering it's a Laravel 8 batch system with raw SQL, multi-tenant, no API:

**Day 1 steering (5 files):**
- `system-overview.md` — batch commands, what each does, environment
- `tech-stack.md` — PHP 8.1, Laravel 8, MySQL 5.7, no native CTEs
- `conventions.md` — naming, file placement, cross-references
- `rules.md` — git safety + investigation rules + multi-tenant safety
- `coding-standards.md` — PSR-12, strict_types, SQL comment conventions

**Week 1-2 (4 more):**
- `repository-map.md` — 5 repos with boundaries
- `multi-tenancy.md` — tenant table mapping, N-location rule
- `backend-patterns.md` — "this is NOT standard Laravel" (no controllers, raw SQL in PHP)
- `database-standards.md` — schema ownership, read-only vs write tables

**Month 1+ (5 more):**
- `[pipeline]-reference.md` — core logic reference (fileMatch on logic files)
- `file-generation.md` — which function → which file (fileMatch on util files)
- `batch-execution-flow.md` — date logic, command dependencies
- `glossary.md` — domain terms
- `fix-bug.md` — N-location checklist specific to this project

**Month 2+ (2 more):**
- `testing.md` — file-comparison methodology, simulation levels
- `troubleshooting.md` — common symptoms and fixes

Total: 16 steering files + 1 hook + 1 skill. Built incrementally over 2 months.

## Example: GraphQL API Project

After discovering it's Laravel 12, GraphQL via Lighthouse, multi-tenant, standard architecture:

**Day 1 steering (5 files):**
- `system-overview.md` — API service, key features
- `tech-stack.md` — Laravel 12, Lighthouse, MySQL, Redis, JWT
- `conventions.md` — GraphQL naming, resolver → service → repository
- `rules.md` — git safety + development rules
- `coding-standards.md` — PSR-12, layered architecture enforcement

**Week 1-2 (2-3 more):**
- `multi-tenancy.md` — tenant separation via config keys
- `backend-patterns.md` — resolver patterns, error handling, auth context

**Month 1+ (as needed):**
- `glossary.md` — if domain terms are confusing
- `testing.md` — PHPUnit + property-based testing methodology

Total: ~8-10 steering files. Less than the batch system because the architecture is more standard.

## Example: Frontend Project (Hypothetical)

After discovering it's Vue 2 + Nuxt 2, Apollo Client:

**Day 1 steering (4 files):**
- `system-overview.md` — what the UI does, key routes
- `tech-stack.md` — Vue 2, Nuxt 2, Apollo, Element UI
- `conventions.md` — component naming, folder structure
- `rules.md` — git safety + development rules

**Week 1-2 (1-2 more):**
- `coding-standards.md` — component patterns, state management
- `testing.md` — Jest, component testing approach

Total: ~5-6 steering files. Frontend projects tend to need less steering because frameworks have stronger conventions.
