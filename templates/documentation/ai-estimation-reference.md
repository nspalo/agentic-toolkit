# AI-Assisted Development — Estimation Reference Guide

## Document Info

| | |
|---|---|
| **Document type** | Research Summary |
| **Date** | {{YYYY-MM-DD}} (Created) |
| **Author** | {{Name, Role}} |
| **Assisted by** | {{Kiro / AI tool name, or omit if N/A}} |
| **Status** | {{Active}} |
| **Audience** | {{Lead developers, PMs, SDMs — anyone estimating AI-assisted projects}} |

---

## Industry Benchmarks (2024–2026)

| Source | Metric | Finding |
|---|---|---|
| GitHub (Copilot study, 2023) | Task completion speed | ~55% faster on isolated coding tasks |
| McKinsey (2024) | Full delivery lifecycle | 20–45% productivity gain (median ~35%) |
| Google Internal (2024) | Developer surveys | AI helps most on boilerplate; complex logic sees 10–20% gain |
| Pragmatic Engineer (2025) | Industry survey | Teams report 30–40% faster for well-scoped features; near 0% for ambiguous requirements |

**Key insight:** The 55% figure is for isolated tasks (write a function, fix a bug). Full projects with design, review, integration, and testing see 20–40% total gain.

---

## What AI Accelerates

| Activity | Acceleration | Why |
|---|---|---|
| Boilerplate code (migrations, models, DTOs, factories) | High (70–80% faster) | Templated, predictable, low-context |
| Requirements → design → task breakdown | High (60–70% faster) | Pattern recognition, documentation synthesis |
| Test scaffolding | High (60–70% faster) | Structural, repetitive |
| Bug fixes (with clear reproduction) | Medium (40–50% faster) | Context-bounded problem |
| Documentation | High (70–80% faster) | Text generation is AI's strength |

---

## What AI Cannot Compress

| Activity | Why | Impact on estimate |
|---|---|---|
| Complex business logic with edge cases | Must understand domain, validate against business rules, handle 9+ variant scenarios | Dominates timeline for domain-heavy projects |
| Human review gates (PM sign-off, PR review) | Organizational process, trust-building, accountability. Cannot be automated away. | Adds 1–2 days per gate × number of gates |
| Integration with existing monolithic code | Must read, understand, and not break 1000+ line files. AI can help read but not guarantee safety. | Scales with codebase complexity |
| External API integration | Rate limits, sandbox testing, payload debugging, error handling for real-world conditions | Fixed time regardless of AI |
| Correctness verification (financial/accounting) | Must be provably correct to the yen. "Close enough" is not acceptable. Requires exhaustive testing. | Cannot be shortened for regulated systems |
| External dependency wait time | Other teams' deliverables, environment access, business decisions | Blocked time = blocked time |
| Cross-repo coordination | Multiple PRs, deployment sequencing, config alignment | Human coordination overhead |

---

## Realistic Multipliers

| Project Type | Traditional (no AI) | With AI + SDD | Multiplier |
|---|---|---|---|
| Greenfield CRUD app | 8 weeks | 4–5 weeks | 0.5–0.6x |
| Feature with 2–3 edge cases | 6 weeks | 4 weeks | 0.65x |
| Complex domain logic (many patterns) | 16–20 weeks | 9–10 weeks | 0.5–0.6x |
| Legacy integration-heavy | 14–18 weeks | 9–11 weeks | 0.6–0.7x |
| Financial/accounting system (complex + integration + regulated) | 18–24 weeks | 9.5–12 weeks | 0.5–0.55x |

**Rule of thumb:** Expect 40–55% reduction from traditional estimates for complex projects. Never promise >60% for full projects with review cycles and external dependencies.

---

## Why 2 Developers ≠ Half the Time in SDD

In spec-driven development with a single Lead:

| Bottleneck | Why it doesn't parallelize |
|---|---|
| Lead generates requirements/design | One person, sequential output |
| Lead reviews PRs | Review queue — two PRs waiting doesn't go faster than one |
| Sequential spec dependencies | Spec 2 needs Spec 1's schema to exist |
| PM sign-off | One PM, one queue |

**Realistic gain from adding 1 developer:** 15–25% total time reduction (not 50%).

**When a 2nd developer helps most:**
- Independent specs that can run in parallel (rare in early phases)
- Insurance against blockers/sickness (risk mitigation)
- Integration testing while dev continues on next spec

---

## How Big Tech Compares

| Aspect | Big Tech (Google, Amazon, Meta) | Our Approach (SDD) |
|---|---|---|
| Design review cycle | 2–4 weeks (multiple reviewers, revision rounds) | 1–2 days (one PM, one Lead) |
| Code review | 1–3 days (often multi-reviewer) | 1 day (single Lead reviewer) |
| Project timeline for similar scope | 2–3 quarters (18–30 weeks) | 9.5 weeks |
| Buffer standard | 20–30% of estimate | ~10% (1 week of 9.5) |
| Deployment process | Staged rollout over weeks | Single target (DEV04 → staging → prod) |

**Our approach is more aggressive than big tech** — shorter review cycles, tighter buffer, compressed timeline. This is acceptable because:
- Smaller team = faster communication
- Single PM with decision authority = no committee delays
- Spec-driven workflow = less ambiguity reaching the developer

---

## When to Use This Reference

- During project estimation kickoffs (set team expectations)
- When stakeholders ask "why can't AI do this in 2 weeks?"
- When comparing options (the multiplier varies by project type — integration-heavy is slower)
- When defending buffer allocation (10% minimum; 20% for regulated/financial systems)

---

## Anti-Patterns (What NOT to Promise)

| Don't say | Why it's wrong |
|---|---|
| "AI will build this in half the time" | Can be true for complex projects (55–60% reduction). But never promise >60% for full lifecycle with reviews + integration. |
| "We don't need review cycles with AI" | AI generates code that needs human validation. Review gates are quality, not overhead. |
| "2 developers = half the timeline" | Lead bottleneck prevents linear scaling. Realistic: 15–25% gain. |
| "No buffer needed — AI catches bugs faster" | AI introduces its own bugs. Financial systems need extra verification, not less. |
| "We can skip testing since AI wrote it" | AI-generated code has a different (not lower) bug profile. Tests are MORE important. |
