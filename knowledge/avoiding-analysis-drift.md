# Avoiding Analysis Drift in Spec-Driven Work

> Portable lesson. The failure it describes is generic; the ASCA project is only the example.

## The failure mode

An agent working a spec-driven project can spend days or weeks producing documents, meeting-question lists, status re-explanations, and re-analysis — all of which *feel* like progress — while the one artifact that actually advances the project (the current phase's deliverable, e.g. `requirements.md`) never gets written. The result is real schedule slip disguised as busyness.

## What it looked like (real incident)

On a project sitting at SDD Phase 1 (Specify), across one session the agent:

- Re-explained decisions that were already settled (checking a stale investigation note instead of the authoritative open-items table), resurfacing them as "open questions."
- Framed the team's own database-verification work as "questions for the upstream team," inventing a dependency that did not exist (no code coupling — the upstream team was only a *data source*).
- Answered simple yes/no questions with multi-section essays, burying the answer.
- Never once stated where the project was on the SDD critical path, so every tangent looked equally worth doing.

The human had to intervene: "what's holding the project back? we're going in circles."

## Root causes

1. **No critical-path anchor.** SDD always has a single next action (Specify → G1 → Design → G2 → Tasks → Implement). If the agent never locates the project on that line, it has no way to tell a productive action from a distraction.
2. **Secondary sources over authoritative ones.** Deriving "open questions" from a note's framing instead of the decision log/open-items table.
3. **Manufactured dependencies.** Confusing "we need data from system X" with "we depend on team X's code."
4. **Verbosity as default value.** Treating more explanation as more help.

## Guardrails

- **Anchor every turn.** Begin working turns by naming the current SDD phase and its single next artifact. If a request doesn't advance it, say so and offer to defer.
- **Verify status before calling something open.** Check the authoritative source (open-items/decision table), not a secondary doc, before listing a question or blocker.
- **Data source ≠ code dependency.** If we can answer it by querying our own system, it's our task, not a blocker.
- **Answer at the length the question deserves.** Yes/no first; detail only on request.
- **Name drift out loud.** If several turns pass without advancing the current artifact, stop and say: "We haven't moved the critical-path artifact in N turns — here's the one next action."

## The one-line test

Before producing anything, ask: *"Does this advance the current phase's deliverable?"* If no, it's probably drift — defer it or flag it, don't do it silently.

## References

- `workflows/spec-driven-development.md` → Anti-Patterns table (the drift/decided/dependency/verbosity rows)
