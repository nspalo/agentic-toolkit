---
inclusion: auto
---

# Conventions

## Naming

- JIRA tickets: `PROJ-XXX`
- Branches: `{type}/PROJ/PROJ-{number}` (from main branch)
- Test cases: `TCNNN.md`
- Test case overrides: `TCNNN-A.md` — the `-A` is the active version; non-A is historical, skipped during simulation
- Technical notes: `PROJ-{id}-{type}-{name}.md`
- Investigation directories: `YYYYMMDD-short-name/`
- Investigation reports: `report-NN-short-name.md` (00 = initial, 01+ = subsequent)

## File Placement

| Content type | Path |
|---|---|
| JIRA ticket docs | `technical-notes/jira/tickets/` |
| Epic docs | `technical-notes/jira/epics/` |
| Design proposals | `technical-notes/jira/proposals/` |
| Investigation reports | `technical-notes/investigation/YYYYMMDD-name/` |
| Test cases | `testcases/` |
| System diagrams | `system-diagrams/` |
| Knowledge base | `knowledge-base/` |
| Generated output | `generated-files/` (gitignored) |

## Documentation Content Structure

When creating methodology/process documentation, follow:

```
What is it → How we do it → Does it work → Is it credible
```

Summary → Concept → How It Works → Why It Works → Strengths → Limitations → Conclusion → Appendix

## Cross-References

Always prefix paths with repo shorthand in multi-repo context:

| Shorthand | Repository |
|---|---|
| `[Code]` | `repo-name` |

Within documents, use markdown anchor links for internal references:

```markdown
[See detailed analysis](#section-heading-as-anchor)
```

## File Naming Convention

- All files and directories: kebab-case, lowercase
- Exceptions: `README.md`, `CHANGELOG.md`
- Exceptions: JIRA project codes stay uppercase in filenames (e.g., `PROJ-123-fix-name.md`)
- Dotfiles: follow their own conventions (`.gitkeep`, `.gitignore`)
- Numbered prefixes: `00-`, `01-`, `02-` (for ordered sequences)
