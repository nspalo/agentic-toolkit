# Extract to Toolkit Workflow

## Purpose

Periodically review project-specific knowledge and extract generic patterns back into the toolkit. This keeps the toolkit alive and growing — preventing it from becoming stale while all real learning accumulates in your dev-context workspace.

## When to Run

- End of a major feature or epic
- After a production incident is resolved
- When you notice yourself doing the same thing on a different project
- Quarterly review (calendar reminder)

## Process

### Step 1: Identify Candidates

Review recent work in your dev-context workspace `projects/{name}/`:

| Look in... | For... |
|---|---|
| `knowledge-base/` | Problem patterns that apply universally (not just this project) |
| `technical-notes/investigation/` | Investigation techniques or report improvements |
| `.kiro-draft/steering/` | Steering patterns that would help on any project |
| `documentation/` | Documentation formats that worked well |

**The question:** "Would I use this at a different company, on a different tech stack?"

### Step 2: Generalize

Strip project-specific details:
- Remove company names, internal URLs, JIRA IDs
- Replace specific table/model names with generic examples
- Keep the pattern, lose the instance
- Preserve the "why" and "prevention checklist"

### Step 3: Place in Toolkit

| Extracted content | Goes to |
|---|---|
| New behavioral rule | `.kiro/steering/` (auto or manual) |
| New workflow | `workflows/` |
| New document template | `templates/documentation/` |
| New engineering pattern | `knowledge/` |
| New hook | `hooks/` |
| Improved existing file | Update in place |

### Step 4: Update Bootstrap

If the extraction reveals something every new project should have:
- Update `templates/project-bootstrap/` with new scaffolding
- Update `scripts/bootstrap-project.sh` if new directories needed

### Step 5: Document the Extraction

Add a brief note to the toolkit's changelog or commit message:
```
docs: extract datetime-boundary pattern from project
```

## Examples of Good Extractions

| Project-specific (stays in dev-context) | Generic (goes to toolkit) |
|---|---|
| "PROJ-287: 2-day lookahead fires in April for charges ending May" | "DateTime boundary pattern: INTERVAL N DAY resolves to midnight, excluding records with time past 00:00:00" |
| "SESSION_CONTEXT.md with 500 lines of project detail" | "Template for project-context.md with section skeleton" |
| "TC001-A override replaces TC001" | "Test case override rule: TCNNN-A is active, TCNNN is historical" |
| "Investigation report for ghost rows (company data)" | "Investigation workflow with confidence markers" |

## Anti-Patterns

- **Don't extract too early** — wait until the pattern proves itself across 2+ incidents
- **Don't extract company data** — if someone at the company would say "that's our system," it stays in notes
- **Don't duplicate** — if the toolkit already has it, update rather than create new
- **Don't over-generalize** — a pattern with no specific examples is useless. Keep one anonymized example.
