---
inclusion: auto
---

# Naming Conventions

## Files and Directories

- All files and directories: **kebab-case, lowercase**
- Exceptions:
  - `README.md`, `CHANGELOG.md` (universal convention)
  - JIRA project codes stay uppercase in filenames (e.g., `PROJ-123-fix-name.md`)
  - Dotfiles follow their own conventions (`.gitkeep`, `.gitignore`, `.env`)
- Numbered prefixes: `00-`, `01-`, `02-` (for ordered sequences like knowledge-base articles)

## Test Cases (When Document-Based Testing is Active)

Only applies to projects using the document-based testing feature (see `templates/features/document-based-testing/`):

- Base: `TCNNN.md` (e.g., `TC001.md`, `TC035.md`)
- Override: `TCNNN-A.md` — the `-A` is the active/revised version; non-A is historical, skipped during simulation

## Investigation Directories

- Location: `technical-notes/investigation/`
- Directory: `YYYYMMDD-short-name/` (date of first report + descriptive name)
- Reports inside: `REPORT-NN-short-name.md` (00 = initial, 01+ = subsequent)

## JIRA-Prefixed Files

Location: `technical-notes/jira/`

| Type | Filename Pattern | Directory |
|---|---|---|
| Epic | `PROJ-100-epic-description.md` | `jira/epics/` |
| Story | `PROJ-101-story-description.md` | `jira/tickets/` |
| Task | `PROJ-102-task-description.md` | `jira/tickets/` |
| Bug | `PROJ-103-fix-description.md` | `jira/tickets/` |
| Proposal (pre-ticket) | `PROJ-XXX-design-description.md` | `jira/proposals/` |

- `PROJ-XXX` = placeholder until JIRA ID is assigned
- Once a proposal gets a JIRA ID, rename the file with the real ID
- Stories, tasks, and bugs all live under `jira/tickets/`

## Knowledge Base

- `NN-topic-name.md` (e.g., `00-index.md`, `02-topic-name.md`)
