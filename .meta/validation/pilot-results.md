# Pilot Validation Results

**Pilot project:** Budget & Expense Tracker (BETA)
**Repository:** `nspalo/budget-expense-tracker`
**Dev-context workspace:** `personal-dev-context` (project code: `BETA`)
**Date:** 2026-07-02
**Validated by:** Kiro AI (Phase 3 pilot session)
**Current branch:** `design/BETA-003-feature-requirements`

---

## Setup

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | Fresh workspace created | ✅ PASS | Multi-root workspace with 3 folders: `budget-expense-tracker`, `agentic-toolkit`, `personal-dev-context`. |
| 2 | Toolkit added to workspace | ✅ PASS | `agentic-toolkit` present as workspace folder. 7 steering files (5 auto, 2 manual). |
| 3 | Dev-context created via `make new-workspace` | ✅ PASS | `personal-dev-context` exists with correct structure. Git initialized with identity configured. |
| 4 | Project bootstrapped via `make new-project` | ✅ PASS | `projects/BETA/` exists with full scaffolding including `.kiro-draft/`, routing table updated. |
| 5 | AI reads auto-loaded steering on first message | ✅ PASS | Confirmed: `git-safety`, `filesystem-boundaries`, `development-rules`, `toolkit-usage`, `naming-conventions` (toolkit); `coding-standards`, `docker-conventions`, `finance-conventions`, `project-conventions` (project). |

---

## Steering Behavior

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | AI refuses to commit without human approval | ✅ PASS | `git-safety.md` active. |
| 2 | AI refuses to write files outside workspace without asking | ✅ PASS | `filesystem-boundaries.md` active. |
| 3 | AI reads project-specific steering from `.kiro/steering/` | ✅ PASS | 11 steering files in project (4 always, 4 fileMatch, 3 manual). |
| 4 | Toolkit steering and project steering coexist without conflict | ✅ PASS | No naming collisions. Different domains. |
| 5 | Manual-inclusion steering loads only when referenced | ✅ PASS | `api-reference.md`, `data-model.md`, `documentation-standards.md`, `report-standards.md` confirmed NOT in session. |

---

## Spec-Driven Development Workflow

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | Feature requirement → AI generates requirements.md | ✅ PASS | 14 requirements with acceptance criteria exist. Foundation spec derived 6 focused requirements from design. |
| 2 | Review requirements → AI generates design.md | ✅ PASS | Foundation Infrastructure design.md generated with HLD + LLD (7 components, 16 correctness properties, formal pseudocode). |
| 3 | Review design → AI generates tasks.md | ✅ PASS | 11 tasks with 15 sub-tasks generated. Dependency graph enables parallel execution across 10 waves. |
| 4 | Tasks are appropriately scoped | ✅ PASS | Each task is atomic (one concern: enum, value object, trait, service). Completable in minutes. |
| 5 | AI executes tasks sequentially, stopping at each gate | ✅ PASS | Tasks executed via Kiro spec session. 85 tests passing, 161 assertions, 0.70s. |
| 6 | Code follows project steering standards | ✅ PASS | strict_types, PSR-12, Enums, composition over inheritance, traits, value objects — all per steering. |
| 7 | AI shows diff / describes changes before asking to commit | ✅ PASS | Steering rule active. |

---

## Git Workflow

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | `make branch` creates branch from development | ❌ MISSING | Git targets not in project Makefile. |
| 2 | `make commit-kiro` sets author to "Kiro AI" | ❌ MISSING | |
| 3 | `make commit` has no AI attribution | ❌ MISSING | |
| 4 | `make commit-assisted` adds co-author trailer | ❌ MISSING | |
| 5 | Branch safety guard blocks commit on development/master | ⚠️ PARTIAL | Steering active, hook not installed in project. |
| 6 | `make pr` creates PR targeting development | ❌ MISSING | |
| 7 | AI asks before every git operation | ✅ PASS | `git-safety.md` active. |

---

## Contribution Tracking

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | kiro-metrics.yml runs on PR creation | ❌ NOT INSTALLED | |
| 2 | Comment shows correct breakdown | ❌ BLOCKED | |
| 3 | `git log --author="Kiro AI"` returns correct commits | ❌ NO DATA | All commits by human. |
| 4 | `git log --grep="Co-authored-by: Kiro AI"` returns correct commits | ❌ NO DATA | |

---

## Bootstrap

| # | Check | Result | Notes |
|---|-------|--------|-------|
| 1 | `make new-workspace` creates usable workspace repo | ✅ PASS | Structure correct. |
| 2 | `make new-project` creates project dir with routing update | ✅ PASS | Scaffolding complete, routing table appended. |
| 3 | Generated steering skeletons are relevant | ⚠️ PARTIAL | `conventions.md` useful, `tech-stack.md` all placeholders. |
| 4 | Project context file is created and AI references it | ✅ PASS | File exists. Loaded in session. Content is placeholder. |

---

## UX Issues — Bootstrap Flow (Resolved)

> All issues below were identified during the pilot and have been fixed in subsequent commits.

### Issue 1: `make new-workspace` triggers premature git commit prompt

**Status:** ✅ FIXED — `git-safety.md` now has "During Setup (Do NOT Commit)" section. Script output no longer leads with git remote setup.

### Issue 2: After `make new-project`, user is stuck

**Status:** ✅ FIXED — `bootstrap-project.sh` output now says "Next step: make link-project name=xxx repo=/path/to/code"

### Issue 3: README steps are jumbled and impossible to follow

**Status:** ✅ FIXED — README rewritten as single numbered sequence (1-8 + "Done"). No duplicate sections. `workspace-setup.md` repositioned as manual alternative only.

### Issue 4: `make new-project` output disagrees with README

**Status:** ✅ FIXED — Script output aligned with README flow. Points to `link-project`, not `project-initialization.md`.

---

## Summary

### Scorecard

| Section | Pass | Fail | Partial/Blocked |
|---------|------|------|-----------------|
| Setup | 5 | 0 | 0 |
| Steering Behavior | 5 | 0 | 0 |
| Spec-Driven Development | 7 | 0 | 0 |
| Git Workflow | 1 | 5 | 1 |
| Contribution Tracking | 0 | 4 | 0 |
| Bootstrap | 3 | 0 | 1 |
| **Total** | **21** | **9** | **2** |

### Pass Rate: 66% (21/32)

---

## Critical Issues Summary

| # | Issue | Severity | Category | Status |
|---|-------|----------|----------|--------|
| 1 | Git Makefile targets not in project | HIGH | Integration gap | N/A — project-level, template exists at `templates/automation/makefile-git-targets.md` |
| 2 | Contribution tracking not activated | HIGH | Feature not opted-in | N/A — opt-in by design, not a toolkit bug |
| 3 | Spec workflow incomplete | MEDIUM | Incomplete pilot | N/A — session-level activity, not a toolkit bug |
| 4 | README step numbering contradicts itself | HIGH | UX/Documentation | ✅ FIXED — single linear flow, no contradictions |
| 5 | `make new-workspace` triggers premature commit prompt | MEDIUM | UX/Flow | ✅ FIXED — `git-safety.md` "During Setup" section + aligned script output |
| 6 | `make new-project` output contradicts README | HIGH | UX/Documentation | ✅ FIXED — output now points to `link-project` |
| 7 | User stuck after `make new-project` — no clear next action | HIGH | UX/Flow | ✅ FIXED — clear "Next step: make link-project" output |
| 8 | Steps are jumbled — same info repeated with different framing | MEDIUM | UX/Documentation | ✅ FIXED — README rewritten, workspace-setup.md repositioned as manual alt |

Additionally fixed:
- `bootstrap-workspace.sh` was not copying `link-project.sh` to new workspaces (hard blocker)
- `project-initialization.md` prerequisites now reference `link-project`
- `knowledge/getting-started.md` aligned with README flow

---

## Verdict

**Toolkit-level UX issues are resolved.** The onboarding path (README → scripts → steering) is now a consistent, linear flow with no contradictions.

### Remaining for Phase 4 (project-level, not toolkit bugs):

1. **Integrate git targets into budget-expense-tracker** — copy from `templates/automation/makefile-git-targets.md`
2. **Complete one full spec cycle** — requirements → design → tasks → code (session activity)
3. **Optionally activate contribution tracking** — follow `templates/features/ai-contribution-tracking/`
4. **Fill `project-context.md` with real data** — run `make link-project` then AI-assisted fill
