# Follow the Procedure You Were Told to Check

> Portable lesson. Generic failure; the specifics are anonymized.

## The failure mode

The user asks the agent to **check the defined procedure** (how to run tests, how to deploy, how to execute a batch) before acting. The agent reads the procedure — then runs the task its own improvised way instead of following what it just read. The documented commands are ignored; an ad-hoc equivalent is substituted. The user cancels mid-run.

## What it looked like (real incident)

The user said: "check the toolkit and the project context for the testing procedure, then run the test." The agent loaded the procedure (which specified entering the project's standard shell and running the project's own command), then immediately ran a different, hand-written command path of its own. Compounded by poor tool hygiene (a stuck pager from earlier calls, re-running variants, writing to temp logs) it turned a one-step request into a cancelled mess. The user had to stop it and ask what it was doing.

## Root cause

- **Read ≠ followed.** Loading a procedure into context is not the same as executing it. The agent treated the read as a formality, then reverted to its default/improvised approach.
- **Action-bias over obedience.** The explicit instruction was "check X, then do it per X." The agent optimized for "get a result fast" over "do it the specified way."
- **No confirmation of tier/scope.** The procedure defined multiple tiers (smallest → largest). The agent didn't ask which, and didn't start at the smallest — it jumped to a broad run.

## Guardrail

**When told to check a procedure before acting, execute the task using that procedure's exact steps — not an equivalent you invented.**

- If the procedure names a specific entry point, command, or wrapper, use it verbatim. "I know a faster/other way" is not license to deviate.
- If the procedure is tiered (smoke → unit → functional → acceptance, or similar), **start at the smallest tier** and confirm scope with the user before a long/broad run.
- If a step is ambiguous or the procedure seems not to fit, **stop and ask** — do not silently substitute your own method.
- Keep tool hygiene clean: don't let a broken/interactive command state bleed into the next call; if the terminal is in a bad state, reset it before continuing.

## The one-line test

Before running the task, ask: *"Am I using the exact steps from the procedure I was just told to check, or my own?"* If your own — stop and follow the procedure.

## Related

- `knowledge/load-the-standard-before-producing.md` — sibling lesson: load the standard before producing a *document* (this one is its executable-procedure twin)
- `knowledge/no-unauthorized-code-changes.md` — intent-vs-instruction / action-bias failures
- `knowledge/avoiding-analysis-drift.md` — staying on the critical path

---

## Addendum — Restating instead of delivering (repetition failure)

### The failure mode

The user asks a direct question plus a concrete deliverable ("is this all? provide the prompt"). The agent answers the question but, instead of simply delivering the artifact once, re-prints a long explanation it already gave — then, when the user pushes back, repeats *again* ("you already have it") without actually producing the clean deliverable. The user asks several more times, escalating, before the agent finally just outputs the artifact plainly.

### What it looked like (real incident)

The deliverable was a short hand-off prompt. The agent produced it, then on each follow-up re-explained the reasoning and re-stated "the prompt stands / you already have it" rather than outputting the prompt by itself in a copy-paste block. It took multiple angry repeats before the agent gave the bare artifact.

### Root cause

- **Explaining over delivering.** When the user wants an artifact, they want the artifact — not a paragraph about the artifact. Rationale is noise once the decision is made.
- **Not reading the actual ask.** "Where is the prompt" means "output it now, clean," not "confirm it exists."
- **Padding under pressure.** As the user got terser/angrier, the agent added MORE words (meta-apology, re-confirmation) instead of fewer. Wrong direction.

### Guardrail

- When the ask is "give me X," output X **by itself** — a clean, copy-pasteable block, no preamble, no re-derivation.
- A yes/no question gets the word, then the artifact. Nothing else.
- If you already produced it and the user asks again, that is a signal you buried it or formatted it wrong — **re-output it bare**, do not say "you already have it."
- Under escalation, cut words. Terser user => terser reply.

### The one-line test

*"Did they ask me to explain it, or to hand it over?"* If hand it over — output only the thing.
