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

## When to Use Spec-Driven

| Scenario | Use Spec? |
|---|---|
| New feature (multiple files, new concepts) | ✅ Yes |
| Bug fix (root cause known, scope clear) | ❌ No — use bug-fix workflow |
| Refactoring (behavior unchanged) | Maybe — use if scope is large |
| Single-file change | ❌ No — just do it |
| Investigation (root cause unknown) | ❌ No — use investigation workflow |

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
| Letting spec rot after implementation | Loses the canonical reference | Spec lives in repo, updated with changes |

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
