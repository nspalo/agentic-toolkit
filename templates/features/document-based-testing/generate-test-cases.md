# Workflow: Generate Test Cases from JIRA Tickets

## Purpose

Convert JIRA ticket data, bug descriptions, and investigation findings into structured test case documents (TCNNN.md) that can be used for AI-assisted simulation and regression checking.

## When to Use

- A new JIRA ticket has defined ACs and sample data
- An investigation report has confirmed a bug with expected vs actual behavior
- You need to capture a scenario permanently for regression prevention

## Why Document-Based Test Cases?

| Aspect | Automated Tests (PHPUnit/Jest) | Document-Based (.md + AI Simulation) |
|---|---|---|
| Time to create | Can be slow for complex logic (mocking) | Fast (structured text from existing data) |
| Execution | Automated CI/CD | AI-assisted comparison |
| Readability | Code (developers only) | Plain language (anyone can verify) |
| Maintenance | Requires code changes | Edit a text file |
| Coverage | Tests abstracted/mocked behavior | Tests actual system output |
| Database | Needs test fixtures or mocks | Uses real environment data |
| Best for | Unit logic, API contracts | Complex pipelines, file output, SQL behavior |

Use document-based testing when automated tests can't easily cover the full logic path (complex SQL, multi-step batch pipelines, cross-system data flows).

## The Dual-AI Pattern

The original process used two AI tools with complementary strengths:

```
AI Tool 1 (batch generator — e.g., Gemini):
  - Processes large amounts of JIRA data efficiently
  - Produces structured output from raw text
  - Mass-generates test case files

AI Tool 2 (code-aware validator — e.g., Kiro):
  - Understands the codebase and logic
  - Knows what data format it needs for simulation
  - Validates generated test cases against actual output
  - Identifies gaps: "I need explicit end_date, order_no..."
```

The back-and-forth between generator and validator refines the format until both sides agree. The generator produces content the validator can actually use.

**You can also use a single AI** for both roles if it has access to both the JIRA data and the codebase. The key principle is: whoever generates the TC must understand what the validator needs.

## Prerequisites

- A JIRA ticket or investigation report with:
  - Clear expected behavior
  - Data identifiers (IDs, dates, values)
  - Enough context to derive expected output

## Decision: Can a TC Be Generated Now?

```
JIRA Ticket arrives
    │
    ├── Has clear ACs + expected values + real data?
    │       │
    │       YES → Generate TC directly (Step 2 below)
    │
    └── Only describes symptoms / current behavior / hypothesis?
            │
            Examples:
            - "CalculationSummary doesn't match Daily + Monthly"
            - "Some charges appear duplicated"
            - "Mismatch of ¥4.5M found, here's hypothesis"
            │
            NO → Cannot generate TC yet.
                 │
                 ▼
            Run investigation workflow first:
            1. Confirm root cause (not just hypothesis)
            2. Identify specific records affected
            3. Define what "correct" looks like for those records
            4. Write investigation report (Gate 1: factual?)
                 │
                 ▼
            Investigation complete → NOW generate TC from the report
```

**Rule:** A test case requires known-correct expected values. If the ticket only says "X is wrong" without defining what "right" looks like, you need an investigation first.

### What makes a ticket TC-ready vs investigation-required?

| TC-Ready (generate directly) | Investigation-Required (investigate first) |
|---|---|
| "Charge X should show expired=8, paid=10560" | "Total mismatch of ¥4.5M found between reports" |
| "Refund row must appear with paid_price=-7425" | "Some rows exist in Summary but not in Monthly" |
| Has specific charge_ids + expected column values | Has aggregated symptoms without per-record expectations |
| Root cause is known and fix is defined | Root cause is a hypothesis, needs confirmation |
| AC says "given X, expect Y" | AC says "investigate and fix" |
| "Function X only queries table A, should also query table B" | "Totals don't match, here's the delta, unknown why" |

### Grey area: tickets with known root cause but no specific test data

Some tickets identify the code problem clearly (e.g., "this function queries only table A, should also query B") but don't provide specific record IDs or expected values for a TC.

In this case:
1. The TC can be generated as a **structural assertion** rather than a per-record check
2. Example: "Sum of output file X must equal sum of source table A + source table B for the same filter conditions"
3. Or: wait until the fix is deployed, get actual output, then write an evidence-based TC with real numbers

Either approach is valid. The key is: you must be able to define "what does correct look like?" — even if it's a formula rather than specific values.

## The Process

### Step 1: Gather Input Data

From the JIRA ticket or investigation report, extract:
- Ticket ID and title
- The scenario description (what should happen vs what does happen)
- Preconditions (account data, plan types, dates, configurations)
- Specific identifiers (student IDs, charge IDs, order numbers — whatever the system uses)
- Expected output values (CSV rows, API responses, calculated amounts)
- Actual output (if documenting a bug)

### Step 2: Generate the Test Case

Feed the extracted data to an AI (Kiro, Gemini, etc.) with the generation prompt below. The AI produces a structured `.md` file.

### Step 3: Validate the Output

Before saving the test case:
- [ ] All identifiers match the source data
- [ ] Expected values are correct per business rules
- [ ] Preconditions are complete (could someone reproduce this?)
- [ ] Steps are clear and sequenced correctly
- [ ] Format matches the standard structure

### Step 4: Save and Number

- Scan existing `testcases/` directory to find the highest TC number
- Assign the next sequential number: `TCNNN.md` (e.g., if TC035 exists, next is TC036)
- Place in `testcases/` directory
- If revising an existing TC, create `TCNNN-A.md` (the override) — same number, `-A` suffix

---

## Generation Prompt

Use this prompt when feeding JIRA/investigation data to an AI for test case generation. Adapt the domain-specific terms to your project's context.

```
You are an expert QA Engineering Assistant and Technical Analyst. Your task is to process raw data, bug descriptions, and case summaries and convert them into highly structured, scannable test case documents.

For every issue or data set provided, format the output strictly using this structure:

# [JIRA-TICKET-ID]
Case Title — Clear, Actionable Technical Subtitle

[Story]
A concise, high-level summary of the bug, business requirement, or scenario. Explain what the system is doing vs. what it should be doing, emphasizing the impact on output correctness.

[Precondition]
Define the exact technical parameters required before testing can begin:
- Account/entity identifiers (use real IDs when available, placeholders when theoretical)
- Specific business rules or plan behaviors that affect this scenario
- Mathematical formulas or pricing variables (if applicable)
- Date ranges and relevant timeline
- Table format for multi-entity data when multiple records are involved

[Steps]
1. Numbered, precise step-by-step instructions to replicate the behavior or execute the operation.
2. Include explicit dates, target periods, and environment notes where available.

[Expected]
The precise expected output. Format as code blocks showing exact values. Include:
- File name or endpoint that produces this output
- Column headers matching actual system output
- Calculation notes inline (e.g., "¥990 × 3 = 2970")
- Annotations per row explaining why each value is correct

[Actual] (Include when documenting a known bug)
Show exactly how the system currently fails. Format identically to [Expected] for easy comparison.
Explicitly note what's wrong per row.

[Comparison] (Include when Expected and Actual differ)
A scannable table or list contrasting Expected vs Actual to highlight the failure point.
Format: column name, expected value, actual value.

[Root Cause] (Include when known)
Technical breakdown of why the gap exists — query logic, boundary conditions, or data flow issues.
Include code snippets if they clarify the problem.

[Acceptance Criteria]
Bullet-pointed concrete requirements the fix must pass:
- Edge-case guardrails
- Data integrity rules
- Calculation precision requirements
- What must NOT change (regression prevention)

Formatting Rules:
- Bold key identifiers and critical values for scannability
- Use clean vertical breaks and structured sections
- No walls of text — use bullets, tables, code blocks
- Include calculation notes inline where they aid understanding
- Use real production data when available for stronger validation
```

### Two Generation Modes

| Mode | When to use | Input | Output |
|---|---|---|---|
| **Theoretical** | New feature, no real data yet | JIRA ACs + business rules | TC with placeholder IDs, derived expected values |
| **Evidence-based** | Bug confirmed, real data available | Investigation report + DB queries | TC with real IDs, actual vs expected, root cause |

Theoretical TCs use placeholders: `[student_id]`, `[charge_id]`, `[order_no]`
Evidence-based TCs use real data: `student_id: 181524`, `charge_id: 2768091`

Both are valid. Evidence-based TCs are stronger for regression testing because they can be verified against actual system output.

---

## Adapting the Prompt for Your Project

The prompt above is generic. Customize based on your project type:

| Project Type | Adapt these parts |
|---|---|
| Batch/CSV system | "output" = CSV rows, "operation" = batch command, include column headers |
| REST API | "output" = JSON response, "operation" = API call, include status codes |
| GraphQL | "output" = query response, "operation" = mutation/query |
| Data pipeline | "output" = transformed records, "operation" = pipeline execution |

---

## Validation Checklist (After Generation)

- [ ] Ticket ID in header matches source
- [ ] Story accurately describes the scenario (not copy-paste from unrelated ticket)
- [ ] Precondition has ALL identifiers needed to locate/reproduce
- [ ] Steps are reproducible without additional context
- [ ] Expected values are mathematically correct (verify formulas)
- [ ] Actual section (if present) matches real system output
- [ ] Acceptance criteria are testable (not vague)
- [ ] No sensitive data that shouldn't be in version control

## Example Flow

```
JIRA Ticket (PROJ-301: Premature expiry)
    │
    │ Extract: charge_id, dates, expected behavior
    ▼
Feed to AI with generation prompt
    │
    │ AI produces structured .md
    ▼
Validate: dates correct? values match? format clean?
    │
    ▼
Save as TC035.md in testcases/
    │
    ▼
Run simulation: compare TC035 expected vs actual output
    │
    ├── PASS → scenario is covered
    └── FAIL → bug still exists, fix needed
```
