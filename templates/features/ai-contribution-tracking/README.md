# Feature: AI Contribution Tracking

## Status: Opt-In (Not Active by Default)

This is a self-contained feature module. It is NOT part of the default toolkit behavior. A human must explicitly decide to activate it for a project.

## What It Does

Tracks which work was AI-driven vs human-driven via:
- Git commit attribution (author + co-author trailers)
- PR labels (`kiro-generated`)
- GitHub Actions workflow that calculates and posts metrics on each PR

## When to Activate

- Team wants visibility into AI usage
- Company requires audit trail for AI-generated code
- Measuring AI ROI is a goal
- Compliance requires distinguishing human vs AI authorship

## How to Activate

1. **Add Makefile targets** — copy from `makefile-targets.md` into your project's Makefile
2. **Create the PR label** — `gh label create "kiro-generated" --description "PR generated via Kiro AI workflow" --color "7057ff"`
3. **Add GitHub workflow** — copy `kiro-metrics.yml` into your project's `.github/workflows/`
4. **Set git identity for AI** — ensure commits use the correct author when AI-driven

## What Changes When Active

| State | Commit behavior |
|---|---|
| **Inactive** (default) | `make commit` only. No co-author, no labels. All work attributed to human. |
| **Active** | Three attribution levels available (see below) |

## Attribution Levels

| Command | Author | Co-Author | When to use |
|---------|--------|-----------|-------------|
| `make commit` | Human | — | 100% human work |
| `make commit-kiro` | Kiro AI | — | AI wrote the code, human reviewed/approved |
| `make commit-assisted` | Human | Kiro AI | Human drove, AI helped (suggestions, completions) |

## Files in This Feature

| File | What to do with it |
|---|---|
| `makefile-targets.md` | Copy targets into your project's Makefile |
| `kiro-metrics.yml` | Copy to `.github/workflows/` in your project |
| `README.md` | This file — reference only |

## Metrics Collected

The GitHub Actions workflow posts a comment on each PR showing:
- Total PR lines
- Lines authored by AI (commits where author = "Kiro AI")
- Lines AI-assisted (commits with co-author trailer)
- Lines human-only (everything else)
