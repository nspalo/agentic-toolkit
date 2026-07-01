---
inclusion: auto
---

# API Standards

## API Type

{{API_TYPE — e.g., GraphQL (Lighthouse), REST, gRPC}}

## Schema / Endpoint Conventions

### Naming

| Element | Convention | Example |
|---|---|---|
| Query fields | {{QUERY_NAMING}} | {{EXAMPLE}} |
| Mutations | {{MUTATION_NAMING}} | {{EXAMPLE}} |
| Types | {{TYPE_NAMING}} | {{EXAMPLE}} |
| Inputs | {{INPUT_NAMING}} | {{EXAMPLE}} |
| Enums | {{ENUM_NAMING}} | {{EXAMPLE}} |

### File Organization

```
{{SCHEMA_FILE_STRUCTURE}}
```

## Authentication

| Endpoint Type | Auth Required | Mechanism |
|---|---|---|
| {{TYPE_1}} | {{YES/NO}} | {{MECHANISM}} |
| {{TYPE_2}} | {{YES/NO}} | {{MECHANISM}} |

## Error Handling

```{{LANGUAGE}}
// Standard error response format
{{ERROR_FORMAT}}
```

## Validation

{{VALIDATION_APPROACH — e.g., "@rules directive", "Form Requests", "middleware"}}

## Versioning / Deprecation

- {{VERSIONING_RULE_1}}
- {{DEPRECATION_RULE}}
- New fields must be nullable by default
- Never remove existing fields without deprecation period
