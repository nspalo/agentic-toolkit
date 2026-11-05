# Daily Sync Workflow

Two manual commands that keep day-to-day tracking documents accurate without re-explaining the procedure each time: a **start-of-day (SOD)** resume and an **end-of-day (EOD)** wrap. Invocation is manual — paste the trigger, the agent runs the steps.

## When to Use

- **SOD:** at the start of a working day (or when resuming after time away), to recall where things stood and set today's priorities.
- **EOD:** at the end of a working day, to record what got done and refresh the tracking docs.
- **ST:** anytime, for a quick read-only "where are we" pulse (no priorities, no edits).
- **LOG:** anytime, to record one specific update to the tracker without a full wrap.
- **SYNC:** anytime, to reconcile the timeline + other docs against the tracker (figures out the drift itself).

Not a replacement for a team standup — it is the per-developer discipline that *feeds* one. Think shift-change handover / SRE runbook: same checklist, run the same way each time.

For the **outward**, stakeholder-facing view (highlight / lowlight for a PM/SDM), see the companion `workflows/project-update.md` (`PU: project update`). It reads the same tracker + timeline but formats for an audience and never edits the docs.

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

## ST — Status (anytime, read-only)

A lightweight "where are we" check. Unlike SOD, it has no priorities framing and no resume narrative — just the current tracker state. Read-only; never edits a doc.

**Trigger (paste):** `ST: status` (optionally scope it: `— ASCA` or `— ASCI + ASCH`).

**Steps:**
1. Read the tracker's **Remaining** checklist (and the most recent daily-log entry for context).
2. Report, grouped by project: open items (`- [ ]`), in-progress (`- [~]`), and anything **unverified** (done-but-unconfirmed, external-team, human checks).
3. Keep it short. No date-resolution ceremony, no priority ordering, no doc edits.

Use `ST` for a quick mid-day pulse; use `SOD` when you actually want the resume + priorities at the start of a session.

## LOG — Record one update (anytime, scoped write)

Writes a single update to the **tracker** without the full EOD sweep. For "I just finished X" or "status of Y changed" mid-day, when you don't want to run a whole wrap.

**Trigger (paste):** `LOG: <the update>` (e.g. `LOG: ASCI-11 G3 done — reviewed and recorded`).

**Steps:**
1. **Resolve "today"** per the date rules (for the log line's date).
2. **Verify-before-claiming:** only record what the user stated or what can be confirmed. Do not upgrade an item to "done" beyond what the update says.
3. **Tracker — Remaining:** tick / reword the one item the update affects (add it if new).
4. **Tracker — Daily log:** append or amend today's entry with the update (append-only across days; same-day amendments are fine).
5. **Report** the one-line change made. If the update looks *material* (a gate cleared, a deploy verified, scope/ownership changed, a date moved), just note "this looks timeline-worthy — run `SYNC` when ready." Do **not** touch the timeline or other docs.

`LOG` is tracker-only by design. It never writes the timeline or any other doc — reconciling those is `SYNC`'s job (or `EOD`). This keeps `LOG` a quick, safe capture.

## SYNC — Reconcile the docs (anytime, self-directed)

Reconciles the **timeline and any other project tracking docs against the tracker** — figuring out what has drifted on its own, rather than the user naming what to sync. Run it anytime the tracker has moved ahead of the rest (after a batch of `LOG`s, before a meeting, mid-day). `EOD` runs this same reconciliation as part of its wrap.

**Trigger (paste):** `SYNC: reconcile docs` (optionally scope: `— timeline only`).

**Steps:**
1. **Resolve "today"** per the date rules.
2. **Read the tracker** (Remaining + recent daily log) as the source of truth for current state.
3. **Compare** the timeline (its latest snapshot + "as of" markers) and any other project docs against the tracker. Identify drift: items the tracker shows resolved/changed that the timeline still shows stale, dates/"as of" markers behind, scope/ownership shifts not reflected.
4. **Apply by impact:**
   - **Trivial tracker-internal consistency** (a stale "as of" date, a checklist marker that contradicts its own log line) → fix and report.
   - **Anything touching the timeline or another stakeholder-facing doc** (a new snapshot, a baseline-adjacent change, status wording a PM reads) → **show the proposed change and ask before writing.** The timeline is stakeholder-facing; it is not edited silently.
5. **Verify-before-claiming:** never sync an unverified item into the timeline as done. If the tracker itself marks something unverified, carry that qualification across; don't upgrade it.
6. **Timeline is for project deliverables only.** Internal process / tooling work (workflow or steering changes, doc-structure fixes, tracker tooling) stays in the tracker's daily log and does **not** go to the stakeholder timeline — the timeline carries the actual project requirements and delivery. Don't propose a timeline snapshot for process/tooling drift; reconcile it in the tracker only.
7. **Report** what was reconciled (auto-applied) and what is awaiting confirmation (timeline-facing).

`SYNC` does not invent status — it only propagates what the tracker already records. If the tracker is behind reality, `LOG` it first, then `SYNC`.

## EOD — End of Day (Wrap)

**Trigger (paste):** `EOD: wrap my day` + a brief list of what got done / changed today.

**Steps:**
0. **Resolve "today"** per the rules above — the dated log line must use the resolved date. If there was a tracking gap, record that in the new entry.
1. **Tracker — Remaining:** tick completed items; add new items that surfaced; reword any item whose status changed. Keep wording neutral and factual.
2. **Tracker — Daily log:** append a new dated entry (append-only — never edit past entries). Capture: what was done, decisions made, what's still open, and anything unverified.
3. **Priority banner / "as of" markers:** update the date and the ordered priority list if it changed.
4. **Run the `SYNC` reconciliation** (see above): add a dated timeline snapshot if something material changed, and bring any other drifted project docs in line with the tracker. The preserved baseline stays untouched; timeline-facing changes still surface for confirmation per `SYNC`'s rules.
5. **Report** a one-paragraph summary of what you changed and list anything still unverified.

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
