---
inclusion: manual
---

# Bug Fix Workflow

## Before Writing Code

1. **Read the investigation report** (if one exists)
2. **Identify all affected locations** — check the N-location rule
3. **Verify names from source** — table/model names, column names, never assume
4. **Check which code path exercises this** — which command, endpoint, or job?

## The Fix

### Step 1: Understand

- What is the expected behavior?
- What is the actual behavior?
- Which function/method/query is involved?

### Step 2: Identify Scope

- [ ] How many locations need the same change?
- [ ] Does it affect multiple tenants/environments?
- [ ] Does it affect downstream output (reports, APIs, notifications)?
- [ ] Is there a test case for this scenario?

### Step 3: Implement

- Fix the root cause, not the symptom
- Keep the fix minimal — don't refactor adjacent code
- Add comments documenting the fix: `{{COMMENT_CONVENTION}}`
- Apply to ALL affected locations

### Step 4: Verify

- [ ] Run test case simulation for the specific scenario
- [ ] Run functional simulation (related test cases sharing same code path)
- [ ] Smoke test: run the command/endpoint locally, check for errors
- [ ] Show changes for code review — do NOT commit

## N-Location Checklist

If the fix touches duplicated/shared logic:

- [ ] Location 1: `{{FILE}}` — {{SECTION}}
- [ ] Location 2: `{{FILE}}` — {{SECTION}}
- [ ] Location 3: `{{FILE}}` — {{SECTION}}
- [ ] Location 4: `{{FILE}}` — {{SECTION}}

## After Fix

1. Stop and present changes for review
2. Describe what was changed and why
3. Reference the test case that validates it
4. Wait for approval before commit
