# Daily Sync Workflow

Two manual commands that keep day-to-day tracking documents accurate without re-explaining the procedure each time: a **start-of-day (SOD)** resume and an **end-of-day (EOD)** wrap. Invocation is manual — paste the trigger, the agent runs the steps.

## When to Use

- **SOD:** at the start of a working day (or when resuming after time away), to recall where things stood and set today's priorities.
- **EOD:** at the end of a working day, to record what got done and refresh the tracking docs.

Not a replacement for a team standup — it is the per-developer discipline that *feeds* one. Think shift-change handover / SRE runbook: same checklist, run the same way each time.

## Tracking Documents (inputs)

This workflow reads and writes a project's day-to-day tracking docs. A project using it must declare where those live. Two roles:

- **Tracker** (append-only daily log + a live "Remaining" checklist) — the granular day-to-day view. This is the primary SOD read and EOD write.
- **Timeline** (authoritative baseline + dated status snapshots) — updated only when something material changes.

If a project has only one such doc, use it for both roles. If the paths are not declared in the active project's context or steering, **ask the user for them before running** — never guess a path.

## Core Principles (carry into every run)

1. **Read before claiming.** Base the report on what the docs and the repo actually say, not memory of prior sessions.
2. **Never state an unverified status as fact.** If something can't be confirmed from the docs or a quick check (a deploy result, a review gate, an external team's progress), list it as *unverified* and ask the user — do not assume done.
3. **SOD is read-only until confirmed.** Report first; change docs only after the user confirms the status inputs you asked for.
4. **Respect declared scope.** If the project has scoping rules (which areas/tests/modules are in or out of scope), honor them and flag out-of-scope findings as "note only."
5. **Preserve doc conventions.** Match the existing tracker/timeline structure: append-only log stays append-only; the baseline stays preserved; tick the checklist rather than rewriting it.

## Resolving "today" (run first, for both SOD and EOD)

Get a reliable current date before reading or writing anything. Resolve in this order:

1. **User-supplied date wins.** If the trigger includes a date (`— today is YYYY-MM-DD`), use it. No further check.
2. **Else use the session / PC date** (the date carried in the session context).
3. **Sanity-check it against the tracker's most recent daily-log entry:**
   - **Consistent** — session date is on/after the last entry and the gap is plausible → the date is trusted. Proceed. (A tracker with *no* entries is also fine — nothing to contradict; just confirm the date with the user in the SOD report.)
   - **Contradiction** — session date is *earlier* than the last entry, or the ordering is impossible, or the gap is implausibly large for a clock that should be correct → the **PC clock is suspect**.
4. **On a contradiction only, check the internet for the current date** and use that. Go straight to the net — do not guess the date from the last log entry. Tell the user: the PC/session date, what the net says, and which you're using. If the net is unreachable, stop and ask the user for today's date.

Do **not** hit the net on the fast path (user gave a date, or the date agrees with the tracker, or the tracker is empty). The net check is reserved for a genuine date contradiction.

## Staleness vs. clock error (two different gaps)

A big gap since the last entry does **not** by itself mean the clock is wrong. Separate the two:

- **Date contradiction** (handled above) → clock suspect → net check.
- **Tracking gap** — dates are consistent, but the last entry is more than ~1 working day old (weeks/months). This usually just means **no one logged for a while**; the clock is fine. Do **not** check the net. Instead:
  1. Call out the gap in the resume report: "last entry was `YYYY-MM-DD`, ~N days/weeks ago."
  2. Treat all prior state as **unverified** — tickets may have moved, merged, deployed, or closed during the gap.
  3. Ask the user for a short catch-up of what changed during the gap, rather than presenting the stale entry as current.
  4. Only after the user confirms, write the new entry — and note in it that there was a logging gap, so the history stays honest.

The clock check and the staleness check are independent: a gap can occur with a correct clock, and a wrong clock can occur with no gap.

## SOD — Start of Day (Resume)

**Trigger (paste):** `SOD: resume my day`
(optionally append `— today is YYYY-MM-DD` and any status updates you already know)

**Steps:**
1. **Resolve "today"** per the rules above (date resolution + staleness check). Surface any date contradiction or tracking gap before anything else.
2. Read the tracker's **Remaining** checklist, its **most recent daily-log entry**, and the latest **timeline snapshot**.
3. Produce a short **resume report** in standup shape:
   - **Date line:** today's date and its source (user / session / net), plus any gap note ("last entry ~N days ago — prior state treated as unverified").
   - **Since last entry:** what was open / in progress at the last log entry.
   - **Unverified:** items whose status can't be confirmed from the docs (deploys, review gates, other teams, human checks) — each phrased as a question for the user. On a tracking gap, everything since the last entry goes here.
   - **Today's priorities:** the top items from Remaining, ordered, with any deadline pressure called out.
4. **Stop and ask** the user to confirm the unverified items (and, on a gap, the catch-up) before touching any doc.
5. Do **not** modify docs in the SOD step. (The confirmed updates land in the next EOD, or immediately if the user asks.)

## EOD — End of Day (Wrap)

**Trigger (paste):** `EOD: wrap my day` + a brief list of what got done / changed today.

**Steps:**
0. **Resolve "today"** per the rules above — the dated log line must use the resolved date. If there was a tracking gap, record that in the new entry.
1. **Tracker — Remaining:** tick completed items; add new items that surfaced; reword any item whose status changed. Keep wording neutral and factual.
2. **Tracker — Daily log:** append a new dated entry (append-only — never edit past entries). Capture: what was done, decisions made, what's still open, and anything unverified.
3. **Priority banner / "as of" markers:** update the date and the ordered priority list if it changed.
4. **Timeline:** add a dated snapshot **only if** something material changed (a gate cleared, a deploy landed, scope/ownership shifted, a date moved). Leave the preserved baseline untouched.
5. **Other project docs:** if the day's work contradicts another tracking doc, sync it too. Keep the tracker and timeline consistent with each other.
6. **Report** a one-paragraph summary of what you changed and list anything still unverified.

## Output Shape (SOD report example)

```
SOD — <date> (source: user | session | net)
[gap note, if any: last entry was <date>, ~N days ago — prior state unverified]
Since last entry (<last log date>): <1–3 lines>
Unverified (need your confirmation):
  - <item>?
  - <item>?
Today's priorities:
  1. <item> (<deadline/why>)
  2. <item>
  3. <item>
```

## Notes

- **Manual only for now.** Could later be wired to a `SessionStart` hook, but manual invocation keeps the user in control of when docs change.
- **Verification discipline > completeness.** A resume report that honestly says "I can't confirm X" is more useful than one that guesses.
- **Scope and calendar rules live in the project, not here.** This workflow reads whatever scoping / working-calendar rules the active project declares and applies them; it does not hard-code any project's rules.
