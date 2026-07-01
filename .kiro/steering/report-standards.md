---
inclusion: manual
---

# Report Standards

## Report Header (Required)

All investigation reports MUST follow this header:

```markdown
# [Title] — [Short Description] (YYYYMMDD)

**Reported by:** [Name]
**JIRA Ticket:** [PROJ-XXX](https://your-jira.atlassian.net/browse/PROJ-XXX) or TBA
**Investigated by:** [Name]
**Date:** [Date issue was REPORTED — not when report was written]
**Environment:** [Where data was pulled from]
**Period analyzed:** [Optional — relevant time period if applicable]
```

Rules:
- `(YYYYMMDD)` in the title = date the report was CREATED
- `**Date:**` field = date the issue was REPORTED/FILED
- `**JIRA Ticket:**` must include clickable links. Use `TBA` if not yet assigned.

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
