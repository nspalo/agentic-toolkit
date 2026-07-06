# Pilot Plan — BETA Project (Budget & Expense Tracker App)

**Date:** 2026-07-05
**Purpose:** Validate the agentic-toolkit end-to-end with a real project from zero to working feature.
**Status:** Ready to execute

---

## What We're Validating

| Phase 3 Checklist Item | How BETA covers it |
|---|---|
| New workspace from scratch | `personal-dev-workspace` — fresh, no pre-existing context |
| New project from scratch | `beta` — bootstrapped via `make new-project` |
| `link-project` detection | Scan BETA repo, auto-detect Laravel/Vue/Docker stack, fill context |
| AI follows steering without reminders | New workspace loads toolkit steering — proves it works cold |
| Spec-driven development | User login feature — requirements → design → tasks → code |
| Git workflow | Branch, implement, commit, PR (following BETA conventions) |
| Full end-to-end | From zero to working login endpoint |

---

## Workspace Setup

| Layer | Directory | Purpose |
|---|---|---|
| Toolkit | `~/ai-workflow/agentic-toolkit` | HOW — methodology, rules, workflows |
| Dev-context | `~/ai-workflow/personal-dev-workspace` (TBD name) | WHERE — artifacts, knowledge |
| Project | `~/nimbusdrive/budget-expense-tracker` | WHAT — the actual code |

All three open in Kiro as a multi-root workspace.

---

## Steps

### 1. Create personal dev-context workspace

```bash
cd ~/ai-workflow/agentic-toolkit
make new-workspace name=personal-dev-workspace context="Personal projects"
```

### 2. Bootstrap BETA project

```bash
cd ~/ai-workflow/personal-dev-workspace
make new-project name=beta
make link-project name=beta repo=~/nimbusdrive/budget-expense-tracker
```

### 3. Open workspace in Kiro

Add all three repos to the Kiro workspace:
- `~/nimbusdrive/budget-expense-tracker`
- `~/ai-workflow/personal-dev-workspace`
- `~/ai-workflow/agentic-toolkit`

### 4. Load context and verify

In the Kiro session:
> "Read `projects/beta/project-context.md`"

Verify:
- Steering files auto-loaded (toolkit + workspace + project)
- AI knows the tech stack without being told
- AI follows conventions without manual reminders

### 5. Run spec-driven development for User Login

Use the spec workflow:
> "Start a new feature: user login with Sanctum + GraphQL"

Expected flow:
1. Requirements → define what login does (inputs, outputs, errors, session)
2. Design → which files, services, schema changes
3. Tasks → atomic implementation steps
4. Execute → code each task, verify, commit

### 6. Document results

After completion, write:
- `~/ai-workflow/agentic-toolkit/.meta/validation/pilot-results.md`
- What worked without intervention
- What needed manual correction
- What steering/workflow needs updating

---

## BETA Project Context (from existing steering)

The project already has `.kiro/steering/` files in the code repo:
- `project-conventions.md` — tech stack, git flow, file structure
- `coding-standards.md` — PSR-12, SOLID, type safety, naming
- `docker-conventions.md` — Docker stack, Makefile interface
- `finance-conventions.md` — centavos, date boundaries, audit trail

**Tech stack:** Laravel 12, PHP 8.4, Lighthouse GraphQL, Vue 3, Tailwind 4, Vite 7, MySQL 8, Docker Compose, Sanctum auth.

**Project code:** BETA
**Git flow:** master ← development ← feature/* branches
**Commit format:** `type(BETA-XXX): description`

---

## Success Criteria

- [ ] Workspace bootstrapped in under 5 minutes (commands only, no manual file editing)
- [ ] `link-project` correctly detects Laravel + Vue + Docker + GraphQL stack
- [ ] AI follows project conventions (commit format, branch naming, file placement) without reminders
- [ ] Spec workflow produces requirements → design → tasks for user login
- [ ] At least one task results in working, verified code (login endpoint responds correctly)
- [ ] No toolkit methodology files needed manual loading (all auto-included via `.kiro/steering/`)

---

## Notes

- The BETA project already exists with Docker setup and steering files — it's not a blank repo
- The `link-project` script will detect the existing stack and fill `project-context.md`
- The personal workspace is completely separate from `bizmates-dev-context` (company workspace)
- This pilot validates the toolkit is truly portable and company-agnostic
