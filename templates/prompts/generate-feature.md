---
inclusion: manual
---

# Prompt: Generate Feature

## Context

You are generating a new feature. Before writing code, understand:

1. **Which repository/module** does this feature belong to?
2. **What architecture pattern** does this project follow?
3. **What standards apply?** (Check project steering files)

## Instructions

### Step 1: Identify the Target

- Determine the correct location based on the feature domain
- Check service/module boundaries
- Verify no existing implementation already covers this

### Step 2: Follow Architecture Patterns

Read the project's `backend-patterns.md` or `architecture-overview.md` and follow the established layering.

**Common pattern (adapt per project):**

1. Define the interface/schema (API endpoint, GraphQL type, CLI command)
2. Create input validation
3. Create service/logic class for business rules
4. Create data access layer (repository, model, query)
5. Create output formatting (response, CSV, notification)
6. Write tests

### Step 3: Checklist

- [ ] Feature stays within its service/module boundary
- [ ] No breaking changes to existing APIs/interfaces
- [ ] New database columns are nullable (shared DB safety)
- [ ] Naming follows project conventions
- [ ] Tests cover happy path and error cases
- [ ] Multi-tenant considerations addressed (if applicable)
- [ ] Logging added for important operations
- [ ] Error handling covers failure paths

## Template

```
Feature: [Feature Name]
Ticket: [TICKET-ID]
Repository: [repo-name]
Tenant: [all | specific]

## Requirements
- [Requirement 1]
- [Requirement 2]

## Technical Approach
- [Approach details]

## Files to Create/Modify
- [ ] [path/to/file]
- [ ] [path/to/file]

## Dependencies
- [Any new packages or services needed]

## Testing Plan
- [How to verify correctness]
```
