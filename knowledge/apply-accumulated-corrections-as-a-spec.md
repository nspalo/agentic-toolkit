# Apply Accumulated Corrections as a Spec

> Portable lesson. Generic failure; specifics anonymized.

## The failure mode

While revising a document under a user's direction, the agent treats **each new correction in isolation** — fixing the exact words just complained about while reintroducing or dropping adjacent content the user had already settled in an earlier message. The user ends up repeating the same points across many rounds, and in the worst case an item the user explicitly asked to **add** gets **dropped**. Revisions churn; the document never converges.

## What it looked like (real incident, anonymized)

Asked to produce a short status update, the agent took a series of specific, explicit corrections over several rounds and mishandled them: it only removed a redundant line after being told it was redundant; it filed a "current state" item under "next steps"; it reported a caveated status as cleanly fine; and — the worst miss — after being told to **add** an item, it **removed** it by folding it into another bullet. The user had to re-explain instructions already given, rather than the agent re-reading the thread.

## Root cause

- **Reacted to the latest message in isolation** instead of treating the user's accumulated corrections as a running spec to honor in full on every revision.
- **Edited mechanically, not by intent** — patched the exact phrasing flagged while disturbing settled neighboring content.
- **Dropped an explicitly requested item** — the user said "add", the agent removed.
- **Re-asked instead of re-reading** — asked the user to restate direction already given earlier in the thread.

## Guardrails

- **Treat accumulated corrections as a cumulative spec.** Before each revision, re-read every prior instruction in the thread and apply all of them — not just the latest complaint.
- **Edit by intent, holistically.** When one line is corrected, check the whole document still honors every earlier decision; never silently drop or re-add settled content.
- **Never drop an explicitly requested item.** If an instruction says "add X", X must appear in the output. "Add" never means "fold away."
- **Re-read before re-asking.** Do not ask the user to restate an instruction already given; re-read the conversation first.
- **Under escalation, cut churn, not content.** A tenser user means tighten and converge — re-read the full set of corrections and deliver a version that satisfies all of them at once.

## The one-line test

Before sending a revision, ask: *"Does this version satisfy every correction the user has given so far — not just the last one?"* If you can't confirm each, re-read the thread before sending.

## Related

- `knowledge/follow-the-procedure-you-were-told-to-check.md` — sibling "restating instead of delivering" / read ≠ applied failures
- `knowledge/avoiding-analysis-drift.md` — converge on the deliverable instead of churning
- `knowledge/load-the-standard-before-producing.md`
