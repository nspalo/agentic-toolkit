# Investigation Workflow

## When to Use

When a bug is reported, data looks wrong, or unexpected behavior is observed — and the root cause is not immediately obvious.

## Active Project

Artifacts produced by this workflow go to the active project's directory in the dev-context workspace. Determine the active project from:
1. The project-context loaded at session start
2. The workspace-identity routing table
3. If ambiguous, ask the user: "Which project should this investigation go under?"

## Process

### Step 1: Gather Facts

- What was reported? By whom? When?
- What environment/period is affected?
- What is the expected behavior vs actual?
- Is there existing documentation or test cases for this area?

### Step 2: Trace the Code

- Identify the code path that produces the observed output
- Read the relevant functions/queries end-to-end
- Note any assumptions the code makes about data shape or state

### Step 3: Form Hypothesis

- Based on the code trace, what could cause the discrepancy?
- State this as a hypothesis, not a conclusion
- Mark confidence level: "inferred from code — needs data verification"

### Step 4: Verify with Data

- Query or inspect actual data to confirm/deny the hypothesis
- If confirmed: proceed to analysis
- If denied: revise hypothesis, trace another code path

### Step 5: Write the Report

Follow the investigation report format:

```
Header (metadata) → Summary → Evidence → Analysis → Expected Fix → Scope → Next Steps → Cross-Reference
```

Key rules:
- Separate observed data (facts) from analysis (interpretation)
- State confidence explicitly
- Don't propose fixes until root cause is verified
- Reference test cases by ID + description

### Gate 1: Report Validation

Before the report is considered complete:

- [ ] All claims are backed by evidence (data, code trace, query result)
- [ ] Root cause is confirmed, not inferred
- [ ] Confidence level is stated explicitly
- [ ] No half-baked truth — unverified items are marked as such or removed
- [ ] Report reviewed by user (present summary, wait for acknowledgment)

**RULE:** Do NOT proceed to ticket creation until the report passes this gate.

### Step 6: Create Ticket (if fix is needed)

### Gate 2: Report → Ticket Validation

Before creating a ticket from the report:

- [ ] Root cause is verified and certain (not "inferred from code")
- [ ] Fix direction is clear (the Expected Fix section is actionable)
- [ ] Scope is understood (which locations, which tenants, what's affected)
- [ ] User approves the fix direction

**RULE:** A ticket is a commitment to implement. Do NOT create one from an unverified report.

After passing Gate 2:
- Report describes WHAT happened and WHY
- Ticket describes WHAT to implement and WHERE
- Cross-reference each other

## File Placement

```
technical-notes/investigation/YYYYMMDD-short-name/
├── REPORT-00-initial-investigation.md
├── REPORT-01-deeper-analysis.md       (if needed)
├── query-01-description.csv           (supporting data)
└── generated-files/                   (gitignored output)
```

## Quality Checklist

- [ ] Header has all required fields (reported by, JIRA, date, environment)
- [ ] Summary states root cause + confidence in 1-2 sentences
- [ ] Evidence section contains actual data, not assumptions
- [ ] Analysis explains WHY, not just WHAT
- [ ] Every claim is backed by evidence or marked as inferred
- [ ] Cross-references include file paths with repo shorthand
