# TCNNN [Short Name]

**JIRA:** [PROJ-XXX]
**Feature/Bug:** [Brief description of what this validates]
**Type:** batch | api | graphql | pipeline

---

## Story

[What scenario this validates — written in plain language]

---

## Precondition

[Setup state required — data that must exist, configuration, user state]

---

## Steps

1. [Action to execute]
2. [Next action]
3. [Check output]

---

## Expected

[What correct output looks like — format varies by project type]

### For batch/CSV:
```
column1,column2,column3,...
value1,value2,value3,...
```

### For API response:
```json
{
  "status": 200,
  "body": { }
}
```

---

## Verification Method

[How to check — specific to this project's approach]

Example: "Search for charge_id X in the CSV file at generated-files/filename.csv. Compare columns against expected values above."

---

## Notes

[Optional — edge cases, related test cases, override history]
