---
inclusion: auto
---

# Filesystem Boundary Rules

## Allowed Without Asking

- Reading/writing files INSIDE the active project workspace
- Reading files outside the workspace (for reference only)

## Never Without Explicit Permission

- Writing, creating, or modifying files OUTSIDE the project workspace
- This includes: `~/`, `~/.kiro/`, `~/.config/`, system directories, other project repos
- ALWAYS ask: "This change needs to go at `{path}` which is outside the project. Should I create it there, or would you prefer to handle it yourself?"

## The Rule

If the file path is not within the active project directory, STOP and ASK first.

## What Counts as "Outside"

- User home directory (`~/`)
- Global config files (`~/.kiro/steering/`, `~/.gitconfig`)
- Other repos in the workspace (unless the task explicitly spans repos)
- System directories (`/etc/`, `/usr/`, etc.)

## Incident Context

This rule exists because of a real incident where an AI assistant created a global steering file at `~/.kiro/steering/` without asking. This modified the user's system-level configuration across all projects.

The AI treated the global directory as part of the project because the conversation was about steering files — it did not distinguish between project-level (`.kiro/steering/`) and user-level (`~/.kiro/steering/`).
