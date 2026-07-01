# Commit Conventions

## Format

```
{type}({scope}): {description}

[optional body]

[optional footer]
```

## Types

| Type | When to use |
|---|---|
| `feat` | New feature or functionality |
| `fix` | Bug fix |
| `refactor` | Code restructuring (no behavior change) |
| `chore` | Tooling, config, dependencies, maintenance |
| `docs` | Documentation only |
| `test` | Adding or fixing tests |
| `style` | Formatting, whitespace (no logic change) |
| `perf` | Performance improvement |
| `ci` | CI/CD configuration |

## Scope

The JIRA ticket ID or feature area:

```
feat(PROJ-001): add user authentication
fix(PROJ-042): correct date boundary check
chore(deps): update framework to latest
docs(readme): add setup instructions
```

## Rules

- First line ≤ 70 characters
- Use imperative mood ("add" not "added", "fix" not "fixed")
- No period at the end of the subject line
- Body explains WHY, not WHAT (the diff shows what)
- JIRA codes stay uppercase (PROJ-001, PROJ-042)
- Default: human author only (no co-author footer)

## AI Contribution Tracking (Optional — Off by Default)

AI contribution tracking is an opt-in feature. When **inactive** (default), all commits use the human author with no co-author footer.

When **activated** for a project, attribution follows:

| Who did the work | Author | Co-Author |
|---|---|---|
| AI wrote code, human reviewed | Human | AI (co-author footer) |
| AI wrote most of the code autonomously | AI | Human (co-author footer) |
| Human wrote code, AI helped debug/suggest | Human | None |

To activate: see `templates/features/ai-contribution-tracking/README.md` for setup.

When inactive, never add co-author footers — all commits are simply authored by the human.

## Examples

```
feat(PROJ-001): add user authentication
fix(PROJ-042): correct date boundary check
refactor(PROJ-035): extract enum from utility class
chore(PROJ-100): update Makefile for legacy support
test(PROJ-052): add typed resource unit tests
docs(kb): add knowledge base article
```
