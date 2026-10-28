# Stop Retrying a Wedged or Hanging Tool

> Portable lesson. Generic failure; specifics anonymized.

## The failure mode

A tool or command hangs, is interrupted, or is cancelled. Instead of switching methods, the agent **re-runs the same tool the same way** — again, and sometimes a third time — each time stalling for minutes before the user cancels. A related variant: a shell command opens an interactive pager (e.g. `less`) that **wedges the terminal**, so every following command is swallowed as pager keystrokes and output comes back garbled; the agent keeps feeding variants into the stuck shell instead of resetting and changing approach.

## What it looked like (real incident, anonymized)

In one session a content-search tool hung three separate times (twice reported "interrupted before it reported a result"), and a version-control `diff` run through the shell launched a pager that wedged the terminal. The reliable workaround — redirect output to a temp file and read the file, or use a dedicated file tool — was discovered early, used once, then **abandoned on the next similar task** in favor of the failing tool again. The user had to cancel repeatedly and escalate before the behavior changed. A portable lesson describing exactly this wedged-terminal failure was already loaded in context and was not applied at the decision point.

## Root cause

- **Treated "no error yet" / "still running" as a reason to wait, and "interrupted" as a reason to retry** — rather than as a signal to change method.
- **Fought a wedged terminal** with more variants instead of resetting it and avoiding the thing that wedged it.
- **Action-bias over observed evidence:** reached for the "normal" tool each time instead of the method that had just proven reliable in this exact environment.
- Reading a rule ≠ applying it at the moment of the tool call.

## Guardrails

- **Two-strikes circuit-breaker.** If a tool/command hangs, is interrupted, or is cancelled **once**, do not re-run it the same way. After the **second** failure of any kind, switch method entirely and say so out loud.
- **Prefer a method that can't be derailed by shell/terminal state.** For search/read where an interactive tool hangs, redirect command output to a temp file and read the file, or use a dedicated file tool. Verify success by **exit code**, not by scrollback text.
- **Never let output go through an interactive pager in a non-interactive context.** Disable it explicitly (e.g. a `PAGER=cat` / `--no-pager` equivalent) and/or redirect to a file.
- **A wedged terminal is a reset-and-change-method point**, not an invitation to retry — send one reset, then use a different approach.
- **When a loaded lesson matches the situation, apply it at the decision point** — not after the user points it out.

## The one-line test

Before re-running a tool that just hung or was interrupted, ask: *"Did this exact approach already fail once? Then why would the same call succeed now?"* If it failed once, change method.

## Related

- `knowledge/write-to-an-absolute-path-and-verify.md` — sibling tool-hygiene lesson (wedged/odd terminal, verify after writing)
- `knowledge/follow-the-procedure-you-were-told-to-check.md` — tool-hygiene / improvisation failures
- `.kiro/steering/filesystem-boundaries.md`
