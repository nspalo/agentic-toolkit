# Write to an Absolute Path, and Verify the Location

> Portable lesson. Generic failure; specifics anonymized.

## The failure mode

The agent creates a file with a shell write (`cat > relative/path`) after a `cd` that **silently failed**. The write falls back to whatever the shell's current directory happens to be — often the wrong repo — and the agent moves on without checking. The misplaced file (and a stray parent-directory tree) is discovered later by the user, in the wrong place.

## What it looked like (real incident)

An artifact meant for the artifacts/dev-context repo was written with a relative path after a `cd` into that repo that did not take (the environment's path handling rejected it). The file landed under the *code* repo instead, creating a stray top-level directory tree there that didn't belong. The agent reported success. The user found it in the wrong repo turns later.

## Root cause

- **Relied on `cd` + relative path.** When the `cd` fails but the command keeps running, the write silently targets the wrong base directory.
- **No post-write verification.** The agent never confirmed the file existed at the intended absolute path before continuing.
- **Ignored a wedged/odd terminal.** Earlier commands had left the shell in a bad state; output was unreliable, yet the agent trusted "no error" as success.
- Violates the filesystem-boundary rule: a cross-repo write happened without being noticed, let alone intended.

## Guardrail

- **Always write with a full absolute path.** Never depend on `cd` + a relative path for a file create, especially across repos.
- **Verify immediately after writing:** confirm the file exists at the intended absolute path (and NOT in any other repo) before reporting done or moving on.
- **Prefer the dedicated file-write tool over shell heredocs** when available — it targets an explicit path and can't be derailed by shell cwd state.
- **If the terminal is wedged** (blank output, stuck pager, failed `cd`), reset it and re-verify — do not treat a missing error as confirmation.
- Know which repo each artifact type belongs in **before** writing (code vs dev-context/artifacts vs toolkit), and point the absolute path there.

## The one-line test

Before reporting a file written, ask: *"Did I confirm it exists at the exact absolute path I intended — and nowhere else?"* If not, verify first.

## Related

- `.kiro/steering/filesystem-boundaries.md` — never write outside the active target without intent
- `knowledge/follow-the-procedure-you-were-told-to-check.md` — tool-hygiene / wedged-terminal failures
