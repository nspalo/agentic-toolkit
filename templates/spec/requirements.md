<!--
  Kiro spec requirements.md skeleton.

  This is the format the Kiro spec UI validator enforces before it unlocks
  "Continue to Design". Copy this skeleton when promoting an approved
  requirements doc into a repo's .kiro/specs/{feature}/ folder, then fill it in.

  Validator rules (do NOT remove/rename these headings):
    - H1 MUST be exactly "# Requirements Document" (the human/spec name goes in
      the bold line below it, or in a Document Info table — NOT in the H1).
    - There MUST be a top-level "## Requirements" section, with each requirement
      as "### Requirement N: ..." and a "#### Acceptance Criteria" list.
    - There SHOULD be a top-level "## Glossary" section (recommended — a missing
      one is a warning, not a hard block).

  A dev-context / Confluence draft usually uses a descriptive H1, a nested
  "### Glossary", and top-level "## Requirement N" headings — all of which the
  validator REJECTS. Convert to this format on promotion; don't copy the draft
  verbatim. Delete this comment block in the promoted file if you prefer.

  Extra top-level "## ..." sections (Document Info, Dependencies, Out of scope,
  Correctness properties, References, etc.) are fine before or after the
  required ones — they don't trip the validator.
-->

# Requirements Document

**{Spec Name}**

## Introduction

{What this spec delivers. State the scope boundary and any cross-repo / merge-order dependency. Behavior only — defer architecture, naming conventions, and correctness-property definitions to design.md.}

### Out of scope

- {Thing this spec explicitly does NOT cover}

## Glossary

- **{Term}:** {definition}

## Requirements

### Requirement 1: {short title}

**User Story:** As a {role}, I want {capability}, so that {benefit}.

#### Acceptance Criteria

1. WHEN {trigger} THE {system} SHALL {response}.
2. IF {unwanted condition} THEN THE {system} SHALL {response}.
3. WHERE {optional feature} THE {system} SHALL {behavior}.

### Requirement 2: {short title}

**User Story:** As a {role}, I want {capability}, so that {benefit}.

#### Acceptance Criteria

1. THE {system} SHALL {always-true behavior}.
