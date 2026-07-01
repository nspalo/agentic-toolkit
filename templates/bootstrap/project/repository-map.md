---
inclusion: auto
---

# Repository Map

## Workspace Repositories

| Repo | Shorthand | Role | Access |
|---|---|---|---|
| `repo-name` | `[Code]` | **Primary** — code changes | Read + Write |
| `other-repo` | `[Other]` | Reference / upstream | Read-only |
| `[workspace]/projects/{{PROJECT_NAME}}` | `[Notes]` | Working directory — docs, test cases | Write docs |

## Boundaries

| If you need to... | Do it in... | NOT in... |
|---|---|---|
| Modify application logic | `[Code]` | — |
| Create investigation reports | `[Notes]` | Don't put in code repo |
| Create test cases | `[Notes]` testcases/ | — |
| Check schema/table structure | Source migrations or models | Don't guess |

## Cross-Reference Format

When referencing files across repos, always prefix with the shorthand:

```markdown
- Code: `[Code] app/path/to/file.php` lines ~XX
- Schema: `[Migrations] database/migrations/YYYY_MM_DD_filename.php`
- Report: `[Notes] technical-notes/issue-investigation/...`
```
