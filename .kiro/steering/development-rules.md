---
inclusion: auto
---

# Development Rules

## General

1. **Read before writing** — always read relevant existing code before proposing changes. Never assume structure.
2. **Minimal changes only** — fix the specific issue. Don't refactor adjacent code in the same change.
3. **Explain reasoning** — when proposing a solution, explain why this approach over alternatives.
4. **Flag risks explicitly** — multi-tenant impact, deployment dependencies, cross-service effects.
5. **Ask when uncertain** — if unsure about a table name, pattern, or convention, ask. Don't assume.
6. **Never combine unrelated actions** — each action requiring approval must be asked separately.

## Investigation & Analysis

1. **Never assume data is correct** without verifying against business rules.
2. **Never propose a fix until root cause is verified and certain.**
3. **Do not frame observations as root causes** — use "observed behavior" until verified.
4. **State what is known vs not verified** — mark unverified claims explicitly.
5. **Never report half-baked truth** — every claim must be backed by data or marked as inferred.
6. **When referencing a test case or ticket**, include the ID and brief description for context.

## Multi-Repo Awareness

- When working across multiple repos, always prefix paths with the repo shorthand
- Verify table/model names from source (model property, migration file) — never pattern-match
- Changes in one repo may affect another — flag cross-repo dependencies

## Confidence Markers

When making claims in reports or analysis, always state what is confirmed vs inferred:

- "Root cause (code trace, not yet verified with data)"
- "Confirmed via query (see Appendix)"
- "Inferred from code — needs data verification"
