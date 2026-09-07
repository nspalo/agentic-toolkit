---
inclusion: manual
---

# Response Style — Workflow Formats

Task-specific output formats, grouped by phase (most-used first). Pull this file when doing the matching task. Core rules live in `response-style.md` (auto).

---

## Build & Debug (daily)

### Error Debugging (Stack Traces & Exceptions)

- **Root Cause First:** Sentence 1 identifies the exact file, line, or logic failure.
- **The Fix Snippet:** Show a Diff or Before/After code snippet immediately below sentence 1.
- **No Stack Trace Recitations:** Do not repeat the trace back to the user.

### Live Bug Fixes (Logic Bugs & Incidents)

- **Root Cause & Mechanism First:** Sentence 1 names the logic flaw, race condition, or state issue.
- **Diff / Code Fix First:** Show BEFORE (Buggy) vs. AFTER (Fixed) code block immediately below sentence 1.
- **Concurrency & State Safeguard:** Include a 1-bullet defensive rule covering locks, transactions, or state reset.

### Legacy Code Refactoring

- **Behavior-Preserving Verdict:** Sentence 1 states the modernization gain.
- **Side-by-Side Snippet:** Show Legacy vs. Modernized snippet.
- **Benefits Table:** Output a 2-column table (`Modern Pattern` | `Readability / Safety Gain`).

---

## Design & Plan (per feature)

### Requirements Gathering & Code Research

- **Tech-Spec First:** 2-line summary linking the business goal directly to tech components.
- **Schema Translation:** Render requirements as DB models, DTOs, or API contracts first.
- **Dependency Table:** Map unstated dependencies using a `Requirement` vs `Hidden Dependency` table.

### Feature Feasibility & New Feature Evaluation

- **Feasibility Verdict:** Sentence 1 MUST state feasibility directly.
- **Integration Touchpoints:** List affected files, components, or DB schemas in 3 bullets max.
- **Feasibility Matrix:** Output a 2-column table (`Evaluation Axis` | `Impact / Detail`) covering Breaking Changes, Complexity, and Architectural Fit.

### API Specifications

- **Endpoint Banner:** Lead with `[HTTP METHOD] /path/to/endpoint` in bold.
- **Minimal Payload:** Show raw JSON or DTO schema with required fields only.
- **Status Table:** Use a 3-column table (`Status Code` | `Trigger` | `Response Body`).

### Proof of Concept (PoC) & Prototyping

- **Scaffold First:** Provide the single, copy-pasteable MVP file or code block at the top.
- **Zero Production Polish:** Omit error handling, edge cases, and logging to keep code minimal.
- **3-Bullet Validation Plan:** Cover `What It Proves`, `What Is Omitted`, and `Next Step`.

---

## Communicate (ad-hoc)

### Live Meetings & Quick Insights (Pings / In-Meeting)

- **Verbal TL;DR:** Sentence 1 MUST be a non-technical summary suitable to say aloud in a meeting.
- **3-Bullet Pitch:** Output ONLY `Cost/Effort`, `Main Risk`, and `Recommended Path`.
- **No Code Blocks:** Omit code snippets unless requested; stick to architectural trade-offs.
