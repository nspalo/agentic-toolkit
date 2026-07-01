# PR Creation Workflow

## Flow

```
Branch → Code → Review → Commit → Push → PR
```

## Step 1: Create Branch

```bash
make branch name="{type}/PROJ-XXX-description"
```

Or manually:
```bash
git checkout development  # or main
git pull
git checkout -b {type}/PROJ-XXX-description
```

Branch types: `feature/`, `fix/`, `refactor/`, `chore/`, `docs/`

## Step 2: Code

Make changes. Follow project conventions. Keep scope focused.

## Step 3: Review

**STOP.** Show the diff or describe changes. Wait for human review.

Do NOT proceed to commit without approval.

## Step 4: Commit

```bash
make commit msg="{type}(PROJ-XXX): description"
```

Or manually:
```bash
git add .
git commit -m "{type}(PROJ-XXX): description"
git push -u origin $(git branch --show-current)
```

## Step 5: Create PR

```bash
make pr title="PROJ-XXX - Description" body="Summary of changes"
```

Or manually:
```bash
gh pr create --base development --title "PROJ-XXX - Description" --body "Summary"
```

## Commit Message Convention

```
{type}(PROJ-XXX): brief description
```

Types:
- `feat` — new feature
- `fix` — bug fix
- `refactor` — code restructuring (no behavior change)
- `chore` — tooling, config, dependencies
- `docs` — documentation only
- `test` — adding or fixing tests

See `templates/automation/commit-conventions.md` for full reference.

## PR Description Structure

```markdown
## Summary
[What changed and why]

## Changes
- [Bullet points of key changes]

## Testing
- [How it was verified]

## Notes
- [Blocked features, deployment dependencies, known issues]
```
