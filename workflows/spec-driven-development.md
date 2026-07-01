# Spec-Driven Development Workflow

## Overview

A structured approach to feature development using Kiro's spec system. Breaks work into three phases with review gates between each.

## Flow

```
Requirements → Design → Tasks → Execute
     ↓            ↓        ↓        ↓
  (Review)    (Review)  (Review)  (Review per task)
```

## Phase 1: Requirements

Define WHAT to build. No implementation details.

- Functional requirements (what the system should do)
- Non-functional requirements (performance, security)
- Acceptance criteria (how to know it's done)
- Edge cases and boundary conditions

**Gate:** Human reviews requirements before design begins.

## Phase 2: Design

Define HOW to build it. Architecture and approach.

- Component/file changes needed
- Data flow and transformations
- API surface (inputs, outputs)
- Dependencies and ordering

**Gate:** Human reviews design before task breakdown.

## Phase 3: Tasks

Break design into executable units.

- Each task = one atomic change (one commit)
- Tasks are ordered by dependency
- Each task has clear done criteria
- Tasks reference which requirement they satisfy

**Gate:** Human reviews task list before execution.

## Phase 4: Execute

Kiro executes tasks one by one.

- Complete one task → show result → wait for review
- Human approves → move to next task
- Human rejects → revise and re-present
- All tasks done → create PR

## When to Use Spec-Driven

| Scenario | Use Spec? |
|---|---|
| New feature (multiple files, new concepts) | ✅ Yes |
| Bug fix (root cause known, scope clear) | ❌ No — use bug-fix workflow |
| Refactoring (behavior unchanged) | Maybe — use if scope is large |
| Single-file change | ❌ No — just do it |
| Investigation (root cause unknown) | ❌ No — use investigation workflow |

## Mapping to JIRA

| JIRA Level | Kiro Equivalent |
|---|---|
| Epic | Feature area (multiple specs) |
| Story | 1 Kiro Spec (requirements → design → tasks) |
| Subtask | 1 Task within the spec |

## Tips

- Keep specs small — one story = one spec = one PR
- Requirements should be testable (every requirement has an acceptance criterion)
- Design should be specific enough that someone else could implement from it
- Tasks should be independently reviewable
