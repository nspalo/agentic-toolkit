---
inclusion: manual
---

# Prompt: Code Review

## Context

Review the following code change for:
1. Correctness — does it do what it claims?
2. Standards compliance — does it follow project conventions?
3. Safety — any security, performance, or data integrity risks?
4. Completeness — are all affected locations updated?

## Checklist

- [ ] Logic is correct for all edge cases
- [ ] Error handling covers failure paths
- [ ] No breaking changes to existing behavior
- [ ] Multi-tenant impact considered (if applicable)
- [ ] Tests added or updated
- [ ] Naming follows project conventions
- [ ] No hardcoded values that should be config/constants
- [ ] No N+1 queries or performance issues
- [ ] Logging added for important operations
- [ ] Comments explain WHY, not WHAT

## Output Format

```
## Summary
[1-2 sentences: overall assessment]

## Issues Found
1. [SEVERITY] [file:line] — description
2. [SEVERITY] [file:line] — description

## Suggestions (non-blocking)
- [suggestion]

## Verdict
[APPROVE / REQUEST CHANGES / NEEDS DISCUSSION]
```

Severity levels: CRITICAL (must fix), WARNING (should fix), INFO (nice to have)
