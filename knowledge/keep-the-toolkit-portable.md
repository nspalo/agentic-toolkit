# Keep the Toolkit Portable

> Portable lesson about the toolkit itself. The toolkit is company-, project-, and person-agnostic by definition — this file guards that property.

## The rule

The `agentic-toolkit` repo defines **HOW to work**, not **WHAT you're working on**. Nothing written into it may contain:

- Company or product names
- Project codes or JIRA keys
- Real people's names or roles
- Real file paths, table names, enum names, or other codebase specifics

Project/company specifics live in the **dev-context workspace** (`projects/{code}/`, `research/`, `domain-knowledge/`) — never in the toolkit. When a real incident informs a toolkit lesson, **anonymize it**: "another developer", "[assignee]", "a ticket", "[repo]", "an enum value".

## The failure mode

The AI extracts a lesson from a real incident and writes it into the toolkit **verbatim with all the specifics** — names, project codes, file paths. The toolkit stops being portable: copy it to another company/workspace and it leaks the previous client's internal details and reads as project-specific noise.

## Example incident (anonymized)

A knowledge file in the toolkit documenting an "unauthorized code change" lesson was written with a real person's name, a real project code, a real product name, and a real source file path. It should have been fully generic. Worse, when logging a *follow-up* incident, the AI's first draft repeated the same mistake — embedding a project code, a real spec path, and a prior project's name into the toolkit-bound text. The portability rule was known and stated, then violated in the very act of documenting a different violation.

## Root cause

- Copied incident details straight from the working context into the portable file without a sanitize pass.
- Treated "record what happened accurately" as requiring real identifiers, when accuracy of the *lesson* needs none.
- No checkpoint between "draft" and "write to toolkit" to scrub specifics.

## Guardrails

- **Sanitize before writing to the toolkit.** Replace every proper noun and real path with a generic placeholder.
- **Specifics go to the dev-context, lessons go to the toolkit.** If a detail identifies a client/project/person, it belongs in `projects/{code}/knowledge-base/`, not here.
- **Two-tier logging.** Log the concrete incident (with real detail) in the project's knowledge-base if needed; log the *generic lesson* in the toolkit.
- **Placeholder vocabulary:** `[assignee]`, `another developer`, `a ticket`, `[repo]`, `[project]`, "an enum value", "a source file".

## The one-line test

Before saving any file under `agentic-toolkit/`, ask: *"If I handed this repo to a different company tomorrow, would anything in this file leak the previous client or read as project-specific?"* If yes → anonymize first.

## Related

- `README.md` → "What it's NOT: project-specific, company-specific, or a code library"
- `.kiro/steering/documentation-standards.md`, `.kiro/steering/naming-conventions.md`
- `workflows/extract-to-toolkit.md` — the path for promoting generic patterns into the toolkit
