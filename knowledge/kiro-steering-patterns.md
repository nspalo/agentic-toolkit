# Kiro Steering Patterns

## What Steering Files Are

Steering files provide additional context and instructions to Kiro sessions. They live in `.kiro/steering/*.md` within a workspace folder.

## Inclusion Types

| Type | Front-matter | When loaded | Use for |
|---|---|---|---|
| Always (default) | None or `inclusion: auto` | Every session automatically | Rules that should always apply (conventions, boundaries) |
| Conditional | `inclusion: fileMatch` + `fileMatchPattern: '*.php'` | When a matching file is in context | Language-specific or file-type-specific guidance |
| Manual | `inclusion: manual` | Only when user provides via `#` context key | Workflows invoked on demand (investigation, bug fix) |

## Recommended Structure for a Project

```
.kiro/
├── steering/
│   ├── conventions.md      # (auto) Naming, file placement, cross-refs
│   ├── rules.md            # (auto) Git safety, development rules
│   ├── repository-map.md   # (auto) Multi-repo boundaries
│   ├── tech-stack.md       # (auto) Framework, tools, commands
│   ├── structure.md        # (auto) Directory layout, architecture
│   ├── product.md          # (auto) What the system does (domain)
│   ├── fix-bug.md          # (manual) Bug fix workflow
│   ├── investigate.md      # (manual) Investigation workflow
│   └── testing.md          # (manual) Testing methodology
├── hooks/
│   └── git-commit-guard.json
└── specs/
    └── feature-name/
        ├── requirements.md
        ├── design.md
        └── tasks.md
```

## Sizing Guidelines

- Auto-included files consume context every session — keep them focused and concise
- Manual files can be longer since they're only loaded when relevant
- If a steering file exceeds ~200 lines, split it into multiple focused files
- Use file references (`#[[file:path]]`) to include external docs without duplicating content

## Referencing Other Docs: `#[[file:]]` vs Plain Path

Two different mechanisms — pick deliberately:

| Mechanism | Behavior | Use when |
|---|---|---|
| `#[[file:path]]` | Kiro **injects the referenced file's full content** into context when the steering loads | The content must always be present. Costly for large docs — every session pays for it. |
| Plain path in backticks (e.g. `` `projects/x/doc.md` ``) | Not auto-loaded — a pointer the AI reads **on demand** with a file tool | The doc is large / authoritative-elsewhere and only needed sometimes. Preferred for design/schema docs. |

For big reference docs (technical designs, schemas), prefer the **plain-path pointer** — auto-injecting them bloats every session. Keep enough detail inline in the steering file that it stands alone; the pointer is for "go deeper when needed."

### Cross-repo path resolution (draft → promote gotcha)

Relative paths resolve from the **steering file's location**. A draft in `<workspace>/projects/{name}/.kiro-draft/steering/` that references `../../documentation/x.md` will **break** when promoted to `<project>/.kiro/steering/` — a different repo where that relative path doesn't exist, and where dev-context docs aren't reachable by relative path at all.

Guidance:
- In drafts, reference dev-context docs by a **stable workspace-relative path** (e.g. `` `projects/{name}/documentation/x.md` ``) matching how the project's other docs cross-reference each other — not fragile `../../`.
- At promotion time, re-verify references resolve from the code repo. If the target lives only in dev-context, either inline the needed content or switch to an absolute URL — a relative path from the code repo won't reach it.

## Layering Across Repos

When multiple workspace folders have `.kiro/steering/`:
- Each folder's steering applies when working in that folder
- Global rules (from toolkit) apply across all
- Project-specific rules take precedence over global on conflicts

## Common Patterns

### Context Boot (auto-included)
Small file that references the project context:
```markdown
---
inclusion: auto
---
# Project Context
#[[file:../../[workspace]/project-name/project-context.md]]
```

### Workflow Trigger (manual)
```markdown
---
inclusion: manual
---
# Investigation Workflow
[Full workflow steps loaded only when user invokes investigation]
```

### Conditional per File Type
```markdown
---
inclusion: fileMatch
fileMatchPattern: '*.graphql'
---
# GraphQL Conventions
[Loaded only when working with .graphql files]
```
