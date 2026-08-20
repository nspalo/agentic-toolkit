---
inclusion: auto
---

# Documentation Standards

## Document Info Block (Required)

Every project document MUST begin with a **Document Info** table immediately after the `# Title`. This is the standard metadata header for all documentation we produce.

### Format

```markdown
# [Document Title]

## Document Info

| | |
|---|---|
| **Document type** | [Type — see list below] |
| **Date** | YYYY-MM-DD (Created) · YYYY-MM-DD (Last updated) |
| **Author** | [Name, Role] |
| **Assisted by** | [AI tool name, e.g. Kiro — or omit row if N/A] |
| **Status** | [Draft / Active / Approved / Superseded / Historical] |
| **Audience** | [Who should read this] |
| **JIRA** | [PROJ-XXX](link) or N/A |
| **Supersedes** | [Document it replaces, if any] |
| **Superseded by** | [Document that replaced this, if any] |
```

### Rules

1. **Always present** — every new document gets this block. No exceptions for project docs.
2. **Position** — immediately after the `# Title`, before any `---` divider or content section.
3. **Required fields:** Document type, Date, Author, Status. Other fields are optional — include when relevant, omit when not.
4. **Assisted by** — include when AI meaningfully contributed to the document (code analysis, document generation, data verification, research synthesis). Omit for trivially human-written docs. The value should name the tool (e.g. "Kiro") and optionally describe the contribution scope (e.g. "Kiro (code analysis and document generation)").
5. **Date format:** Always show creation date. Add "· YYYY-MM-DD (description)" for significant updates.
6. **Status values:** `Draft` → `Active` → `Approved` → `Historical` or `Superseded`. Use `Historical` when content is retained for reference but no longer authoritative. Use `Superseded` when a newer document replaces it.
7. **Supersedes / Superseded by:** Use relative paths. Only include when a document explicitly replaces another.

### Document Types

| Type | Use for |
|---|---|
| Technical Design | Architecture, system design, implementation plans |
| Project Timeline | Schedules, Gantt charts, milestone tracking |
| Project Estimation | Effort estimates, timeline projections |
| ADR (Architecture Decision Record) | Individual architectural decisions |
| Investigation Report | Bug analysis, root cause investigation |
| Engineering Report | Technical analysis, proposals, recommendations |
| Knowledge Base Article | Lessons learned, reusable patterns |
| Team Guide | Onboarding, workflow documentation |
| POC Report | Proof of concept results |
| Research Summary | Upstream project analysis, external research |

### What Does NOT Get a Document Info Block

- **Spec-driven files** (`requirements.md`, `design.md`, `tasks.md`) — these have their own Kiro-managed structure
- **README files** — repo/directory overviews follow their own convention
- **Changelogs** — chronological format, no metadata table needed
- **project-context.md** — session-loading files have their own format
- **Steering files** (`.kiro/steering/*.md`) — these are rules, not documents

---

## Information Flow

When creating methodology, process, or reference documentation, follow this order:

```
What is it → How we do it → Does it work → Is it credible
```

## Section Order

| # | Section | Reader question answered |
|---|---|---|
| 1 | Summary / Overview | "What am I reading?" |
| 2 | The Concept | "What is it?" |
| 3 | How It Works | "How do I use it?" |
| 4 | Why It Works | "Why should I trust this?" |
| 5 | Strengths | "What are the benefits?" |
| 6 | Limitations | "What can go wrong?" |
| 7 | Conclusion | "What's the takeaway?" |
| 8 | Appendix: References | "Who else does this?" |

## Key Rules

- Practical before theoretical — reader understands the workflow before reading why it works
- Industry precedent goes last — validates the approach but isn't required to understand it
- Each section should stand alone — a reader who stops at section 3 has enough to execute
- Strengths and limitations before conclusion — reader forms judgment before summary
- Appendix is optional reading — external references support credibility, not comprehension

## Backing Principles

- **Inverted Pyramid** — present information in descending order of importance
- **Progressive Disclosure** — essentials first, details layered in as needed
- **Task-Based Documentation** — what the reader needs to DO comes before background theory
- **Divio System** — "how-to" (practical) is separate from "explanation" (theoretical)

## Scope

**Applies to:** All project documentation — timelines, technical designs, estimations, ADRs, reports, proposals, reference documentation, knowledge base articles, team guides

**Does NOT apply to:** spec-driven files (`requirements.md`, `design.md`, `tasks.md`), README files, changelogs, `project-context.md`, steering files, test cases, JIRA tickets

## Cross-References Within Documents

Use markdown anchor links for internal references:

```markdown
[See detailed analysis](#section-heading-as-anchor)
```

Anchor rules: lowercase, spaces → hyphens, remove special characters.
