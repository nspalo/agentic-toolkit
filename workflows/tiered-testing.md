# Tiered Testing Methodology

## Overview

Testing is organized in tiers of increasing scope. Each tier answers a different question. Start from the smallest scope and expand only as needed.

## Tiers

| Level | Scope | Question Answered | When to Use |
|---|---|---|---|
| **Smoke** | Single execution | "Does it run without crashing?" | After any code change |
| **Unit** | Single test/scenario | "Does the fix produce correct output for its own scenario?" | Quick validation of a specific change |
| **Functional** | Related tests | "Does the change break related scenarios sharing the same code path?" | Before marking a fix as ready |
| **Acceptance** | Full test suite | "Does the entire system still pass?" | Pre-deployment, regression check |

## How Tiers Map to Project Types

| Tier | Code-based testing (most projects) | Document-based testing (batch/file projects) |
|---|---|---|
| Smoke | Run app/command, check for errors | Run command, check logs |
| Unit | Run specific test file/method (PHPUnit, Jest) | Compare one test scenario `.md` against output |
| Functional | Run test suite for the affected module | Compare related test scenarios |
| Acceptance | Run full test suite (`vendor/bin/phpunit`, `npm test`) | Compare entire active scenario suite |

## Code-Based Testing (Standard)

For most projects (APIs, frontends, services), testing means running actual test code:

```bash
# Unit
vendor/bin/phpunit tests/Unit/ServiceNameTest.php
# or
npx jest src/components/Feature.test.ts

# Functional
vendor/bin/phpunit tests/Feature/
# or
npx jest --testPathPattern="feature-area"

# Acceptance
vendor/bin/phpunit
# or
npm test
```

Tests live in the **project repo** (not the dev-context). Follow the project's test conventions in its `.kiro/steering/`.

## Document-Based Testing (Batch/File Systems)

For projects where output is files (CSV, PDF, reports) and automated testing isn't feasible:

1. Read the test scenario `.md` file — find expected values
2. Compare against actual system output (file content)
3. Report PASS/FAIL with specific mismatches

Test scenarios live in the **dev-context** (`projects/{name}/testcases/TCNNN.md`).

Rules:
- When an override variant exists (e.g., `TCNNN-A.md`), use the override
- Skip non-override historical variants
- Report full PASS/FAIL scorecard

## Verification Methods (Project-Specific)

The method of comparing "expected vs actual" varies by project type:

| Project Type | Verification Approach | Where tests live |
|---|---|---|
| Backend API (REST/GraphQL) | PHPUnit/Jest feature tests | Project repo `tests/` |
| Frontend | Jest/Vitest component tests + Playwright E2E | Project repo `tests/` |
| Batch/CSV system | Markdown test scenarios vs file output | Dev-context `testcases/` |
| Data pipeline | Integration tests or snapshot comparison | Project repo or dev-context |

Each project defines its own verification approach in its `project-context.md` and `.kiro-draft/steering/testing.md`.

## Adding New Tests

When a new bug is found or feature is built:

**Code-based:** Write a test that fails before the fix and passes after. It lives in the project repo permanently.

**Document-based:** Derive expected values from business rules + real data. Write the test scenario. Validate against current output. It becomes a permanent regression guard.
