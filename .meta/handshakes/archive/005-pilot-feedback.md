# 005 — Pilot Feedback (Setup Validation)

> **Date:** 2026-07-02
> **From:** biz-todo-app session (planner/validator)
> **To:** builder session
> **Action required:** REVIEW + FIX
>
> **Delete after addressed.**

---

## Context

A pilot test was conducted for the actual setup flow using the budget-expense-tracker project with a fresh `personal-dev-context` workspace. The pilot results are in `.meta/validation/pilot-results.md`.

This handshake focuses on **setup flow issues** discovered during the pilot — things that a first-time user would encounter.

---

## Issue 1: Budget Tracker Was a Bad Pilot Choice

**Problem:** The budget-expense-tracker already has `.kiro/steering/` files (11 of them). This means the pilot didn't test "setting up steering from scratch using the toolkit's templates." It tested coexistence, not initialization.

**Suggestion:** Toolkit README or validation checklist should note: "Pilot with a project that has NO existing `.kiro/` setup" to properly test the bootstrap-to-steering pipeline.

---

## Issue 2: README Does Not Match Real Setup Flow

**Problem:** The README doesn't document the actual sequence a user would follow. Real flow is:

1. Git clone the project repo (or create new)
2. Git clone the toolkit repo
3. Add both to Kiro workspace
4. (Optionally) create a dev-context workspace
5. Bootstrap a project in the dev-context
6. Start working

The README jumps around and doesn't present this as a linear "Getting Started" guide. A first-time user wouldn't know the order of operations.

**Fix needed:** A clear "Getting Started" section in README:
```
1. Clone this repo
2. Clone your project repo
3. Open Kiro, add both as workspace folders
4. (Optional) Create a dev-context: `make new-workspace name=xxx`
5. Add dev-context to workspace
6. Bootstrap project: `cd xxx && make new-project name=yyy`
7. Start a session
```

---

## Issue 3: `make new-workspace` — `context=` Variable Not Documented

**Problem:** The README shows `make new-workspace name=xxx` but doesn't mention the optional `context=` parameter. User runs it, gets a workspace with no description. The output says:

```
✅ Workspace 'personal-dev-context' created at /home/bizdev/ai-workflow/personal-dev-context
Next steps:
```

But those "next steps" aren't in the README either. User is left guessing.

**Fix needed:** Document `context=` in README and show example with output.

---

## Issue 4: Git Config Process Was Odd

**Problem:** During workspace creation, the bootstrap script asks about git config (name/email). This was unexpected and not documented in the README. User didn't know if they should use personal or work credentials.

**Fix needed:** Document in README that bootstrap will configure git identity. Explain when to use personal vs work email (since toolkit is personal, but workspace might be company).

---

## Issue 5: `make new-project` Issues

**Problem:** Several issues with project bootstrap:

1. `workspace-identity.md` routing table not updated correctly (duplicate entries, case sensitivity: `beta` vs `BETA`)
2. `projects/BETA/project-context.md` was empty template with TBA placeholders — provides no value to AI without manual filling

**Fix needed:**
- Fix case sensitivity in routing table update
- Deduplicate logic (check if project already exists before appending)

---

## Issue 6: No Command to Link Project Repo to Dev-Context

**Problem:** After `make new-project`, the `project-context.md` is empty. There's no automated way to say "look at this repo and fill in the context." The user has to manually write project details.

**Suggestion:** Add a command or workflow step:
```bash
make link-project name=BETA repo=/path/to/budget-expense-tracker
```

This would:
- Scan the repo (check for `composer.json`, `package.json`, `.env.example`, etc.)
- Auto-detect: language, framework, database, build tool
- Pre-fill `project-context.md` with discovered info
- Update `tech-stack.md` template with real values
- Link the repo path in the routing table

This is the biggest friction point: the gap between "scaffold exists" and "scaffold has useful content."

---

## Summary of Required Fixes

| # | Issue | Priority |
|---|-------|----------|
| 1 | README doesn't match real setup flow | HIGH |
| 2 | `context=` not documented | MEDIUM |
| 3 | Git config during bootstrap undocumented | MEDIUM |
| 4 | `workspace-identity.md` duplicate/case issues | MEDIUM |
| 5 | No `link-project` or repo-scan command | HIGH (biggest friction) |
| 6 | Pilot choice guidance (use project without existing .kiro) | LOW |

---

## Verdict

The infrastructure works (steering, coexistence, safety rules pass perfectly). The gap is **developer experience on first use** — the README and bootstrap need to guide a user from zero to productive without guessing. The `link-project` / repo-scan concept would eliminate the biggest friction point (empty project-context.md).

Fix items 1, 4, and 5, re-run pilot with a clean project (no existing `.kiro/`), and it should pass Phase 3.
