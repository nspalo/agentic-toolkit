# Agentic Workflow Transition Guide

> Reference for transitioning from traditional Agile/Scrum to agentic AI workflow.

## Team Structure (Generic)

| Role | Responsibilities |
|------|-----------------|
| Product Manager | Communicates with business, creates epics/stories |
| Project Manager | Relays info, manages blockers, sprint coordination |
| Tech Lead | Requirements study, architecture, code review, Scrum Master |
| Developers | Pick up tasks, implement, create PRs |

## Current Flow (Traditional Agile)

```
PM (Business → Jira)
  → Project Manager (Relay, blockers)
    → Tech Lead (Study requirements + investigate repo + refine Jira)
      → Devs (Pick up task, code, PR)
        → Tech Lead (Code review, merge)
```

## New Flow (Agentic)

```
PM (Business → Jira) — NO CHANGE
  → Project Manager (Relay, blockers) — MINOR CHANGE
    → Tech Lead (Requirements + AI context setup + review)
      → Dev + AI Agent (Dev feeds story to agent, agent generates spec + code, Dev reviews)
        → Agent (Executes tasks autonomously)
          → Dev (Reviews at each gate, commits)
            → Tech Lead (PR review, merge)
```

## The 3-Checkpoint Model

Instead of ~8 human interruption points, consolidate to 3:

| Checkpoint | Who | What |
|-----------|-----|------|
| 1. Review Priorities | PMs + Lead | Decide what to build |
| 2. Review the Spec | Lead + Dev | Approve requirements + design before code execution |
| 3. Final Review | Lead | PR review, approve merge |

Everything between checkpoints is autonomous agent execution.

## Role Changes

### Tech Lead — Significant Change

| Before | After |
|--------|-------|
| Creates/refines Jira | Same (can use AI to draft faster) |
| Designs architecture | Same — captured in steering files (reusable) |
| Codes complex features | Delegates to agent, focuses on review + architecture |
| Reviews PRs | Reviews MORE PRs (higher output from team) |

New: maintains steering files, reviews AI-generated designs, sets quality bar.

### Developers — Major Change

| Before | After |
|--------|-------|
| Picks up story | Same |
| Breaks down work mentally | Agent generates breakdown (tasks.md) |
| Writes code | Reviews agent's code at each gate |
| Creates PR | Automated via Makefile |

New role: quality assurance + context provider + decision maker.

## Mapping: Jira → Specs

| Jira Level | Agent Equivalent | Git Equivalent |
|-----------|----------------|----------------|
| Epic | Feature area (multiple specs) | — |
| Story | 1 Spec (requirements → design → tasks) | 1 branch, 1 PR |
| Subtask | 1 Task within the spec | 1 commit |

## The New Bottleneck

Traditional: Developer coding time
Agentic: **Human review time** (PR reviews)

Mitigation:
- Keep specs small and focused
- Trust design review (checkpoint 2) more, code review (checkpoint 3) lighter
- Use AI code review as first pass
- Batch reviews

## Maturity Stages

| Stage | Description |
|-------|-------------|
| 1. Individual Tooling | Devs use AI individually (suggestions, completions) |
| 2. Team-Scale Orchestration | Spec-driven workflow, steering files, shared knowledge |
| 3. Org-Scale Platform | Agents share context across teams, persistent memory |

## What Stays the Same

- Sprint cadence
- Jira backlog
- PR reviews (human-controlled)
- Acceptance criteria (defined by humans)
- Code ownership (lead has final authority)

## What Gets Reduced

- Manual story point estimation
- Detailed subtask creation in Jira (agent's tasks.md replaces this)
- Manual test writing for happy paths
- Tribal knowledge (encoded in steering files)
