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
- [ ] Pilot: new workspace, new project, full spec-driven development cycle
- [ ] Validate: AI follows auto-loaded steering without manual reminders
- [ ] Validate: spec workflow produces working code (requirements → design → tasks → code)
- [ ] Validate: git workflow works (make branch/commit-kiro/pr)
- [ ] Validate: contribution tracking (author/co-author attribution works correctly)
- [ ] Validate: bootstrap creates usable workspace + project in one command
- [ ] Write: pilot results to `.meta/validation/pilot-results.md`

## Phase 4: Refine
- [ ] Fix issues found during pilot
- [ ] Extract learnings back into toolkit (`extract-to-toolkit.md` workflow)
- [ ] Update steering/workflows based on real usage
- [ ] Remove/simplify anything that didn't add value

## Phase 5: Scale
- [ ] Use on a real project (not just demo)
- [ ] Onboard another person using the toolkit
- [ ] Document: what changed in process, what worked, what didn't

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
