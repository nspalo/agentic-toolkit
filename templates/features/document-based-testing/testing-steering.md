---
inclusion: manual
---

# Testing & Verification (Document-Based)

## Verification Method

{{DESCRIBE_HOW_CORRECTNESS_IS_VALIDATED — e.g., "Compare test case expected values against CSV output from batch run"}}

## How Simulation Works

1. Read the test case `.md` file — find expected values in [Expected] section
2. Get actual output — {{HOW — e.g., "search CSV in generated-files/ for matching ID"}}
3. Compare expected vs actual — column by column / field by field
4. Report PASS/FAIL with specific mismatches

**Important:** {{CONSTRAINTS — e.g., "We do NOT run SQL or connect to databases during simulations. All validation is file-based."}}

## Simulation Levels

| Level | Command | What it runs |
|---|---|---|
| **Smoke** | "Run smoke test" | {{SMOKE_DESCRIPTION}} |
| **Unit** | "Run test case simulation" | Only the specific TC for the change |
| **Functional** | "Run functional simulation" | Target TC + related TCs sharing same code path |
| **Acceptance** | "Run full simulation" | Entire active suite (use -A overrides, skip non-A) |

## Override Rule

When a `-A` variant exists (e.g., `TCNNN-A.md`):
- The `-A` is the **active** version
- The non-A is kept for historical reference, **skipped** during simulation
- Always use the `-A` version

## Smoke Test

```bash
{{SMOKE_TEST_COMMANDS}}
```

**Pass:** {{PASS_CRITERIA}}
**Fail:** {{FAIL_CRITERIA}}

## Adding New Test Cases

1. Derive expected values from business rules + real/test data
2. Write the test case using `TCNNN.md` format
3. Validate against current system output
4. The test case becomes a permanent regression guard
