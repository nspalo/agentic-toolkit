# Load the Standard Before Producing an Artifact

> Portable lesson. Generic failure; ASCA is only the example.

## The failure mode

An agent produces a formatted artifact (investigation report, KB article, ADR, ticket, estimate) from memory instead of loading the governing standard/template first. Result: wrong header, missing required fields, invented structure — caught only when the human notices and repeatedly points it out.

## What it looked like (real incident)

An investigation report was written with a made-up Document Info block ("Type: Investigation (read-only)", single Date, no Status/Audience/JIRA, no Reported/Investigated/Environment lines) instead of the format in `report-standards.md`. The agent didn't reformat it until the human flagged it **three separate times**, and even then only fixed the file the human pointed at — never proactively.

## Root cause

- **The governing standards are `inclusion: manual`** (`report-standards.md`, `documentation-standards.md` for some parts). They do NOT auto-load. If the agent doesn't deliberately load them, they aren't in context.
- The agent wrote from memory/pattern instead of loading the source of truth.
- Reactive, not proactive — fixed only what was pointed at, one file at a time.

## Guardrail

**Before producing any formatted artifact, load its standard/template first.** Match the artifact type to its source:

| Producing... | Load first |
|---|---|
| Investigation report | `.kiro/steering/report-standards.md` |
| Any project doc (design, estimate, ADR, KB, guide) | `.kiro/steering/documentation-standards.md` (Document Info block) + the matching `templates/documentation/*` |
| JIRA ticket | `templates/jira/*` |
| Steering file | existing steering conventions / `templates/steering/*` |

Rules:
- If the standard is `inclusion: manual`, that means **you must load it on demand** — its being manual is not permission to skip it.
- Apply the standard when the artifact is **first created**, not after review.
- When one artifact of a type is found non-conforming, **check all artifacts of that type**, not just the one flagged.

## The one-line test

Before writing a report/doc/ticket, ask: *"Have I loaded the standard for this artifact type in this session?"* If no, load it first.

## Related

- `.kiro/steering/report-standards.md` — investigation report header + structure (manual)
- `.kiro/steering/documentation-standards.md` — Document Info block (auto)
- `knowledge/avoiding-analysis-drift.md` — sibling lesson on staying on the critical path
