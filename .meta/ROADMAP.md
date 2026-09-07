# Agentic Toolkit — Roadmap

> Living document. All sessions read this at start to know where things stand.
> Update as phases complete.

## Phase 1: Plan ✅
- [x] Vision defined
- [x] Original plan written
- [x] Team structure and workflow transition mapped
- [x] Industry research (agentic SDLC patterns)

## Phase 2: Build ✅
- [x] Toolkit repo created (personal)
- [x] Workspace repo created (company)
- [x] Content structured and organized
- [x] Steering files (6 auto/manual)
- [x] Workflows (8)
- [x] Templates (bootstrap, steering, docs, jira, prompts, hooks, skills, automation)
- [x] Knowledge base (5 articles)
- [x] Bootstrap scripts (workspace + project)
- [x] Opt-in features (document-based-testing, ai-contribution-tracking)
- [x] Unit, integration, functional testing — all passing
- [x] Handshake + acknowledgment complete

## Phase 3: Validate (CURRENT)
- [x] Pilot: new workspace, new project, full spec-driven development cycle
- [x] Validate: AI follows auto-loaded steering without manual reminders
- [x] Validate: spec workflow produces working code (requirements → design → tasks → code)
- [ ] Validate: git workflow works (make branch/commit-kiro/pr)
- [ ] Validate: contribution tracking (author/co-author attribution works correctly)
- [x] Validate: bootstrap creates usable workspace + project in one command
- [x] Write: pilot results to `.meta/validation/pilot-results.md`

## Phase 4: Refine
- [ ] Fix issues found during pilot
- [x] Extract learnings back into toolkit (`extract-to-toolkit.md` workflow) — see extractions below
  - Review-gate staging (draft spec in dev-context → promote to `.kiro/specs/` after external sign-off) → `workflows/spec-driven-development.md`
  - Requirements-vs-design content split; correctness properties live in design.md → `workflows/spec-driven-development.md`
  - Match the target repo's existing spec convention (folder naming, migration-spec granularity, one-spec-per-repo for multi-repo features) → `workflows/spec-driven-development.md`
  - `#[[file:]]` vs plain-path references + cross-repo path-resolution (draft→promote) gotcha → `knowledge/kiro-steering-patterns.md`
  - MCP server setup + the launcher-PATH ("Connection closed") gotcha + token security → `knowledge/tooling-setup.md`
- [ ] Update steering/workflows based on real usage — ongoing
- [ ] Remove/simplify anything that didn't add value
  - **Candidate:** `.meta/handshakes/` ceremony appears unused in continuous single-session work. Evaluate whether it earns its complexity or should be simplified.
- [ ] Spec Planning Board feature — backlog splitting, tracking, and ordering in dev-context
  - `projects/{name}/backlog/` holds split requirement groups
  - `projects/{name}/spec-plan.md` tracks order, dependencies, status
  - Provides clear scope for each Kiro spec session without manual prompting
  - Solves "what do I tell Kiro?" problem for multi-spec projects
  - Should also express: per-repo specs for a multi-repo feature, cross-spec dependencies (merge order), and sign-off/gate status per spec
- [ ] Add `product.md` as default steering file in toolkit templates
  - Always-included steering that gives AI persistent product awareness
  - Contains: product description, key domains, implementation plan, what's done/next
  - Filled by AI during `steering-generate` or `project-link` (reads README, existing specs, codebase structure)
  - Replaces need to repeat product context in every spec prompt
  - Template example based on MBTI Backend and BETA pilot patterns

## Phase 5: Scale
- [x] Use on a real project (not just demo) — the toolkit has been exercised end-to-end on a live multi-repo feature: project steering adapted, spec-driven requirements split across repos and taken through an external sign-off gate, code investigation, and MCP setup. Real usage ran ahead of the Phase 3/4 checklist; learnings extracted into the toolkit (see Phase 4).
- [ ] Onboard another person using the toolkit
- [ ] Document: what changed in process, what worked, what didn't
- [ ] Add `.env` support for local paths (shared workspace portability)
  - `.env` (gitignored) holds per-dev paths: `BETA_REPO_PATH=/home/user/...`
  - Scripts read from `.env` instead of hardcoded `.repo-path`
  - `project-context.md` references env vars or relative paths
  - Enables shared dev-context (domain-knowledge, test cases) without path conflicts

## Phase 6: Publish
- [ ] Genericize fully (audit for any remaining specific traces)
- [ ] Write README for public audience
- [ ] Write case study (blog / LinkedIn article)
- [ ] Publish on GitHub (public repo)
- [ ] Consider: Kiro Power packaging

---

## Decision Log

| Date | Decision | Reason |
|------|----------|--------|
| 2026-06-30 | Toolkit on personal git, workspace on company git | Portable vs company-scoped separation |
| 2026-06-30 | Steering in `.kiro/steering/` not standalone dir | Kiro only reads from `.kiro/steering/` |
| 2026-06-30 | Auto vs manual steering inclusion | Universal safety rules auto-load; format/process on demand |
| 2026-06-30 | Co-author + author approach for AI attribution | Commit-level tracking more accurate than PR-level labels |
| 2026-06-30 | `.meta/` for toolkit project management | Toolkit is in all workspaces — shared comms channel |
| 2026-06-30 | Original plan archived | Implementation superseded it |
| 2026-07-02 | No company names/references in toolkit | Toolkit must be fully generic and portable |
| 2026-07-02 | Metrics are optional, not mandatory in roadmap | Time-to-deliver is hard to compute; contribution tracking needs author/co-author discipline only |
| 2026-07-05 | Steering scaffold is opt-in, not auto-created | BETA pilot showed auto-scaffolded templates went unused — user writes steering from understanding, not from filling blanks |
| 2026-07-05 | Command naming: resource-action pattern | `project-new`, `project-link`, `steering-generate` — groups logically in help output |
| 2026-07-05 | `repo=` not needed for steering commands | `.repo-path` stores the linked repo path; downstream commands read it automatically |
| 2026-07-05 | Local paths in `.repo-path` are fine for now | Dev-context is personal; `.env` support deferred to Phase 5 when sharing/onboarding happens |
| 2026-09-04 | Toolkit validated on a real multi-repo feature | Real usage exercised the toolkit beyond the demo; learnings extracted while fresh |
| 2026-09-04 | Specs follow the target repo's existing convention, not a generic one | Repos have their own spec-folder naming and (for migrations) per-column requirements granularity; imposing a generic format caused rework |
| 2026-09-04 | Large reference docs are linked by plain path, not `#[[file:]]` | Auto-injecting big design/schema docs bloats every session; the AI can read them on demand |
| 2026-09-04 | MCP `command` uses an absolute binary path | Kiro's launcher does not source the user shell profile; a bare command name fails to start. Documented in tooling-setup |
