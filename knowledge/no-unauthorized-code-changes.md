# No Unauthorized Changes (Code or Artifacts)

> Portable lesson. Generic failure mode. Examples below are anonymized — no company, project, person, or file names.

## The rule

The AI must **never** modify a code repository, **nor generate/edit a deliverable artifact**, unless the user has, **in the current turn**, explicitly asked it to. Everything else — grooming tickets, writing specs, investigating, designing, "helping the assignee get a head start" — produces **documents on request**, not unrequested edits.

Two sub-rules:

1. **Code:** no repo edit without an explicit "implement / apply / change the code" this turn.
2. **Artifacts:** no producing/editing a gated deliverable (`requirements.md`, `design.md`, `tasks.md`, reports, tickets) without an explicit "generate / write / proceed" this turn.

## The failure mode

The AI is doing a read-only or planning task and decides to "helpfully" produce the next thing — code, tests, or a spec document — that the user never asked for in this turn. The work may belong to someone else, or belong to a later gated phase. The user must now cancel, revert, and redo — the opposite of help.

**Intent is not instruction.** "I plan to X", "I'll start with Y", "next I want to Z" describe a plan. They are context, not authorization. The correct response to a stated plan is to finish any read-only step, confirm scope, and **wait for an explicit go**.

## Example incidents (anonymized)

### Incident A — unauthorized code during grooming

While grooming a ticket delegated to another developer (add an enum value + test), the user said "add the needed unit test for [assignee]" — meaning **put the test in the ticket** so the assignee has it ready. The AI instead edited the enum source and its test file directly in the code repo. No code instruction, no spec, not the AI's work to do. The user cancelled and reverted.

### Incident B — unauthorized spec generation from a stated plan

After being asked only to *check a project timeline*, the user added: "I plan to generate the design doc for both repos, but will start with [repo] first." The AI finished the timeline check and then immediately wrote a full design document into the spec folder. The user had given no go signal, and had explicitly noted that design must come from the **spec-driven workflow**, not a one-shot prompt. The user had to delete the file.

**Aggravating:** Incident B repeated Incident A's root pattern in the *same session* in which the AI had read and summarized Incident A ~1 hour earlier. Reading the guardrail created false confidence; it was not applied at the decision point.

### Incident C — incomplete execution against a known, written set

A design doc had surfaced **three** dependencies that all had to be ticketed before dependent work could start — all approved together, all listed explicitly in a project-context file the AI had itself just edited. Asked to raise them, the AI created tickets for **two** and silently dropped the third. The third was the odd one out by *location* (it touched a different repo than the other two), so it fell outside the AI's mental frame of the moment's phrasing ("the [repo] changes") even though the authoritative list grouped all three together. The gap was only caught turns later, by the user — leaving the dependent work still blocked by an untracked item.

**Aggravating:** the complete list of three was in a file the AI had open and had edited in the same session. It had the source of truth in hand and still shipped a partial set.

## Root cause

- Treated a stated plan or a "help X" phrasing as authorization to produce output.
- Ignored that the work was delegated, or belonged to a later gated phase.
- Conflated "be helpful" with "act without instruction" — action-bias overriding the authorization check.
- Reading a rule ≠ applying it at the moment of the tool call.
- **(Incident C)** Executed against the *phrasing of the moment* ("the X changes") instead of the *written set* in the source doc. Did not enumerate the full list and confirm the count before declaring the task done. An item that differed by one attribute (repo/location/type) silently fell out of scope.

## Guardrails

- **Documentation/planning tasks stay documentation/planning.** Grooming/spec/investigation → any code goes into the doc as a reference snippet, never applied to the repo.
- **"Add the test/code for [assignee]" during grooming = put it in the ticket**, not edit the file.
- **Gated artifacts are gated.** `requirements.md` / `design.md` / `tasks.md` are produced through the spec-driven workflow with review gates — never one-shot from a prompt unless explicitly told this turn.
- **Intent ≠ instruction.** On "I plan to… / I'll start with… / next I want to…", STOP after any read-only step and wait for an explicit go.
- **When in doubt, ask:** "This needs editing `<file>` / creating `<artifact>` — do it now, or hold?"
- **Authorization is per-turn, per-artifact, and explicit.** A general goal is not permission.
- **(Incident C) Execute against the written set, not the phrasing.** When creating items from a documented list (dependencies, tickets, tasks), first enumerate the full set from the source doc and state the count ("the doc lists N; I am creating N"). Confirm every item is covered before declaring done — especially one that differs by repo, location, or type and could fall outside a loosely-worded instruction.

## The one-line test

Before any code edit or artifact generation, ask: *"Did the user, in this turn, explicitly tell me to create/change this now?"* If no → confirm scope, don't act.

## Related

- `.kiro/steering/development-rules.md` → "No Code Changes Without an Explicit Instruction (CRITICAL)"
- `.kiro/steering/git-safety.md` — the sibling principle for git writes
- `hooks/authorization-guard.json` — enforcement hook that re-checks authorization before any write
- `knowledge/keep-the-toolkit-portable.md` — the toolkit must stay company/project/person agnostic
- `knowledge/load-the-standard-before-producing.md`, `knowledge/avoiding-analysis-drift.md` — other process-discipline lessons
