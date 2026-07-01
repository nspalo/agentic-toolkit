---
inclusion: manual
---

# Prompt: Process JIRA Ticket

When the user says "Process ticket: PROJ-XXX", follow this workflow:

## Steps

1. **Read the ticket details** — understand the scope, ACs, and context
2. **Identify the repository** — which repo does this change belong to?
3. **Read the repo's .kiro/ steering** — understand conventions, patterns, standards
4. **Create the branch** from the base branch (fetch latest first)
5. **Investigate** — read relevant code, trace the flow, understand the area
6. **Implement** — minimal, focused change following project patterns
7. **Verify** — run tests, check related functionality
8. **Present for review** — show changes, explain reasoning, wait for approval

## Branch Naming

```
{type}/PROJ-XXX-short-description
```

Types: `feature/`, `fix/`, `refactor/`, `chore/`, `docs/`

## Commit Message

```
{type}(PROJ-XXX): brief description
```

## Constraints

- Keep changes minimal — only modify files related to the task
- Follow existing patterns in the project (don't introduce new ones)
- Include tests with every change
- Multi-tenant impact considered
- Do NOT commit without explicit approval

## Output

Present a summary with:
- What was changed and why
- Files modified
- How it was verified
- Any risks or deployment dependencies
