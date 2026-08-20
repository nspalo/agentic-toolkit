# [TICKET-ID] — [Short Description] (YYYYMMDD)

## Document Info

| | |
|---|---|
| **Document type** | Implementation Report |
| **Date** | {{YYYY-MM-DD}} (Implemented) |
| **Author** | {{Name, Role}} |
| **Assisted by** | {{Kiro / AI tool name, or omit if N/A}} |
| **Status** | {{Draft / Active / Approved}} |
| **Audience** | {{Dev team, QA, PM}} |
| **JIRA** | {{[PROJ-XXX](link)}} |

**Branch:** [Branch name]
**Related:** [Links to investigation reports, design docs, or prior analysis]

---

## Summary

[1-2 sentences: what was implemented and the business reason. State the approach chosen.]

---

## Background & Decision

[Why this approach was chosen over alternatives. Include the decision trail — who decided what, when. This section provides the audit trail for future readers who ask "why was it done this way?"]

| Date | Decision | By |
|------|----------|-----|
| YYYY-MM-DD | [Decision made] | [Person] |

[If options were evaluated, state which was selected and why. Reference the investigation/comparison report rather than duplicating it.]

---

## Change Description

### Files Modified

| # | File | Change |
|---|------|--------|
| 1 | `path/to/file` | [Brief description of change] |

### Files Created

| # | File | Purpose |
|---|------|---------|
| 1 | `path/to/file` | [Purpose] |

### Approach

[Concise description of the implementation approach — what the code does, the pattern used, and how it fits into the existing system. Keep to the "what" and "how", not the "why" (that's in Background & Decision).]

---

## Technical Detail

[The specific logic, formulas, queries, or algorithms that form the core of the change. Use code blocks. This section should be detailed enough that a reviewer can verify correctness without reading the full source.]

---

## Verification

> **Verification level:** [State which points of the verification model were completed]
> [If not all points were covered, state what remains and when it will be done.]

### Test Results

[Scorecard table or summary of test case simulation results. Include both the target test case (proves the fix works) and regression results (proves nothing else broke).]

| TC | Description | Result |
|:---|:---|:---:|
| TCXXX | [Target — fix validation] | ✅ PASS |
| TC001–TCXXX | [Regression — no output change] | ✅ PASS |

### Why No Regression Is Possible

[Brief explanation of why the change cannot affect unrelated scenarios. State the safety conditions that prevent false positives.]

---

## Impact Analysis

| Dimension | Assessment |
|-----------|-----------|
| Severity | [What the bug caused — e.g., double revenue recognition] |
| Scope | [Which tenants, environments, contract types affected] |
| Downstream | [Which systems consume the corrected output] |
| Data risk | [Can this lose data? Is it reversible?] |
| Deployment dependency | [Does anything else need to deploy first/alongside?] |

---

## Cross-Reference

- [Related investigation report]
- [Related design/comparison docs]
- [Test case file]
- [Code file paths with relevant functions]

---

## Template Notes (delete this section when using)

### When to Use

This template documents a **completed implementation** — code is written, tests pass, ready for review/deploy. Use it when:
- A fix went through investigation → options → stakeholder decision → implementation
- The change needs an audit trail (who decided, why, what was verified)
- Multiple people need to review or QA the change

Do NOT use for:
- Investigations (use `investigation-report.md`)
- Design proposals before implementation (use `engineering-report.md` or spec workflow)
- Simple one-line fixes that need no explanation

### Industry Alignment

This template draws from:
- **ITIL Change Record** — details, description, impact, implementation, review
- **ITIL Post-Implementation Review (PIR)** — objectives met, issues, verification
- **NASA SCR/PR (Software Change Request / Problem Report)** — problem, analysis, resolution, verification
- **IEEE 828 Configuration Status Accounting** — what changed, baseline before/after, verification status
- **RCA Bug Report pattern** — symptom, root cause, fix, verification, prevention

### Section Order Rationale

Follows progressive disclosure (most important first):
1. **Summary** — reader knows what happened in 10 seconds
2. **Background & Decision** — reader understands why in 30 seconds
3. **Change Description** — reviewer knows what to look at
4. **Technical Detail** — deep verification possible
5. **Verification** — proof of correctness
6. **Impact Analysis** — risk assessment for deployment decision
7. **Cross-Reference** — navigation to related artifacts
