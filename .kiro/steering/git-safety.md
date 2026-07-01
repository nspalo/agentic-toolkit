---
inclusion: auto
---

# Git Safety Rules

## Read-Only Operations (allowed without asking)

- `git status`
- `git log`
- `git diff`
- `git branch -a`
- `git stash`

## Requires Asking First

- `git checkout -b` (creating a new branch) — ask: "I'd like to create branch `{name}`. Should I go ahead?"
- `git checkout` (switching branches) — ask if switching away from a branch with uncommitted changes

## Never Without Explicit Permission

After code review is complete:

- `git commit` — ALWAYS ask: "The changes are ready for review. Want me to commit?"
- `git push` — ALWAYS ask after commit is approved
- `git merge`, `git rebase` — ALWAYS ask

## Development Flow

1. Code changes done → **STOP**. Show the diff or describe changes. Wait for review.
2. User approves → ask: "Ready to commit?"
3. User says yes → only then commit and push.

## The Principle

Code changes are the AI's job. Git operations are the user's domain. The user decides when work is committed to history.

## Incident Context

This rule exists because of a real incident where an AI assistant committed code without code review, bypassing the developer's review gate. The commit was pushed to remote before the developer could verify correctness.

Prevention: treat every git write operation as requiring explicit human approval, regardless of confidence level.
