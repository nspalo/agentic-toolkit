# {{PROJECT_NAME}} — Project Context

> Load this at the start of each session for project-specific context.

---

## Workspace Overview

| Directory | What it is |
|-----------|-----------|
| `TBA` | **Main project.** Description here. |

---

## System Overview

### What It Does

[Describe the system's primary function]

### Key Commands / Endpoints

| Command/Endpoint | Purpose |
|---------|---------|
| TBA | TBA |

### Key Tables / Models

| Table/Model | Purpose |
|-------|---------|
| TBA | TBA |

---

## Testing & Verification

### Verification Method

[Describe how correctness is validated for this project]

### Test Case Simulation

[Describe the simulation process — what "expected vs actual" means here]

---

## Naming & File Conventions

### Naming

- JIRA tickets: `PROJ-XXX`
- Branches: `feature/PROJ/PROJ-{number}` or `{type}/PROJ-XXX-description`
- Test cases: `TCNNN.md` or `TCNNN-short-name.md`
- Technical notes: `PROJ-{id}-{type}-{name}.md`
- Investigation directories: `YYYYMMDD-short-name/`
- Investigation reports: `report-NN-short-name.md` (00 = initial, 01+ = subsequent)

### File Placement

| Content type | Path |
|---|---|
| JIRA ticket docs | `{{PROJECT_NAME}}/technical-notes/jira/tickets/` |
| Epic docs | `{{PROJECT_NAME}}/technical-notes/jira/epics/` |
| Design proposals | `{{PROJECT_NAME}}/technical-notes/jira/proposals/` |
| Investigation reports | `{{PROJECT_NAME}}/technical-notes/investigation/` |
| Test cases | `{{PROJECT_NAME}}/testcases/` |
| System diagrams | `{{PROJECT_NAME}}/system-diagrams/` |
| Knowledge base | `{{PROJECT_NAME}}/knowledge-base/` |
| Generated output | `{{PROJECT_NAME}}/generated-files/` (gitignored) |

---

## Cross-References

When referencing files across repos, prefix with repo shorthand:

| Shorthand | Repository |
|---|---|
| `[ProjectCode]` | `repo-name` |

Example: `[ProjectCode] app/path/to/file.php`

---

## Recent Work

| JIRA | What | Status |
|------|------|--------|
| TBA | TBA | TBA |
