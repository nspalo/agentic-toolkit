---
inclusion: manual
---

# Batch Execution Flow

## Date / Period Logic

{{DESCRIBE_HOW_THE_BATCH_DETERMINES_WHAT_PERIOD_TO_PROCESS}}

| You pass | System processes |
|---|---|
| {{INPUT_1}} | {{PROCESSES_1}} |
| {{INPUT_2}} | {{PROCESSES_2}} |

## Command Sequence

```
Normal execution cycle:
─────────────────────

1. {{COMMAND_1}} → {{EFFECT_1}}
2. {{COMMAND_2}} → {{EFFECT_2}}
3. {{COMMAND_3}} → {{EFFECT_3}}
```

## Dependencies

| Command | Depends on | Must run AFTER |
|---|---|---|
| {{CMD}} | {{DEPENDENCY}} | {{PREDECESSOR}} |

## Re-Running / Recovery

{{DESCRIBE_HOW_TO_RE_RUN_A_PERIOD_SAFELY}}

```bash
# Recovery steps
{{STEP_1}}
{{STEP_2}}
```

## What Gets Generated

| Output | Source | When |
|---|---|---|
| {{OUTPUT_1}} | {{SOURCE}} | {{TRIGGER}} |
| {{OUTPUT_2}} | {{SOURCE}} | {{TRIGGER}} |
