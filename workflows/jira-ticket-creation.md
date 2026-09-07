# JIRA Ticket Creation Workflow (via Atlassian MCP)

> Governs the **write** path into JIRA — creating epics, stories, tasks, and bugs through the `mcp-atlassian` MCP server. This is to JIRA what `pr-creation.md` is to git: a safe, gated sequence for writing to a shared system.
>
> For ticket **content**, use the templates in `templates/jira/` (epic, story, task, bug).
> For **consuming** an existing ticket, see `templates/prompts/process-jira-ticket.md`.
> For MCP connection setup/troubleshooting, see `knowledge/tooling-setup.md` → MCP Server Setup.

## When to Use

| Scenario | Use this workflow? |
|---|---|
| Create an epic / story / task / bug in JIRA | ✅ Yes |
| Link stories under an epic | ✅ Yes |
| Update status / transition a ticket | ✅ Yes (same safety gates) |
| Just reading tickets (search, view) | ❌ No — read-only calls need no gating |
| Writing the ticket body/spec | ❌ No — that's `templates/jira/*` |

## Safety Principle

Creating or modifying a JIRA ticket is a **write to a shared production system** — treat it like `git push`, not like editing a local file. Never create, update, transition, or delete a ticket without explicit human go-ahead. This mirrors `git-safety.md`: the AI drafts; the human authorizes the write.

## Prerequisites

1. **MCP connected.** Verify with a read-only call first — `jira_get_all_projects` (or `jira_search`). If it fails, fix the connection before anything else (`knowledge/tooling-setup.md`).
2. **Writes enabled.** The server runs read-only unless `READ_ONLY_MODE=false`. If it's `true`, creates/updates are blocked at the server level — flip it and reconnect. Confirm the boot log shows `Read-only mode: DISABLED`.
3. **Human authorization.** Confirm the human wants the ticket(s) created in the live project, with the summary/description/parent you're about to use.

## Flow

```
Precheck → Discover fields → Draft content → Create (dependency order) → Verify → Record → Re-secure
```

### 1. Precheck (read-only)

- Run `jira_get_all_projects` (or a scoped `jira_search`) to confirm the connection is live and the target project key is visible.
- Confirm `READ_ONLY_MODE=false` if you intend to write.

### 2. Discover create-fields (avoid failed creates)

Before creating, learn the project's requirements — configs differ per project (team-managed vs company-managed, custom required fields, Epic Name field, etc.):

- `jira_get_project_issue_types <PROJECT>` → get the issue type IDs.
- `jira_get_create_fields <PROJECT> <issue_type_id>` → see which fields are `required`.

Only create with fields you've confirmed exist. Do not assume an "Epic Name" custom field — modern team-managed projects often need only project + issuetype + summary, and link children via the `parent` field (not a classic epic-link).

### 3. Draft content

Use the matching template in `templates/jira/`:

| Type | Template |
|---|---|
| Epic | `templates/jira/epic.md` |
| Story | `templates/jira/story-ticket.md` |
| Task | `templates/jira/task-ticket.md` |
| Bug | `templates/jira/bug-ticket.md` |

Write the description in Markdown — the Atlassian MCP renders it into JIRA wiki markup server-side (headings, code, lists convert automatically).

### 4. Create in dependency order

Create parents before children so linking works in one pass:

1. **Epic first** — capture its key (e.g. `PROJ-9`).
2. **Stories/tasks next** — set the epic as `parent` at create time (`additional_fields: {"parent": "PROJ-9"}` for team-managed projects). Verify the create response shows the `parent` nested correctly.
3. **Sub-tasks last** — parent = the story/task key.

Create one at a time and confirm each before the next, unless the human explicitly asks for a batch.

### 5. Verify

For every created ticket, capture and report back the **key + browse URL**, and confirm parent linkage where applicable. Ask the human to eyeball it on the board.

### 6. Record

Log the created keys into the project's dev-context so the workspace stays the source of truth — e.g. a "JIRA Tickets Created" table in `projects/{name}/project-context.md` (key, type, parent, summary, date). This keeps a durable local record independent of JIRA.

### 7. Re-secure

If `READ_ONLY_MODE` was flipped to `false` for this session, flip it back to `true` (and reconnect) once ticket work is done — read-only is the safe default.

## Confirm Before Writing (checklist)

- [ ] Read-only precheck call succeeded (connection live)
- [ ] `READ_ONLY_MODE=false` confirmed (for writes)
- [ ] Create-fields checked for the target project + issue type
- [ ] Human authorized the specific ticket(s) — project, summary, description, parent
- [ ] Parents created before children

## Anti-Patterns

| Anti-Pattern | Why it fails | Do this instead |
|---|---|---|
| Creating tickets without human go-ahead | Writes to a shared system the human didn't authorize | Treat like `git push` — confirm first |
| Guessing required fields | Create fails or lands malformed | Query `jira_get_create_fields` first |
| Assuming an "Epic Name" field / classic epic-link | Team-managed projects link via `parent`; the create fails or the child isn't nested | Check issue types + create-fields; use `parent` |
| Leaving `READ_ONLY_MODE=false` after the session | Write tools stay one call away by default | Re-secure to `true` when done |
| Not recording created keys locally | Workspace loses track of what was created | Log keys into `project-context.md` |
| Batch-creating a whole hierarchy unprompted | Hard to review/undo on a live board | Create parent → verify → children, stepwise |

## Cross-Reference

| Document | What it covers |
|---|---|
| `knowledge/tooling-setup.md` → MCP Server Setup | Connecting/troubleshooting the Atlassian MCP (WSL launch, `--env-file`, read-only, reconnect) |
| `templates/jira/*.md` | Ticket body templates (epic, story, task, bug) |
| `templates/prompts/process-jira-ticket.md` | Consuming an existing ticket |
| `.kiro/steering/git-safety.md` | The same "AI drafts, human authorizes the write" principle for git |
