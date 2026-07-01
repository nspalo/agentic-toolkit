---
inclusion: auto
---

# Architecture Overview

## System Type

{{SYSTEM_TYPE — e.g., "Distributed multi-repository platform", "Monolith", "Microservices", "Batch processing system"}}

## High-Level Architecture

```
{{ARCHITECTURE_DIAGRAM — text/mermaid/ascii}}
```

## Services / Components

| Service | Responsibility | Tech | Communication |
|---|---|---|---|
| {{SERVICE_1}} | {{RESPONSIBILITY}} | {{TECH}} | {{COMM_METHOD}} |
| {{SERVICE_2}} | {{RESPONSIBILITY}} | {{TECH}} | {{COMM_METHOD}} |
| {{SERVICE_3}} | {{RESPONSIBILITY}} | {{TECH}} | {{COMM_METHOD}} |

## Data Flow

```
{{DATA_FLOW — how data moves between components}}
```

## Service Boundaries

| If you need to... | Do it in... | NOT in... |
|---|---|---|
| {{ACTION_1}} | {{CORRECT_PLACE}} | {{WRONG_PLACE}} |
| {{ACTION_2}} | {{CORRECT_PLACE}} | {{WRONG_PLACE}} |
| {{ACTION_3}} | {{CORRECT_PLACE}} | {{WRONG_PLACE}} |

## Shared Resources

| Resource | Shared by | Rules |
|---|---|---|
| {{RESOURCE_1}} | {{SERVICES}} | {{RULES}} |
| {{RESOURCE_2}} | {{SERVICES}} | {{RULES}} |

## Deployment

- **Infrastructure:** {{INFRA — e.g., AWS ECS, Kubernetes, bare metal}}
- **CI/CD:** {{CI_CD — e.g., CodeBuild, GitHub Actions, Jenkins}}
- **Strategy:** {{STRATEGY — e.g., Blue/Green, Rolling, Canary}}
- **Environments:** {{ENVS — e.g., dev → staging → production}}
