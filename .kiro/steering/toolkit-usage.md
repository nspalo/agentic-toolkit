---
inclusion: auto
---

# Agentic Toolkit — Usage Guide

This repo is a portable AI development methodology toolkit. It provides rules, workflows, templates, and knowledge for AI-assisted software development.

## Critical Triggers

### "Enrich {project}" / "Deep scan {project}"

This trigger is for **refining** an already-linked project. The `make project-link` command fills `project-context.md` with auto-detected data. If the user wants richer context (models, routes, architecture details), they say "Enrich {project}" and you should:

**Step 1: Read existing context**
- Read `[workspace]/projects/{project}/project-context.md` (already has basic data from project-link)
- Read `[workspace]/projects/{project}/.detected-stack.md` (if it exists)

**Step 2: Read the project's code repo for deeper detail**
- Read the project repo's `README.md`
- Read `composer.json` or `package.json` (check `src/` if not at root)
- Read `Makefile` (check for make targets)
- Scan `app/Models/` or equivalent for key models
- Check `routes/` or equivalent for key endpoints/commands

**Step 3: EDIT project-context.md**
- **Use the file editing tool** to update `project-context.md` with richer data
- Fill in any remaining TBA sections with real discovered information
- Add models, routes, architecture patterns you discovered

**Step 4: Output confirmation**
```
✅ Project context enriched — {project}
```

**CRITICAL:** You must USE THE FILE EDITING TOOL to write content into `project-context.md`. Do NOT just summarize. EDIT THE FILE.

## When to Consult This Toolkit

### Workflows (step-by-step processes)

| Trigger | What to load | What it does |
|---|---|---|
| "Enrich {project}" / "Deep scan {project}" | `workflows/project-initialization.md` | Enrich an already-linked project — read deeper into code, fill remaining TBA sections in project-context.md |
| "Validate workspace for {project}" | `knowledge/getting-started.md` § Workspace Validation | Output three-layer handshake confirming readiness |
| "Investigate this issue" / "Look into this bug" | `workflows/investigation.md` | Guides the full investigation process: gather facts → trace code → form hypothesis → verify → write report |
| "Fix this bug" | `workflows/bug-fix.md` | Understand → identify scope → implement → verify flow with N-location checklist |
| "Create a PR" | `workflows/pr-creation.md` | Branch → code → review → commit → push → PR with commit conventions |
| "Start a new feature" / "Use spec workflow" | `workflows/spec-driven-development.md` | Requirements → design → tasks → execute with review gates between each |
| "Run tests" / "Validate changes" | `workflows/tiered-testing.md` | Smoke → Unit → Functional → Acceptance tiers with verification methods |
| "Bootstrap new project" / "Set up project" | `workflows/project-initialization.md` | Discover project → fill context → determine which steering files to create |
| "Create a new workspace" | `workflows/workspace-setup.md` | Create a new workspace repo from template |
| "Extract learnings" / "Update the toolkit" | `workflows/extract-to-toolkit.md` | Pull generic patterns from project knowledge back into toolkit |
| "Add {type} steering" | `workflows/project-initialization.md` § Phase 3 | Determine which steering file to add based on project characteristics |

### Standards (format and quality rules — load alongside workflows)

| Trigger | What to load | What it enforces |
|---|---|---|
| Writing an investigation report | `.kiro/steering/report-standards.md` | Report header format, confidence markers, structure, file naming |
| Writing documentation or KB articles | `.kiro/steering/documentation-standards.md` | Inverted pyramid section order, progressive disclosure |

### Templates (fill-in structures — copy and customize)

| Trigger | What to load | Output format |
|---|---|---|
| "Write a KB article" | `templates/documentation/knowledge-base-article.md` | Problem → Root Cause → Fix → Prevention |
| "Create a test case" | `templates/features/document-based-testing/test-case-template.md` | TCNNN format (requires document-based testing feature) |
| "Write a ticket" / "Draft a bug fix" | `templates/jira/bug-ticket.md` | Summary → Current/Expected → Root Cause → ACs |
| "Create a dev task" / "Draft a task" | `templates/jira/task-ticket.md` | Summary → Context → Implementation → ACs → Verification |
| "Write a story" | `templates/jira/story-ticket.md` | User story → ACs → Technical Notes |
| "Write an epic" | `templates/jira/epic.md` | Goal → Scope → Stories → Success Criteria |
| "Write an engineering report" | `templates/documentation/engineering-report.md` | Problem → Proposals → Roadmap → Strengths/Limits |
| "Record a decision" | `templates/documentation/architecture-decision-record.md` | Context → Decision → Consequences → Alternatives |
| "Write a POC report" | `templates/documentation/poc-report.md` | Problem → Concept → How → Methodology → Results → Analysis |
| "Write a team guide" / "Create a guide" | `templates/documentation/team-guide.md` | Audience → TL;DR → Context → How It Works → Reference |
| "Review code" | `templates/prompts/code-review.md` | Checklist + structured output format |
| "Analyze architecture" | `templates/prompts/architecture-analysis.md` | Map → Assess → Identify → Document |
| "Process a JIRA ticket" | `templates/prompts/process-jira-ticket.md` | End-to-end ticket processing workflow |

### Knowledge (reference material — consult when needed)

| Trigger | What to load | What it explains |
|---|---|---|
| "How does this agentic workflow work?" | `knowledge/getting-started.md` | Full system overview, three layers, lifecycle |
| "How should I structure .kiro/steering?" | `knowledge/kiro-steering-patterns.md` | Inclusion types, sizing, layering, common patterns |
| "How do we track AI contributions?" | `templates/features/ai-contribution-tracking/README.md` | Opt-in feature: attribution, labels, metrics workflow |
| "How does the verification methodology work?" | `knowledge/three-point-verification.md` | Code ↔ Test Cases ↔ Output triangle (related to document-based testing feature) |
| "How do I set up document-based testing?" | `templates/features/document-based-testing/README.md` | Opt-in feature: markdown test scenarios for file-based verification |
| "How do I set up tooling?" | `knowledge/tooling-setup.md` | gh CLI, git identity, CRLF, Zone.Identifier, WSL safe dirs |

### Steering templates (for new project setup)

When initializing a new project, `workflows/project-initialization.md` guides which of these to copy into the project's `.kiro-draft/steering/`:

| Template | When needed |
|---|---|
| `templates/steering/system-overview.md` | Every project |
| `templates/steering/tech-stack.md` | Every project |
| `templates/steering/coding-standards.md` | Every project |
| `templates/steering/backend-patterns.md` | Non-standard architecture |
| `templates/steering/frontend-standards.md` | Frontend projects |
| `templates/steering/api-standards.md` | API projects |
| `templates/steering/architecture-overview.md` | Multi-service systems |
| `templates/steering/database-standards.md` | DB-heavy projects |
| `templates/steering/multi-tenancy.md` | Multi-tenant projects |
| `templates/steering/glossary.md` | Complex domain terminology |
| `templates/steering/batch-execution-flow.md` | Batch/cron systems |
| `templates/steering/fix-bug.md` | When a fix pattern emerges |
| `templates/steering/troubleshooting.md` | After accumulated issues |

### Opt-in features (for specific project needs)

| Feature | When needed |
|---|---|
| `templates/features/document-based-testing/` | Verification is file-based (CSV, reports) — not standard test frameworks |
| `templates/features/ai-contribution-tracking/` | Team wants to track AI vs human contributions |

## Artifacts Go to Your Workspace Repo

This toolkit defines HOW to work. The actual artifacts (reports, test cases, tickets) go to the project's directory in your workspace repo. Never create project artifacts in this toolkit repo.

If you don't have a workspace repo yet, see `workflows/workspace-setup.md`.

## File Naming

See `.kiro/steering/naming-conventions.md` (auto-loaded).
