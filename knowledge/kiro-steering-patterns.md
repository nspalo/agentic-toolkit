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
