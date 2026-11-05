# Project Update Workflow

A manual command that generates a **stakeholder-facing project update** — highlight / lowlight per project, plus risks and next steps — from the same day-to-day tracking documents the Daily Sync workflow uses. Paste-only: it produces text to drop into Slack / email / a status channel; it does **not** modify the tracking docs.

This is the *outward* view. Daily Sync (`workflows/daily-sync.md`) is the developer's *working* view (SOD/EOD). Both read the same tracker + timeline, apply the same verify-before-claiming discipline, and differ only in audience and output.

## When to Use

- A manager / PM / SDM asks for a status update ("highlight and lowlight", weekly status, RAG update).
- Before a sync meeting, to summarize where each project stands.

## Tracking Documents (inputs)

Same inputs as Daily Sync — the project's declared **tracker** (day-to-day log + Remaining) and **timeline** (baseline + snapshots). If the paths aren't declared in the active project's context or steering, **ask the user** before running.

## Core Principles (carry into every run)

1. **Read before claiming.** Build the update from what the docs actually say, not memory.
2. **Never report an unverified item as a win.** If a deploy, review gate, or external-team item isn't confirmed, it is "pending" / "in progress" — not a highlight. Put genuinely-unconfirmed items in a short "to confirm" note or ask the user before including them.
3. **Audience-appropriate language.** Plain, stakeholder-readable. Minimize ticket-key soup — reference a key only when the reader tracks it. Lead with outcomes, not mechanics.
4. **Honest lowlights.** Slips, blockers, and risks go in plainly. A clean-looking update that hides a known risk erodes trust and is the opposite of useful.
5. **Respect scope + calendar rules** the project declares (what's in/out of scope, working-calendar / holiday logic for date math).
6. **Read-only.** This command never edits the tracker or timeline.

## Trigger

**Paste:** `PU: project update`
Optionally append audience and/or projects: `— for <name>, <PROJECT> + <PROJECT>` and any period (`— week of YYYY-MM-DD`).

## Steps

1. **Resolve "today"** (reuse Daily Sync's date-resolution + staleness rules): user-supplied date → session/PC date → sanity-check against the tracker; net-check only on a date contradiction; flag a tracking gap if the last entry is stale.
2. **Read** the tracker's Remaining + recent daily log and the latest timeline snapshot. Determine per-project state.
3. **Classify each item** as highlight (done + verified, or solid progress), lowlight (slip / blocker / risk), or pending (done-but-unverified → stays out of highlights).
4. **Flag unverified items** to the user if any would materially change the update's tone (e.g. a "shipped" that isn't confirmed). Ask before presenting it as a win.
5. **Produce the update** in the output shape below — per project, concise.
6. **Report** the text only. Do not modify any doc. (If the user later says "save it", place it under the project's documentation/updates area per the workspace's placement rules.)

## Output Shape

```
Project Update — <audience>, <date>

<PROJECT A> (<one-line status>)
  Highlights:
    - <outcome, plain language>
    - <outcome>
  Lowlights / risks:
    - <slip or risk, with impact>
  Next:
    - <next step> (<owner/when if known>)

<PROJECT B> (<one-line status>)
  Highlights:
    - ...
  Lowlights / risks:
    - ...
  Next:
    - ...

To confirm (not yet verified): <item>, <item>   ← only if any exist
```

Keep each section to a few lines. If a project has no lowlight, say "none this period" rather than padding.

## Notes

- **Industry parallel:** weekly status report / RAG (red-amber-green) stakeholder update. The highlight/lowlight framing is the common shape; keep it short and outcome-first.
- **Paste-only by default.** Saving a history of updates is optional and opt-in (`PU: project update — save`), to keep a trail of what was reported to whom. Default keeps it light.
- **Consistency with Daily Sync:** the two workflows must agree on project state. If this command finds the tracker says one thing and you know another, that's a sign an EOD wrap is overdue — flag it, don't paper over it.
