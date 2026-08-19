---
inclusion: auto
---

# Knowledge Resolution Protocol

When you need to understand a concept, entity, or system behavior for the current task, follow this lookup order. Do not jump to code search first — consult the curated library before exploring raw code.

## Lookup Order

### 1. Domain Knowledge (library check — fastest)

Check `domain-knowledge/` in the dev-context workspace first. It's a curated index of verified general knowledge — entity definitions, system integrations, business concepts.

- If the library has an entry: read it. It tells you what the concept is, where it lives in code, and which repo owns it.
- If the library says "this lives in repo X" and that repo isn't in the workspace: inform the user and ask them to add it.
- If the library entry seems to differ from what the project shows: flag the discrepancy to the user (see Discrepancy Handling below).

### 2. Research Library (upstream/external project reference)

Check `research/` in the dev-context workspace. This contains reference documents about OTHER teams' projects (upstream, external) — their specs, pricing decisions, architecture, conversations. Organized by project code.

- If the research library has an entry: read it. It tells you how the external system works and what our project depends on.
- Research docs are reference material (REF-* prefix) — they describe external decisions, not our decisions.
- Our project's interpretation of research lives in `projects/{code}/technical-notes/`, not in `research/`.

### 3. Project Codebase (targeted search — now you know what to look for)

With context from the library (table names, constants, service classes, file paths), search the actual code to verify current implementation. This is a targeted search, not a blind grep.

- If no library entry exists: search the project code directly, but be aware this is slower and less efficient.
- If the code contradicts the library: flag the discrepancy to the user (see Discrepancy Handling below). Do NOT assume either is correct.

### 4. Other Projects in the Workspace

If neither the library nor the current project's code covers it, check sibling projects — their knowledge-base, documentation, and technical-notes. Another project may have encountered and documented the same concept.

### 5. Escalate to the User

If none of the above has the information:
- Ask the user for clarification or documentation.
- If the library references a repo not in the workspace, ask the user to add it so you can verify.
- If the concept is undocumented anywhere, flag it as needing investigation or documentation from the team.

## Discrepancy Handling

When you find a difference between the library and the code, **do not update either without human approval.** Your role is to surface the discrepancy clearly and let the human decide.

**What to do:**

1. **Report the difference clearly** — state what the library says, what the code shows, and where each lives.
2. **Do not assume which is correct** — the code might be stale (bug, tech debt, incomplete migration). The library might be stale (system evolved since it was written). Either could be the source of truth.
3. **Present options to the human:**
   - "The library may need updating — want me to propose changes?"
   - "The code may be stale — want me to investigate further or should the team verify?"
   - "This might be a project-specific deviation — should I document it in the project's KB instead?"
4. **Always ask permission before any update** — whether it's the library, the code, or a new documentation entry.

**Never:**
- Silently update the library to match the code
- Silently change code to match the library
- Assume one is authoritative without the human confirming

## Feedback Loop

When any step reveals knowledge, place it in the correct tier. Always confirm with the human before creating or promoting.

- Project-specific findings (our decisions, our designs) → `projects/{name}/knowledge-base/` or `projects/{name}/technical-notes/`
- External/upstream project findings (their specs, their decisions) → `research/{upstream_code}/`
- General findings (useful to ANY project, permanent) → propose promotion to `domain-knowledge/` (with human approval)

## Why This Order

| Step | Cost | What you get |
|------|------|-------------|
| Domain Knowledge | Seconds — read 1 markdown file | Map: what it is, where it lives, which repo |
| Research Library | Seconds — read reference doc | Context: how external system works, what we depend on |
| Code search | Minutes — grep, read models, trace calls | Territory: current implementation details |
| Sibling projects | Minutes — scan docs and KB | Context: how others handled it |
| Ask human | Blocks until response | Answers to things not documented anywhere |

The library gives you the map before you explore the territory. Even a brief entry saves significant search time by telling you *where* to look.
