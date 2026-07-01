---
inclusion: auto
---

# Multi-Tenancy

## Tenants

| Tenant | Identifier | DB Connection | Notes |
|---|---|---|---|
| {{TENANT_1}} | {{ID_1}} | `{{CONNECTION_1}}` | {{NOTES_1}} |
| {{TENANT_2}} | {{ID_2}} | `{{CONNECTION_2}}` | {{NOTES_2}} |

## How Tenancy Works

{{TENANCY_MECHANISM — e.g., "Same code path, different DB connections" or "X-Service-Id header" or "config keys"}}

## Table-to-Connection Mapping

| Table | {{TENANT_1}} | {{TENANT_2}} | Notes |
|---|---|---|---|
| {{TABLE_1}} | {{T1_NAME}} | {{T2_NAME}} | {{NOTES}} |
| {{TABLE_2}} | {{T1_NAME}} | {{T2_NAME}} | {{NOTES}} |

⚠️ Document any naming inconsistencies between tenants here.

## N-Location Rule

Any fix that affects tenant-shared logic must be applied in **{{N}} locations**:
1. {{LOCATION_1}}
2. {{LOCATION_2}}
3. {{LOCATION_N}}

## Safety Rules

- Every fix must be checked against ALL tenants
- Verify table names from model/source — never pattern-match
- Test with all tenant contexts if code touches DB directly
- {{ADDITIONAL_SAFETY_RULE}}
