# 006 — Pilot Re-run Request

> **Date:** 2026-07-02
> **From:** builder session
> **To:** pilot test session
> **Action required:** RE-RUN PILOT
>
> **Delete after completed.**

---

## Context

Issues from `005-pilot-feedback.md` have been addressed. A re-run is needed to validate the fixes.

## What Was Fixed

| Issue | Fix Applied |
|---|---|
| README didn't match real flow | Rewritten as linear "Getting Started" with numbered steps 1-9 |
| `context=` not documented | Added to README with example and output |
| Git config undocumented | Added "Git identity guidance" section |
| Routing table duplicates | Added `grep -q` dedup check before appending |
| No way to fill empty project-context.md | NEW: `make link-project name=xxx repo=/path` scans repo, produces `.detected-stack.md` |

## New Command: `link-project`

```bash
make link-project name=beta repo=~/nimbusdrive/budget-expense-tracker
```

This:
1. Scans the repo (composer.json, package.json, .env, Makefile, docker, .kiro/)
2. Auto-detects: language, framework, DB, build tool, testing, existing steering
3. Writes `projects/{name}/.detected-stack.md` with all findings
4. Tells user: "Say to AI: Read .detected-stack.md and help me fill project-context.md"

## Re-run Instructions

1. Delete existing `personal-dev-context`: `rm -rf ~/ai-workflow/personal-dev-context`
2. Follow toolkit README from step 1 (linear guide)
3. Use budget-expense-tracker as the project repo
4. Test the full chain: `make new-workspace` → `make new-project` → `make link-project` → AI fills context
5. Validate: does the AI contextualize itself correctly from the auto-loaded steering + detected stack?

## Success Criteria

- [ ] `make new-workspace` creates workspace without issues
- [ ] `make new-project` scaffolds correctly (no duplicates, correct paths)
- [ ] `make link-project` detects: PHP, Laravel 12, MySQL, Vite, PHPUnit+Vitest, Docker, existing .kiro/
- [ ] `.detected-stack.md` contains useful info for AI to fill context
- [ ] AI can fill `project-context.md` from `.detected-stack.md` without manual intervention
- [ ] Toolkit steering auto-loads and enforces (git safety, naming, development rules)
- [ ] Artifacts route correctly (investigation → correct project dir)

## Note on Pilot Project Choice

The budget-expense-tracker HAS existing `.kiro/steering/` files. This is fine for testing `link-project` and coexistence. But for a pure "bootstrap from zero" test, use a project without existing `.kiro/` in a future pilot.
