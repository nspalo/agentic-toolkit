---
inclusion: auto
---

# Database Standards

## Schema Ownership

{{SCHEMA_OWNERSHIP_RULE}}

## This Project's Relationship to the Database

**READS from (never modify):**
- `{{TABLE_1}}` — {{PURPOSE}}
- `{{TABLE_2}}` — {{PURPOSE}}
- `{{TABLE_3}}` — {{PURPOSE}}

**WRITES to (this project owns):**
- `{{TABLE_4}}` — {{PURPOSE}}
- `{{TABLE_5}}` — {{PURPOSE}}

## Key Tables

| Table | Purpose | Connection |
|---|---|---|
| {{TABLE}} | {{PURPOSE}} | {{CONNECTION}} |

## Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Tables | {{TABLE_NAMING}} | {{EXAMPLE}} |
| Columns | {{COLUMN_NAMING}} | {{EXAMPLE}} |
| Foreign keys | {{FK_NAMING}} | {{EXAMPLE}} |
| Indexes | {{INDEX_NAMING}} | {{EXAMPLE}} |

## Migration Rules

- {{MIGRATION_RULE_1}}
- {{MIGRATION_RULE_2}}
- {{MIGRATION_RULE_3}}
- New columns on existing shared tables MUST be `nullable()`
- Always include `down()` method in migrations

## When You Need a DB Change

1. Check if the table/column already exists
2. Verify column names from migrations or models, not from memory
3. {{ADDITIONAL_STEP}}
