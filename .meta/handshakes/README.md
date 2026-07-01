# Cross-Session Handshakes

## What Is a Handshake?

A structured message from one session/workspace to another. Used when work in one session produces something another session needs to know about, validate, or act on.

## When to Create a Handshake

| Trigger | Example |
|---------|---------|
| A phase is complete and another session needs to validate | "I built the toolkit, planner session please review" |
| A session needs input/decision from another context | "I need the project architecture to proceed, workspace B has it" |
| Work is blocked waiting on another session's output | "Can't start pilot until builder confirms tests pass" |
| A session discovered something that changes the plan | "Found an issue that affects the roadmap, all sessions should know" |
| Context transfer needed (you're switching sessions) | "Here's where I left off, pick up from here" |

**Rule:** If you're about to close a session and another session needs what happened here — write a handshake.

## How to Create a Handshake

### Filename

```
NNN-{short-description}.md
```

- `NNN` = sequential number (next after highest in archive)
- Example: `005-pilot-results.md`, `006-roadmap-update.md`

### Location

- Active (needs response): `.meta/handshakes/005-pilot-results.md`
- After acknowledged: move to `.meta/handshakes/archive/`

### Template

```markdown
# NNN — Title

> **Date:** YYYY-MM-DD
> **From:** [session/workspace name] ([role: planner/builder/tester])
> **To:** [target session/workspace] ([role])
> **Action required:** [REVIEW / ACKNOWLEDGE / DECIDE / INFORM ONLY]
>
> **Delete after acknowledgment.**

---

## Context

[Why this handshake exists. What happened that the other session needs to know.]

## What Was Done

[Concrete deliverables, changes, or findings.]

## What's Needed from You

[Specific action the target session should take.]

## Deadline / Priority

[Is this blocking? Can it wait until next session?]
```

## What to Include

| Always include | Include if relevant |
|---------------|-------------------|
| Date | Files created/modified |
| From/To (session + role) | Decisions made |
| Action type (review/ack/decide/inform) | Blockers discovered |
| Summary of what happened | Metrics or evidence |
| What you need from the other session | Links to related files |

## What NOT to Include

- Full conversation history (summarize instead)
- Raw code diffs (reference the file/branch instead)
- Opinions without evidence (state facts, let the other session evaluate)

## Action Types

| Type | Meaning | Expected Response |
|------|---------|-------------------|
| REVIEW | "Look at this and tell me if it's right" | Written feedback or ack |
| ACKNOWLEDGE | "I'm informing you, confirm you received it" | Short ack |
| DECIDE | "I need you to choose between options" | Decision with reasoning |
| INFORM ONLY | "FYI, no response needed" | None (move to archive) |

## Lifecycle

```
1. Session A creates handshake → .meta/handshakes/NNN-topic.md
2. Session B reads it
3. Session B acts on it (review, decision, etc.)
4. Session B either:
   a. Writes a response handshake (NNN+1-topic-ack.md), OR
   b. Updates the original with "ACKNOWLEDGED" status
5. Move completed handshakes to .meta/handshakes/archive/
```

## Examples from This Project

| # | From → To | Type | Topic |
|---|-----------|------|-------|
| 001 | Planner → Builder | INFORM | Original toolkit plan |
| 002 | Builder → Planner | REVIEW | Implementation report |
| 003 | Planner → Builder | ACKNOWLEDGE | Implementation confirmed |
| 004 | Builder → Planner | INFORM | Pilot ready |
