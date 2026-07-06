# Pilot Validation Checklist

> Used during Phase 3 (Validate). The pilot session executes these checks and records pass/fail.

## Setup

- [ ] Fresh workspace created (no leftover context from previous sessions)
- [ ] Toolkit added to workspace
- [ ] Dev-context created via `make workspace-new` (or manually)
- [ ] Project bootstrapped via `make project-new`
- [ ] AI reads auto-loaded steering on first message (git-safety, filesystem-boundaries, development-rules)

## Steering Behavior

- [ ] AI refuses to commit without human approval
- [ ] AI refuses to write files outside workspace without asking
- [ ] AI reads project-specific steering from `.kiro/steering/`
- [ ] Toolkit steering and project steering coexist without conflict
- [ ] Manual-inclusion steering loads only when referenced

## Spec-Driven Development Workflow

- [ ] Feed a feature requirement → AI generates requirements.md
- [ ] Review requirements → AI generates design.md
- [ ] Review design → AI generates tasks.md
- [ ] Tasks are appropriately scoped (completable in minutes to hours)
- [ ] AI executes tasks sequentially, stopping at each gate
- [ ] Code follows project steering standards (naming, architecture, patterns)
- [ ] AI shows diff / describes changes before asking to commit

## Git Workflow

- [ ] `make branch` creates branch from development correctly
- [ ] `make commit-kiro` sets author to "Kiro AI" (not just co-author)
- [ ] `make commit` has no AI attribution
- [ ] `make commit-assisted` adds co-author trailer
- [ ] Branch safety guard blocks commit on development/master
- [ ] `make pr` creates PR targeting development
- [ ] AI asks before every git operation (branch, commit, push, PR)

## Contribution Tracking

- [ ] kiro-metrics.yml runs on PR creation
- [ ] Comment shows correct breakdown (Kiro authored / AI-assisted / human)
- [ ] `git log --author="Kiro AI"` returns correct commits
- [ ] `git log --grep="Co-authored-by: Kiro AI"` returns correct commits

## Bootstrap

- [ ] `make workspace-new` creates a usable workspace repo structure
- [ ] `make project-new` creates project dir with routing update
- [ ] `make steering-generate` produces relevant steering (when opted in)
- [ ] Project context file is created and AI references it

## Results

After completing all checks, write findings to:
`.meta/validation/pilot-results.md`

Include:
- Pass/fail per item
- Issues encountered (with severity)
- Suggestions for improvement
- Overall verdict: ready for Phase 4 (Refine) or needs more work
