# Spec-Driven Development Workflow

## Overview

A structured approach to feature development using Kiro's spec system. Each spec represents one focused feature, following the industry-standard SDD loop: Specify → Plan → Tasks → Implement, with human review gates between each phase.

This workflow follows industry standards for spec-driven development (SDD) as practiced by GitHub Spec Kit, AWS Kiro, Claude Code, and the broader agentic engineering community (2025–2026). Deviations from this standard require explicit human approval with reasoning documented.

## Core Principle: One Feature = One Spec = One PR

A spec must be small and focused. The industry standard is:

- **1 spec = 1 feature = 1 branch = 1 PR**
- **Keep specs to 1–3 pages.** If a spec gets bigger, split it.
- **Tasks should be atomic** — each completable in minutes to hours, not days.
- A "good task list looks like a checklist a junior engineer could execute."

### Scoping Rules

| Situation | What to do |
|---|---|
| Requirements doc has 5+ requirements | Split into multiple specs, grouped by dependency |
| A single requirement touches 10+ files | That's fine — it's still one feature |
| A feature depends on another feature | Implement the dependency first as a separate spec |
| Shared infrastructure (auth, audit, base models) | Extract as its own "foundation" spec |
| Unsure if it's too big | If design.md exceeds 3 pages or tasks.md exceeds 15 tasks, split |

### Splitting Strategy

When a product backlog has many requirements, group them into specs by:

1. **Dependency order** — what must exist before other things can be built
2. **Domain cohesion** — things that share the same models/services belong together
3. **Independent shippability** — each spec should produce working, testable code on its own

Example for a finance app with 14 requirements:
```
Spec 1: Foundation (monetary precision, soft deletes, audit trail, data isolation)
Spec 2: Auth & Profile (registration, login, user settings)
Spec 3: Core Entities (accounts, categories, category groups)
Spec 4: Transactions (the ledger)
Spec 5: Budgets & Dashboard (reporting layer)
Spec 6: Advanced Features (installments)
Spec 7: API Layer (GraphQL schema wrapping all the above)
```

## Flow

```
Specify → Design → Tasks → Implement
   ↓         ↓        ↓         ↓
(Review)  (Review)  (Review)  (Review per task)
```

## Phase 1: Specify (Requirements)

Define WHAT to build. No implementation details.

- Functional requirements (what the system should do)
- Non-functional requirements (performance, security, accessibility)
- Acceptance criteria using EARS-style notation (testable, unambiguous)
- Edge cases and boundary conditions
- Out-of-scope notes (what this spec explicitly does NOT cover)

**Keep in requirements (not design):** behavior, acceptance criteria, out-of-scope. **Defer to design.md:** architecture, naming/namespace conventions, and **correctness properties** (the formal invariants that back property-based tests) — requirements.md may point to them, but the property definitions live in design.md. Optional value-add sections for gate-reviewed specs: a "Confirmed Decisions" table (settled inputs the approver need not re-open) and an "Open Items" table (unresolved questions with an explicit ask for the approver).

### EARS Notation for Acceptance Criteria

Write acceptance criteria as testable statements using these patterns:

| Pattern | Format | Example |
|---|---|---|
| Event-driven | WHEN [trigger] THE [system] SHALL [response] | WHEN a user submits login THE Auth SHALL return a token |
| Unwanted behavior | IF [condition] THEN THE [system] SHALL [response] | IF password is wrong THEN THE Auth SHALL return generic error |
| State-driven | WHILE [state] THE [system] SHALL [behavior] | WHILE token is expired THE API SHALL reject requests |
| Ubiquitous | THE [system] SHALL [always-true behavior] | THE System SHALL store amounts as integers in centavos |
| Optional | WHERE [feature] THE [system] SHALL [behavior] | WHERE MFA is enabled THE Auth SHALL require TOTP |

**Gate:** Human reviews requirements before design begins.

### Review-Gate Staging (when a spec needs external sign-off)

The Git mapping below places specs in `{project}/.kiro/specs/`. But when a spec must clear an **external approval gate** before design starts — e.g. a PM, accounting, or client sign-off on requirements — do not commit the in-review artifact into the code repo prematurely. Instead:

1. **Draft in the dev-context workspace:** `projects/{name}/specs/{feature}/requirements.md`. Keep it out of the code repo while it's under review.
2. **Route it to the approver.** The reviewer reviews a document, not a repo commit — clean audit trail, nothing lands in the code repo unapproved.
3. **On approval, promote** to `{project}/.kiro/specs/{feature}/requirements.md`. This is also what unlocks the Kiro spec UI's **"Continue to Design"** button (Phase 2 must be generated there, not in chat).

This mirrors the steering **draft → promote** lifecycle (`.kiro-draft/steering/` → `{project}/.kiro/steering/`). Use it whenever an artifact needs approval or must merge in a specific order before it belongs in the code repo. If a spec has no external gate, follow the default Git mapping and author it directly in `.kiro/specs/`.

### Match the Repo's Existing Spec Convention

Before creating a spec folder or writing requirements, **check how the target repo already does specs** — do not impose a generic format.

- **Folder naming:** follow the repo's existing pattern under `.kiro/specs/`. If existing specs use a `{project-code}-{feature}` naming, match it — don't invent a different scheme. If the spec UI generates a config file (with a spec id), create the spec through the UI so it stays valid for the "Continue to Design" step rather than hand-fabricating folders.
- **Requirements granularity varies by spec type.** A schema/migration spec in a DB repo may legitimately use a **more prescriptive** style than the generic "behavior only" rule — one requirement per table, each column as its own acceptance criterion (type, nullability, default, comment), plus engine/charset and index criteria. For a schema migration the column definitions *are* the requirement; there's no meaningful behavior layer above "this column exists with this type." Match the repo's precedent (an existing migration spec) rather than forcing behavior-only prose.
- **Multi-repo features get one spec per repo.** When a feature spans repos (e.g. schema in a migrations repo + logic in an application repo), each repo owns its own spec in its own `.kiro/specs/`, cross-referencing the other, with the merge-order dependency stated. Don't put one repo's spec inside another.

When in doubt, read an existing spec in the repo first and mirror its structure, headings, and acceptance-criteria style.

## Phase 2: Design (Plan)

Define HOW to build it. Architecture and approach.

### Starting a Design Session

Specs often span multiple sessions. When starting a new session to generate design.md:

1. Open a new Kiro session
2. Load project context (see workspace setup docs for the full prompt)
3. Load supplementary design context (architecture docs, knowledge-base articles relevant to this spec)
4. Open `requirements.md` in the editor → click **"Continue to Design"** in the spec panel

**Important:** Do not ask Kiro in chat to "generate design.md" — use the spec UI button. Chat-based generation produces freeform responses, not the structured spec format that feeds into tasks.md.

### Design Content

- Architecture choices and rationale
- Data model / schema changes
- API contracts (inputs, outputs, error responses)
- Component/file changes needed
- Library and framework selections (with constraints from project steering)
- Migration strategy if touching existing code
- Dependencies and ordering between components

The design should be specific enough that someone else (or an agent) could implement from it without guessing.

**Gate:** Human reviews design before task breakdown.

## Phase 3: Tasks

Break design into executable units.

- Each task = one atomic change (one commit)
- Each task has: a single objective, inputs (files to read), outputs (files to create/modify), and a done criterion
- Tasks are ordered by dependency
- Each task references which requirement it satisfies
- Target: 5–15 tasks per spec. More than 15 = spec is too big, split it.

**Gate:** Human reviews task list before execution.

## Phase 4: Implement (Execute)

Agent executes tasks one by one.

- Complete one task → verify against acceptance criteria → show result → wait for review
- Human approves → move to next task
- Human rejects → revise and re-present
- All tasks done → create PR referencing the spec

### Verification

After each task, verify:
- Does the code satisfy the relevant acceptance criteria?
- Do existing tests still pass?
- Does it follow project steering (coding standards, naming, patterns)?

## Change Requests to an Already-Completed Spec

A spec that has been **implemented and merged** is a record of what was built. When a change arrives *after* that point — new requirement, reversal, scope cut — the completed spec is history, and history is not rewritten.

This follows the same pattern across the industry's SDD tooling and architecture practice:

- **GitHub Spec Kit** handles post-completion changes with a **Change Request**: a *separate* artifact that references the original spec by ID, states what is changing and why, and runs its own draft → review → approved cycle — it does not mutate the delivered spec. ([spec-kit discussion #900](https://github.com/github/spec-kit/discussions/900))
- **Kiro's own guidance**: you cannot change a spec's workflow mid-stream — if you need a different approach, **create a new spec** and copy relevant content from the previous one. ([kiro.dev best-practices](https://kiro.dev/docs/specs/best-practices/))
- **ADR practice**: a delivered decision record is **immutable** — a changed decision gets a *new* ADR that references the original, never an in-place edit. ([Practicalli ADR playbook](https://practical.li/engineering-playbook/software-design/architecture/adr/))
- **Microsoft's spec-amendment framing**: an amendment is a **first-class event, recorded explicitly — not a deviation to hide** by silently rewriting the spec. ([devsquad-copilot](https://microsoft.github.io/devsquad-copilot/concepts/spec-amendment/))

### The rule

> **Supersede, don't edit.** A change to a completed spec is a new, separately-tracked artifact (a Change Request) that references the original. The original spec and its tasks stay as the record of what was built; mark the original **superseded-by** the CR.

### Decide the CR's weight by proportionality

The CR is a *new artifact*, but how heavy it is scales with the change — do **not** reflexively run a full requirements→design→tasks cycle for a small change.

| Change size | CR form | Why |
|---|---|---|
| Small, self-contained (remove a few files, flip a config, a localized fix to merged code) | **Lightweight CR**: one CR doc (ticket + a dev-context source-of-record file) that references the original spec, states scope + affected files + done-criteria, grounded in a read of the *actual merged code*. Tracked as a subtask under the original spec's Coding story. | A deletion has no meaningful `design.md`. A full cycle is process theatre; it mirrors a decommission handled as tracked CR work. |
| Large / architectural (the change reshapes the design, adds new concepts, spans new files) | **New Feature Spec** (its own requirements→design→tasks), copying relevant content from the original, referencing it. | The change is itself a feature; it earns the full loop. |

### Procedure

1. **Record the decision.** Write an ADR (or decision note) for *why* the change is happening; link the source (PM message, incident, etc.).
2. **Create the CR artifact** referencing the original spec by ID. Lightweight or full per the table above.
3. **Ground it in the real code.** Before listing affected files/lines, read the actual merged code on the branch the change will be made on — not memory, not a stale footprint. The CR's scope must be verifiable against the live repo.
4. **Stamp the original spec `superseded-by <CR-id>`** — add a one-line note to the original spec folder. Do **not** edit its requirements/design/tasks; they remain the record of what was built.
5. **Preserve the original work's tracking.** The completed spec's stories/time logs stay as "Done." The CR is *new* work with its *own* tracking — the original effort is never re-opened or marked "won't do."
6. **For execution by another engineer's agent:** the CR (or a prompt derived from it) must point their agent at the exact source references and instruct it to **verify scope against the live code before changing it** — so their agent's context matches the author's.

### Anti-pattern: editing the completed spec and re-running it

Editing a delivered spec's requirements to mean the *opposite* of what was built (e.g. "build the CSV" → "remove the CSV") and re-running the flow **destroys the record of what shipped**, breaks time-log/KPI attribution of the original work, and is explicitly contrary to ADR immutability and spec-kit's separate-CR model. Supersede with a new CR instead.

## When to Use Spec-Driven

| Scenario | Use Spec? |
|---|---|
| New feature (multiple files, new concepts) | ✅ Yes |
| Bug fix (root cause known, scope clear) | ❌ No — use bug-fix workflow |
| Refactoring (behavior unchanged) | Maybe — use if scope is large |
| Single-file change | ❌ No — just do it |
| Investigation (root cause unknown) | ❌ No — use investigation workflow |
| **Change to an already-completed/merged spec** | **CR, not an edit** — see "Change Requests to an Already-Completed Spec" (supersede; weight by proportionality) |

## Mapping to JIRA / Project Management

| PM Level | SDD Equivalent |
|---|---|
| Epic | Feature area (multiple specs) |
| Story | 1 Spec (specify → design → tasks → implement) |
| Subtask | 1 Task within the spec |

## Mapping to Git

| SDD Artifact | Git Equivalent |
|---|---|
| 1 Spec | 1 branch + 1 PR |
| 1 Task | 1 commit |
| Spec directory | `.kiro/specs/{feature-name}/` |

## Anti-Patterns

| Anti-Pattern | Why it fails | Do this instead |
|---|---|---|
| One giant spec for entire app | Context overflow, impossible to review | Split by feature/dependency |
| Skipping design phase | Agent guesses architecture, produces inconsistent code | Always write design.md |
| Tasks without done criteria | No way to verify task completion | Every task gets an acceptance check |
| Spec → code with no human review | "Vibe coding wearing a Halloween costume" | Review at every phase boundary |
| Specifying implementation details in requirements | Over-constrains the design phase | Requirements = behavior only |
| Letting spec rot after implementation | Loses the canonical reference | Spec lives in the repo as the record of what was built. A later change is a **Change Request that supersedes** it (see "Change Requests to an Already-Completed Spec") — not an in-place edit of the delivered spec. |
| **Editing a completed/merged spec to mean the opposite of what shipped** | Destroys the record of what was built; breaks time-log/KPI attribution; violates ADR immutability | Create a separate CR that references the original and stamp the original `superseded-by` |
| **Analysis drift / not anchoring to the critical path** | Weeks pass producing docs, meeting questions, and re-explanations while the current phase's one artifact (e.g. requirements.md) never gets written. Feels productive; ships nothing. | At the start of every working turn, state the current SDD phase and its single next artifact. If a request doesn't advance that artifact, say so and offer to defer it. |
| **Resurfacing already-decided items as open questions** | Re-litigating settled decisions (checking status from a stale note instead of the authoritative open-items table) wastes the team's time and erodes trust. | Before listing anything as "open" / "a question," verify its status against the authoritative source (open-items table, decision log). Never derive open questions from a secondary doc's framing. |
| **Inventing external dependencies** | Framing our own work (e.g. verifying our own DB's data shape) as "a question for the upstream team" manufactures a blocker and stalls progress. | Distinguish *data source* from *code dependency*. If we can answer it by querying our own system, it is our task — not a blocker on another team. |
| **Verbose answers to simple questions** | Multi-section essays bury the answer, tire the reader, and slow decisions. | Answer the question asked, at the length it deserves. Yes/no first. Detail only if asked. |

## Deviation Protocol

This workflow follows industry-standard SDD practices. If a situation requires deviating (e.g., combining multiple features in one spec, skipping a phase), the agent MUST:

1. **State the deviation** — what standard practice would be, and what's being done instead
2. **Explain why** — what specific circumstance justifies it
3. **Get human approval** — do not proceed without explicit confirmation

Examples of acceptable deviations:
- Combining two tightly-coupled features that share 80%+ of their design
- Skipping tasks phase for a spec with only 2–3 obvious implementation steps
- Implementing a spike/prototype without full spec (exploratory work)

## References

- [SDD Definitive 2026 Guide](https://thebcms.com/blog/spec-driven-development) — industry overview, EARS notation, tool landscape
- [GitHub Spec Kit](https://github.com/github/spec-kit) — reference SDD implementation (model-agnostic)
- [Augment Code SDD Guides](https://www.augmentcode.com/guides/what-is-spec-driven-development) — scope, task breakdown, automation
