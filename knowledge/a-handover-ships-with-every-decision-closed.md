# A Handover Ships With Every Decision Closed

> Portable lesson. Generic failure; specifics anonymized.

## The rule

When you produce a handover — a ticket + a paste-ready prompt that sends decided work to another developer (or their agent) — **every decision the implementer would otherwise have to make must already be made**, with its rationale, before the handover ships. A complete handover is a checklist a junior could execute without re-deciding architecture. The implementer implements the decided approach and does **not** ask for confirmation of anything already decided.

The implementer should still stop and ask when they hit something **genuinely new** — the live code contradicts the handover, or a stated assumption turns out false. That is a *new* decision and is correct behavior. What a handover must not contain is a *pre-existing* open decision the author failed to close.

## The failure mode

The author ships a handover that says, in effect, *"approach A or approach B — both are acceptable, you pick / ask the lead."* The implementer (correctly refusing to guess on an ambiguous spec) stops and asks for a decision. The work blocks on a round-trip that a complete handover would have avoided. The handover looked ready — grounded, trap called out, paste-ready — but carried an unresolved architectural choice inside it.

## What it looked like (real incident, anonymized)

A handover for a test-infrastructure guardrail offered two implementation approaches and told the implementer to "choose which you prefer / ask the lead." The author actually had the information to decide — one approach was clearly correct because an existing test legitimately needed the setup the other approach would have broken — but shipped the choice to the implementer anyway. The implementer's agent dutifully stopped and asked. A sibling handover for the same effort had been done correctly ("the approach is decided — implement exactly this"), making the gap obvious by contrast.

## Root cause

- **Confused "the spec *accepts* either" (acceptable-outcome flexibility) with "the implementer should *pick*" (a decision hand-off).** Flexibility in what's acceptable is not license to defer the decision to execution time.
- **Left an either/or in the spec instead of resolving it before handover**, despite having the information to close it.
- A handover that says "choose A or B / ask" is a **design gap wearing a handover costume**, not a finished handover.

## Guardrails

- **Resolve every either/or before the handover ships.** If you know (or can determine) the right option, decide it, state it, and give the one-line rationale. Never ship "choose A or B" to the implementer.
- **A handover may state what is *acceptable* but must still name the *chosen* path.** "Either is valid; we are doing A because X" is correct. "Either is valid; you decide" is not.
- **If a decision genuinely cannot be made pre-handover** (it needs an input only the lead/owner has), that is a **blocker to raise before handover**, not a question to embed in the implementer's prompt.
- **Scan before marking ready.** Search the handover for "ask", "decide which", "your call", "A or B" aimed at the implementer. If present, the handover is not done.
- **Preserve the legitimate ask.** Keep instructing the implementer to stop and ask when the live code contradicts the handover or a new decision surfaces — eliminate only the *pre-existing* open decisions.

## The one-line test

Before marking a handover ready, ask: *"Is there any choice left in here that the implementer has to make or confirm?"* If yes, close it first.

## Related

- `workflows/spec-driven-development.md` — tasks as "a checklist a junior engineer could execute"
- `knowledge/no-unauthorized-code-changes.md` — the sibling "intent vs instruction / execute against the written set" discipline
- `knowledge/load-the-standard-before-producing.md`
