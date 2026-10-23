---
inclusion: auto
---

# Development Rules

## No Code Changes Without an Explicit Instruction (CRITICAL)

**Never modify the code repo unless the user has explicitly asked you to implement/code in this turn.** Grooming a ticket, writing a spec, investigating, or "helping the assignee" is NOT authorization to touch code.

- Ticket grooming / spec / design / investigation = **documents only**. Code goes into the ticket/doc as a **reference snippet**, never applied to the repo.
- "Add the unit test for X-san" during grooming means **put the test code in the ticket**, not edit the test file — the change is that person's assigned work.
- If you believe code should change, **stop and ask**: "This requires editing `<file>` in the code repo. Do you want me to apply it, or put it in the ticket as reference?"
- Applying code the user didn't ask for makes them revert and redo — it creates work, not saves it.

**Intent is not instruction (CRITICAL).** A stated plan is NOT authorization. Phrases like "I plan to…", "I'll start with…", "next I want to…", "we need to generate X" describe intent — they are context, not a go signal. On any such phrasing: finish any read-only step, confirm scope, and **wait for an explicit "generate / write / implement / proceed"** before producing or editing anything. Authorization is per-turn, per-artifact, and explicit.

**Gated artifacts.** `requirements.md`, `design.md`, and `tasks.md` are produced through the spec-driven workflow with review gates — never one-shot from a prompt unless explicitly told to this turn.

### Incident log (anonymized — see `knowledge/no-unauthorized-code-changes.md`)

| Date | What happened | Root cause |
|---|---|---|
| Incident A | During ticket grooming delegated to another dev (no code instruction, no spec started), the AI edited an enum source and its test directly in the code repo. User cancelled and reverted. | Treated "add the test to help [assignee]" as authorization to write code; ignored that grooming is a documentation task. The code belonged in the ticket as a snippet. |
| Incident B | Asked only to check a timeline, the user added "I plan to generate the design doc, starting with [repo]." The AI immediately wrote a full `design.md`. User had to delete it. | Read "I plan to…" as "do it now." Action-bias overrode the authorization check. **Repeat of A in the same session after summarizing A ~1 hour earlier** — reading the rule ≠ applying it at the tool call. |
| Incident C (meta) | While writing toolkit knowledge about the above, the AI embedded real company/project/person/file specifics into portable toolkit files. | No sanitize pass before writing to the toolkit. See `knowledge/keep-the-toolkit-portable.md`. |
| Incident D | The user asked the AI to **compose a chat message** ("draft/compose a message"). Instead of writing it inline in the reply, the AI invoked a document/artifact creation tool, producing a UUID-named file in the tool's internal storage and opening it in the user's editor. When challenged, the AI also failed at first to name the file it had created. | Tool-bias: reached for a creation tool when the request was "produce text in the conversation," not "make an artifact." Same meta-pattern as A/B — the rule was known but not applied at the tool call. Lesson: **when the ask is to compose/draft text for the user to read or copy, write it inline in the reply; do not call any file/artifact/document tool unless the user explicitly asks for a saved file.** Whenever a tool does create a file, state its exact path in the same turn. |
| Incident E | The user said "I will only commit [specific files]" — a first-person statement that **they** would perform the action. The AI read it as a go signal and ran `git` commands, including unstaging a file the user had staged, altering the user's staging index without being asked. | "I will do X" describes the **user's own** intended action, not a delegation. Action-bias again overrode the authorization check — the same "intent is not instruction" failure as A/B/D, this time on a VCS operation. Lesson: **a first-person "I will…" from the user means the user is doing it; it is never authorization for the AI to act. Treat VCS/staging state as the user's working context — never run git write/stage commands (`add`, `restore`, `reset`, `commit`, `stash`) unless explicitly told to this turn.** |

Enforcement: `hooks/authorization-guard.json` re-checks authorization before any write tool runs.

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

## Source Document Preservation (CRITICAL)

**When the user provides a document from an external source (Confluence, PM spec, meeting notes, Slack, or any stakeholder):**

1. **SAVE THE FULL CONTENT.** Never summarize, never omit sections, never paraphrase when saving a reference document. The saved file must be a faithful representation of what the source says — every section, every table, every dependency, every acceptance scenario.

2. **Summaries go IN ADDITION TO the full doc, not instead of it.** A comparison table or "quick summary" section at the top is fine, but the complete original content must follow below it.

3. **Never generate estimates, designs, or specs from a summary you wrote.** Always reference the full source document. If the full doc isn't saved, save it FIRST, then generate work from it.

4. **Why this matters:**
   - Estimates based on incomplete specs undercount scope
   - Sub-leads onboarding from summaries miss critical edge cases and constraints
   - Lost details (acceptance scenarios, open dependencies, specific treatment requests) cause rework later
   - The source document is the PM's intent — summaries are your interpretation, which may be wrong

5. **Naming:** Source documents use the `REF-` prefix (e.g., `REF-[PROJ]-05-Requirements-Update-YYYYMMDD.md`). The prefix signals "this is a reference — source of truth, not my analysis."

## Spec-Driven Development

1. **One feature = one spec = one PR** — never combine multiple unrelated features in a single spec.
2. **Keep specs focused** — if design.md exceeds 3 pages or tasks.md exceeds 15 tasks, the spec is too big. Split it.
3. **Split by dependency** — shared infrastructure first, then features that depend on it, each as separate specs.
4. **Follow industry-standard SDD** — Specify → Design → Tasks → Implement with human review at every gate. Reference `workflows/spec-driven-development.md` for the full process.
5. **Deviate only with approval** — if a situation requires deviating from standard SDD practice (combining features, skipping phases), state the deviation, explain why, and get human confirmation before proceeding.
6. **Acceptance criteria must be testable** — use EARS-style notation (WHEN/IF/WHILE/THE). No vague requirements like "should work well."

## Confidence Markers

When making claims in reports or analysis, always state what is confirmed vs inferred:

- "Root cause (code trace, not yet verified with data)"
- "Confirmed via query (see Appendix)"
- "Inferred from code — needs data verification"

## Toolkit Portability (CRITICAL)

This repo is company-, project-, and person-agnostic. Nothing written into `agentic-toolkit/` may contain company names, product names, project codes, JIRA keys, real people's names, or real file/table/enum paths.

- **Specifics → dev-context** (`projects/{code}/`, `research/`, `domain-knowledge/`). **Lessons → toolkit**, anonymized.
- **Sanitize before writing to the toolkit.** Replace every proper noun and real path with a placeholder (`[assignee]`, `[repo]`, `[project]`, "an enum value", "a source file").
- **The test:** "If I handed this repo to a different company tomorrow, would anything leak the previous client or read as project-specific?" If yes → anonymize first.

See `knowledge/keep-the-toolkit-portable.md`.
