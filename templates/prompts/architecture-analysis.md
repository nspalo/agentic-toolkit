---
inclusion: manual
---

# Prompt: Architecture Analysis

## Context

Analyze the architecture of {{COMPONENT/FEATURE/SYSTEM}} to understand:
1. How it currently works
2. What patterns it uses
3. Where the complexity lives
4. What risks or debt exist

## Instructions

### Step 1: Map the Components

- Identify entry points (commands, controllers, resolvers, routes)
- Trace the data flow from input to output
- Identify shared dependencies and coupling points
- Note any duplication or unusual patterns

### Step 2: Assess Complexity

| Component | Lines | Complexity | Risk Level |
|---|---|---|---|
| {{FILE/CLASS}} | {{LOC}} | {{HIGH/MED/LOW}} | {{RISK}} |

### Step 3: Identify Patterns

- What architecture pattern is in use? (MVC, layered, event-driven, batch)
- Is it consistently applied?
- Where does it deviate and why?

### Step 4: Document Findings

## Output Format

```markdown
# Architecture Analysis: {{COMPONENT}}

## Overview
[What it is, what it does, how it fits in the system]

## Data Flow
[Input → Processing → Output diagram]

## Key Components
[Table of files/classes, their roles, dependencies]

## Patterns Used
[What patterns, where they're applied consistently, where they deviate]

## Complexity Hotspots
[Where the most complex/risky code lives]

## Technical Debt
[What should be improved, in priority order]

## Recommendations
[Actionable suggestions with effort estimates]
```
