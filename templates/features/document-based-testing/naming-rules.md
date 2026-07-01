# Document-Based Testing — Naming Rules

Add these to your project's conventions when this feature is activated.

## Test Case Files

- Location: `testcases/` in the project's dev-context directory
- Base: `TCNNN.md` (e.g., `TC001.md`, `TC035.md`)
- Override: `TCNNN-A.md` (e.g., `TC001-A.md`, `TC013-A.md`)
- No description in filename — the content tells you what it tests

## Generated Output

- Location: `generated-files/` in the project's dev-context directory
- Gitignored — these are local artifacts from system runs
- Naming follows whatever the system produces (don't rename output files)

## Override Rule

When a `-A` variant exists:
- `TCNNN-A.md` = active (use this during simulation)
- `TCNNN.md` = historical reference (skip during simulation)
- Keep both — the non-A version documents the original scenario
