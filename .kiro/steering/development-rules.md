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

**Incident (2026-09-08):** During ZPR ticket grooming (delegated to another dev, no code instruction, no spec started), the AI edited `ZipanMonthlyPlanEnum.php` and its test directly in the code repo. The user had to cancel and revert. Root cause: treated "add the test to help" as authorization to write code, and ignored that grooming is a documentation task. The code belonged in the grooming ticket as a snippet.

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

5. **Naming:** Source documents use the `REF-` prefix (e.g., `REF-ASCH-05-Requirements-Update-20260724.md`). The prefix signals "this is a reference — source of truth, not my analysis."

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
