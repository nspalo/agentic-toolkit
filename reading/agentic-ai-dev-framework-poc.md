# Agentic AI Development Framework — Overview

## Summary

A portable, three-layer framework for structured AI-assisted software development. Separates methodology (how to work) from project knowledge (what you're working on) and codebase conventions (what the project is). Enables a developer to onboard onto any project in minutes with safety guardrails, consistent process, and knowledge retention across sessions.

---

## The Problem

AI coding assistants are stateless. Each session starts from scratch — the AI doesn't know your conventions, architecture, process, or where artifacts should go. This leads to:

- Inconsistent output quality across sessions
- Repeated context setup every time
- No systematic knowledge capture between sessions
- No safety guardrails (AI commits without review, writes outside boundaries)
- No reusability across projects

---

## Three-Layer Architecture

```
┌─────────────────────────────────────────────────────────┐
│  [project]/.kiro/              WHAT you're working with  │
│  (in the code repo)            Codebase conventions,     │
│                                architecture, tech stack   │
├─────────────────────────────────────────────────────────┤
│  [dev-context]/projects/{name}  WHERE work lives          │
│  (per-company/context repo)     Artifacts, knowledge,     │
│                                 test cases, tickets       │
├─────────────────────────────────────────────────────────┤
│  agentic-toolkit/               HOW to work               │
│  (personal, portable repo)      Rules, workflows,         │
│                                 templates, methodology    │
└─────────────────────────────────────────────────────────┘
```

**Layer 1: Agentic Toolkit** (portable — travels with developer)
- 5 behavioral steering files auto-loaded every session
- Workflows for investigation, bug fix, PR, spec-driven development, testing
- Templates for workspaces, projects, steering files, documentation, tickets
- Opt-in features (document-based testing, AI contribution tracking)
- One-command bootstrapping

**Layer 2: Dev-Context** (per-company — project knowledge)
- Investigation reports, JIRA tickets, knowledge base articles
- Test cases, system diagrams, project documentation
- Draft steering files (staging before promotion to project .kiro/)
- Multiple projects per workspace, multiple workspaces per toolkit

**Layer 3: Project `.kiro/`** (per-project — codebase conventions)
- Architecture patterns, tech stack, coding standards
- Testing conventions, multi-tenancy rules
- Shared with the team via the code repository

---

## How It Works

### Setup (5 steps, all CLI)

```bash
# 1. Have project repo cloned
# 2. Clone toolkit
git clone <toolkit-repo> ~/ai-workflow/agentic-toolkit

# 3. Create dev-context workspace
cd ~/ai-workflow/agentic-toolkit
make workspace-new name=my-dev-context about="My projects"

# 4. Open IDE with all 3 folders (project + dev-context + toolkit)

# 5. Bootstrap and link project
cd ~/ai-workflow/my-dev-context
make project-new name=my-project
make project-link name=my-project repo=~/projects/my-project
```

`make project-link` scans the repo, auto-detects the tech stack (language, framework, database, build tool, testing), and fills `project-context.md` directly. No AI step required for setup.

Setup is complete when the script finishes. Start working immediately.

### Session Flow

1. Open IDE (all three folders in multi-root workspace)
2. Load project context: "Read `projects/{name}/project-context.md`"
3. Toolkit steering auto-loads and enforces rules
4. Work using workflows on demand
5. Artifacts land in correct project directory

### Safety Guardrails (Auto-Enforced)

| Rule | Mechanism |
|---|---|
| Never commit without review | `git-safety.md` (steering) + `git-commit-guard.json` (hook) |
| Never write outside workspace | `filesystem-boundaries.md` (steering) |
| Read before writing code | `development-rules.md` (steering) |
| State confidence explicitly | `development-rules.md` (steering) |
| No commits during setup | `git-safety.md` "During Setup" section |

### Available Workflows

| Trigger | What it does |
|---|---|
| "Investigate this issue" | Full investigation → report with confidence markers |
| "Fix this bug" | Understand → scope → implement → verify |
| "Start a new feature" | Spec-driven: requirements → design → tasks → execute |
| "Create a PR" | Branch → commit → push → PR with conventions |
| "Run tests" | Tiered testing (smoke → unit → functional → acceptance) |
| "Write a bug ticket" | JIRA template → structured ticket |
| "Enrich {project}" | Deep scan code repo → fill remaining TBA sections in project-context |

### Opt-In Features

| Feature | Purpose |
|---|---|
| Document-Based Testing | Markdown test cases + AI simulation for file-based verification |
| AI Contribution Tracking | Track AI vs human contributions via git attribution + metrics |

Features are never active by default. Activate per-project only when needed.

---

## What Was Validated

### Pilot Project: Biz Todo App (Laravel 8, Vue 3, Docker)

| Area | Result |
|---|---|
| Setup (workspace + project + link) | ✅ Works — full scaffold in seconds |
| Auto-detection (src/ layout, PHP, Laravel, Vue, MySQL, Docker) | ✅ Detects correctly |
| project-context.md auto-fill | ✅ Filled with real data by script |
| Steering auto-load (5 toolkit files) | ✅ Active every session |
| Git safety enforcement | ✅ AI asks before every commit/push |
| Filesystem boundaries | ✅ AI asks before writing outside workspace |
| Toolkit + project steering coexistence | ✅ No conflicts |
| Spec-driven workflow (requirements) | ✅ Generated requirements with ACs |
| Multi-root workspace (3+ folders) | ✅ All layers visible |

### Issues Found and Fixed During Pilot

| Issue | Root Cause | Fix |
|---|---|---|
| `link-project.sh` not copied to new workspaces | `bootstrap-workspace.sh` only copied one script | Added copy + chmod for both scripts |
| Detection missed PHP/Laravel for `src/` layout projects | Script only checked repo root for `composer.json` | Added `src/` subdirectory detection |
| "Ingest" trigger word unreliable | AI interpreted as "describe" not "execute" | Eliminated — `link-project` fills context directly |
| `bootstrap-project.sh` output contradicted README | Pointed to wrong next step | Aligned all outputs |
| Git identity prompted too early | First item in "Next steps" | Moved to optional, after setup |
| No "what now?" after setup | User stuck with no guidance | Added post-setup guidance to CLI output and README |
| README step numbering contradicted itself | Multiple sections with different numbers | Single linear flow, no duplicates |

---

## Design Principles

| Principle | Application |
|---|---|
| Separation of concerns | Three layers with clear boundaries |
| Convention over configuration | Templates scaffold correct structure |
| Progressive disclosure | Auto-loaded rules are minimal; workflows load on demand |
| Fail-safe defaults | Guardrails on by default; features off by default |
| Scripts over AI triggers | Setup relies on bash scripts, not AI interpreting keywords |
| Incremental adoption | Start with 5 steering files, add more as patterns emerge |

---

## Strengths

- **One-command bootstrapping** — zero-to-productive in minutes
- **Portable** — toolkit travels across employers and projects
- **Safety by default** — AI cannot bypass guardrails
- **Knowledge compounds** — every session adds to project knowledge
- **No AI trigger dependency for setup** — scripts handle detection and context fill
- **Template-driven** — 13 steering templates cover any project type
- **Grounded in reality** — every rule traces to an actual incident

---

## Limitations

| Limitation | Mitigation |
|---|---|
| Relies on AI reading steering for workflows | Written in plain language, routing table explicit |
| Assumes sibling directory layout | Scripts use `../agentic-toolkit` — documented |
| Detection is heuristic (regex on config files) | Covers common patterns; user can refine context manually |
| Single developer tested | Not yet validated with teams |
| Context window pressure with many steering files | Auto-loaded kept to 5-6 concise files |
| No template versioning | Re-scaffolding is manual |

---

## Origin

This system emerged from real production work (batch accounting system, todo app, GraphQL API) where:

- A commit-without-review incident drove the git safety rules
- A write-outside-workspace incident drove the filesystem boundaries
- Unreliable AI trigger words drove the "scripts over keywords" principle
- Repeated context loss between sessions drove the three-layer separation
- The need to onboard quickly across projects drove the bootstrap automation

Every rule and design decision exists because something went wrong without it.

---

## References

- Spec-Driven Development — [Augment Code](https://www.augmentcode.com/guides/what-is-spec-driven-development)
- Agentic SDLC — [Augment Code](https://www.augmentcode.com/guides/agentic-sdlc)
- Progressive Disclosure — [Nielsen Norman Group](https://www.nngroup.com)
