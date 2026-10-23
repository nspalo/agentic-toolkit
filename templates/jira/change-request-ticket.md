# PROJ-XXX — [CR] [Short Title]

**Type:** Subtask (under the original spec's Coding story) — or Story, if the change is large enough to be its own spec
**Parent / Supersedes:** [PROJ-YYY — the original completed spec's Coding story]
**Epic:** [PROJ-ZZZ — the original feature epic]
**Priority:** [High / Medium / Low]
**Assignee:** [Name]
**Deadline:** [date, if the change has a hard deadline]
**Source (decision):** [REF / Slack / ADR that drives this change]
**Decision (ADR):** [relative path to the ADR, if written]

> **This is a Change Request to an already-completed spec.** The original spec/stories remain the record of what was built (do NOT edit or reopen them). This CR is new, separately-tracked work that *supersedes* the original deliverable. See the toolkit's `workflows/spec-driven-development.md` → "Change Requests to an Already-Completed Spec".

---

## Summary

[What is changing and why. State plainly that this reverses/modifies previously-merged work, and name the original spec/PR by ID.]

## Context

- The original work was specified, reviewed, signed off, coded, and **merged** (PR #NNN).
- The change arrived **after** merge, so this modifies merged code — it is not cancelling unstarted work.
- KEEP / do-not-touch: [anything from the original that stays — name it explicitly].

## Scope (grounded in the actual merged code)

> Verify each item against the live code on the target branch **before** changing it. Do not trust a remembered footprint.

- [ ] `[file/path]` — [exact change: delete / remove block / edit]
- [ ] `[file/path]` — [exact change]
- [ ] `[config / tests]` — [exact change]
- [ ] Stamp the original spec folder `.kiro/specs/{name}/` as **superseded-by [PROJ-XXX]** (note only — do NOT regenerate or rewrite it).

## Out of scope / do NOT touch

- [Shared pieces the change must leave intact — name them.]

## Shared-code check before changing (do this first)

- [ ] [Any method/table/test the change *looks* like it owns but may be shared with surviving work — grep and confirm ownership before deleting/editing.]

## Acceptance Criteria (Definition of Done)

- [ ] [Testable criterion — the thing is removed/changed]
- [ ] [A grep / search proving no dangling references remain]
- [ ] [Relevant test suites pass — no regression in surviving work]
- [ ] Original spec folder carries the superseded-by note; original spec stories unchanged (still "Done").

## Verification

[How to verify — test command, smoke run, grep-to-zero.]

## QA scope note (if applicable)

[If the change removes a deliverable QA might otherwise test: state it is OUT of QA scope and what QA verifies instead.]

## Tracking note

- The original spec's stories/time logs stay **Done** — this CR does not reopen them or mark them "won't do".
- Removal/modification effort is logged against **this CR**, preserving both the original build effort and the change effort.

## References

- Source (decision): [REF / ADR]
- Original spec: `.kiro/specs/{name}/` (superseded-by this CR)
- Dev-context source of record (full Markdown): `projects/{name}/technical-notes/jira/tickets/PROJ-XXX-....md`
