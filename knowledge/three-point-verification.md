# Three-Point Verification Methodology

## Summary

Validate correctness by checking agreement across three independent representations of the same truth. When all three agree, confidence is high. When any disagrees, the point of failure is identifiable.

## The Model

```
          Code Logic
         (business rules
          implemented)
            /        \
           /          \
   review /            \ produces
         /              \
        v                v
  Test Cases ←────────→ Actual Output
 (expected values       (system output)
  from business rules)
               matches?
```

| Point | What It Is | Source |
|---|---|---|
| Code Logic | The implementation (function, query, algorithm) | Source code |
| Test Cases | Expected output derived from business rules | Written from specs + real data |
| Actual Output | System output from execution | Run the code against real/test data |

## How It Works

1. **Code → Test Cases:** Review logic, determine what output SHOULD be for known inputs
2. **Code → Actual Output:** Execute the system, produce real output
3. **Test Cases → Actual Output:** Compare expected vs actual. Match = PASS, mismatch = FAIL

## Diagnosing Failures

| Symptom | Root Cause |
|---------|-----------|
| Test case PASS but output looks wrong to stakeholder | Test case has wrong expected values |
| Output matches test case but code review finds flaw | Flaw doesn't affect this specific case (or code was misread) |
| Logic looks correct but output doesn't match test case | Bug in execution, data issue, or environmental difference |

## Why It Works

Three independent representations with no shared computation path. A coincidental match across all three — where all are independently wrong but produce the same incorrect result — is statistically negligible.

Same principle as:
- Double-entry bookkeeping (two records must balance)
- Checksum verification (hash must match content)
- N-version programming (multiple implementations must agree)

## Applying to Different Project Types

| Project Type | Code Logic | Test Cases | Actual Output |
|---|---|---|---|
| Batch/CSV | SQL/PHP pipeline | Expected CSV values | Generated CSV files |
| REST API | Controller + service | Expected response body | API response |
| GraphQL | Resolver + service | Expected query result | GraphQL response |
| Data pipeline | Transform logic | Expected output records | Transformed data |

## Strengths

- No false confidence — passing means logic AND data AND output agree
- Precise failure location — tells you which leg broke
- Real data, not mocks — grounded in actual system behavior
- Incremental — each new bug becomes a permanent regression guard

## Limitations

- Only validates known scenarios — must continuously add test cases
- Relies on test environment accuracy
- Manual process (not CI/CD) — acceptable for low-frequency systems
- Cannot catch issues in untested paths — expand matrix over time
