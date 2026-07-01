# Feature: Document-Based Testing

## Status: Opt-In (Not Active by Default)

This is a self-contained feature module for projects where verification is done by comparing expected output (defined in markdown files) against actual system output (files, CSV, reports). It is NOT the default testing approach.

## When to Activate

Use this when:
- The system produces file output (CSV, PDF, reports) that can't be easily unit tested
- Complex SQL/CTE logic that's impractical to mock in PHPUnit
- The verification is "does row X in the output match expected values?"
- Batch/pipeline systems where the output IS the test artifact
- Automated test frameworks can't cover the full logic path

Do NOT use this when:
- Standard unit/feature tests are feasible (PHPUnit, Jest, Playwright)
- The project has a working test suite
- Verification can be done via API calls or assertions in code

## How It Works

```
Test Scenario (.md file)       Actual Output (system-generated)
├── [Expected] section    ←→   ├── CSV row / API response / file content
│   (what should happen)       │   (what actually happened)
│                              │
└── Compare: PASS or FAIL ─────┘
```

The AI reads the `.md` file's expected values, searches the actual output, and reports matches/mismatches.

## How to Activate

1. Add `testcases/` directory to your project in the dev-context
2. Copy `test-case-template.md` into your project's `.kiro-draft/steering/` as `testing.md` (customize the verification method)
3. Copy `naming-rules.md` content into your project's conventions
4. Define your project's verification method (what is "actual output" for your system?)

## Files in This Feature

| File | What to do with it |
|---|---|
| `test-case-template.md` | Template for individual test scenario files |
| `generate-test-cases.md` | Workflow: how to generate TCs from JIRA tickets using AI |
| `testing-steering.md` | Steering file to copy into project's `.kiro-draft/steering/testing.md` |
| `naming-rules.md` | Naming conventions specific to this feature |
| `README.md` | This file — reference only |

## Simulation Tiers (When Active)

| Level | Scope | What it runs |
|---|---|---|
| **Smoke** | Single execution | Run command/endpoint, check for errors |
| **Unit** | Single test scenario | Compare one TCNNN against output |
| **Functional** | Related scenarios | Compare target + related TCs sharing same code path |
| **Acceptance** | Full suite | Compare all active TCs (use -A overrides, skip non-A) |

## Override Rule

When a revised version exists:
- `TCNNN-A.md` = **active** version (use this)
- `TCNNN.md` = **historical** (skip during simulation)
