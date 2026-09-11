---
inclusion: manual
---

# Report Standards

## Report Header (Required)

All investigation reports MUST include a single **Document Info** block. The investigation-specific fields (Reported by, Investigated by, Environment, Period analyzed) are **rows inside the same table** — not loose bold lines below it:

```markdown
# [Title] — [Short Description] (YYYYMMDD)

## Document Info

| | |
|---|---|
| **Document type** | Investigation Report |
| **Status** | [Draft / Active / Approved] |
| **Date** | YYYY-MM-DD (Reported) · YYYY-MM-DD (Investigated) |
| **Author / Reporter / Investigator** | [Name, Role] |
| **Assisted by** | [Kiro / AI tool name, or omit if N/A] |
| **Audience** | [PM, SDM, Dev team] |
| **Environment** | [Where data was pulled from] |
| **Period analyzed** | [Optional — relevant time period, or omit] |
| **JIRA** | [PROJ-XXX](link) or TBA |
```

Rules:
- **One box.** Do not append loose `**Field:**` lines after the table.
- **Collapse identical roles.** When Author, Reporter, and Investigator are the same person, use a single `Author / Reporter / Investigator` row. Split into separate rows (`Reported by`, `Investigated by`) only when they differ.
- **Don't repeat the AI-assist.** `Assisted by` already records Kiro's involvement — don't also tag "(Kiro-assisted)" on the author/investigator row.

Rules:
- `(YYYYMMDD)` in the title = date the report was CREATED
- `**Date:**` in Document Info = date the issue was REPORTED + date investigated
- JIRA link must be clickable. Use `TBA` if not yet assigned.

## Report Structure (Single Issue)

1. **Summary** — what was reported, root cause in 1-2 sentences, confidence level
2. **Evidence** — affected data, code trace, observed behavior
3. **Analysis** — why the gap exists, historical context
4. **Expected Fix** — brief direction (2-3 sentences). Full detail in ticket file.
5. **Scope Assessment** — quick decision-support: severity, data loss, tenants affected
6. **Next Steps** — what's pending
7. **Cross-Reference** — links to related docs, code, tickets

## Confidence Markers

Always state what is confirmed vs inferred:

- "Root cause (code trace, not yet verified with data)"
- "Confirmed via query (see Appendix)"
- "Inferred from code — needs data verification"

## Report ↔ Ticket Relationship

- **Report:** describes what happened and what we think will fix it
- **Ticket:** describes exactly what to implement (before/after, locations, ACs)
- Locally: reference each other by relative path
- On Confluence/wiki: ticket becomes sub-page of report

## File Naming

```
technical-notes/investigation/YYYYMMDD-short-name/
├── REPORT-00-initial-investigation.md
├── REPORT-01-deeper-analysis.md
├── query-01-description.csv
└── generated-files/     (gitignored)
```

- `00` = initial investigation
- `01`, `02` = subsequent rounds
- Directory name = date of first report + short descriptive name

## Quality Standards

- Separate **observed data** (facts) from **analysis** (interpretation)
- Do NOT include proposed fixes unless root cause is fully verified
- Every claim must be backed by evidence or explicitly marked as unverified
- Include enough context that someone unfamiliar with the project can follow the logic
