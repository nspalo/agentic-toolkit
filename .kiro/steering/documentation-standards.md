---
inclusion: manual
---

# Documentation Standards

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

**Applies to:** methodology docs, process guides, design proposals, reference documentation, knowledge base articles

**Does NOT apply to:** investigation reports (own format), test cases (own format), JIRA tickets (JIRA conventions), changelogs (chronological)

## Cross-References Within Documents

Use markdown anchor links for internal references:

```markdown
[See detailed analysis](#section-heading-as-anchor)
```

Anchor rules: lowercase, spaces → hyphens, remove special characters.
