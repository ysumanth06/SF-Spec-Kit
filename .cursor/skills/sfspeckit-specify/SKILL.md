---
name: sfspeckit-specify
description: "Create a Salesforce functional specification for a new feature. Generates a numbered spec with user stories, platform context, automation decisions, and security model. Run by the TPO."
---

# /sfspeckit-specify — Create Feature Specification

## Overview

This skill creates a functional specification for a new Salesforce feature. It generates a numbered spec directory with a feature branch, populating the spec from the Salesforce-specific template.

## Who Runs This

**TPO** (Technical Product Owner)

## Input

The user provides a feature description as arguments:
```
/SFSpeckit-specify Build an invoice management system for the Sales team
```

## Prerequisites

- Constitution exists: `sfspeckit-data/memory/constitution.md` (run `/SFSpeckit-constitution` first)
- Git repository initialized
- `sfdx-project.json` exists in project root

## Steps

### Step 1: Read Context

1. Read the constitution from `sfspeckit-data/memory/constitution.md`
2. Read `sfdx-project.json` to extract:
   - `sourceApiVersion` → API version
   - `packageDirectories[0].path` → source path
   - `name` → project name
3. Scan `force-app/main/default/objects/` to understand existing custom objects
4. Scan `sfspeckit-data/specs/` to determine next feature number

### Step 2: Create Feature Branch & Directory

Run the branch creation script or perform equivalent:
1. Determine next feature number (scan existing dirs in `sfspeckit-data/specs/`)
2. Create slug from feature description (lowercase, hyphens)
3. Create directory: `sfspeckit-data/specs/NNN-feature-slug/`
4. Create git branch: `feature/NNN-feature-slug`
   - If branch creation fails (not on main, uncommitted changes), warn but continue

### Step 3: Read Template

Read `sfspeckit-data/templates/spec-template.md` — this is the structure to follow.

### Step 4: Gather Requirements

Have a conversation with the user to understand the feature. Focus on:

1. **User stories**: Who uses this feature? What do they need to accomplish? Break into P1/P2/P3 priorities.
2. **Acceptance scenarios**: For each user story, define Given/When/Then scenarios.
3. **Salesforce Platform Context**: Target org type, clouds, editions, packages.
4. **Automation Approach**: For each behavior, determine if Flow or Apex is appropriate (reference Article III).
5. **Object Map**: What standard/custom objects are involved? Relationships?
6. **Data Volume**: Expected record counts, bulk scenarios.
7. **Security Model**: OWD settings, FLS approach, sharing rules.

### Step 5: Generate the Specification

Create `sfspeckit-data/specs/NNN-feature-slug/spec.md` by:

1. Populating the spec template with gathered requirements
2. Auto-filling:
   - `$FEATURE_NAME` = feature description
   - `$FEATURE_NUMBER` = next number (e.g., 001)
   - `$FEATURE_SLUG` = slugified description
   - `$API_VERSION` = from sfdx-project.json
   - `$DATE` = today
3. Writing user stories in P1→P2→P3 priority order
4. Marking any unclear items with `[NEEDS CLARIFICATION: specific question]`
5. Populating the Automation Approach Decision table
6. Listing functional and non-functional requirements

### Step 6: Identify Clarification Needs

Review the generated spec for:
- Any assumptions made (document in Assumptions section)
- Any ambiguous requirements (mark with `[NEEDS CLARIFICATION]`)
- Any missing information (add to Clarification Status table)

### Step 7: Present to User

Show the generated spec to the user. Highlight:
- Number of user stories created
- Any items marked `[NEEDS CLARIFICATION]`
- Automation approach decisions made

Suggest next steps:
- **Requirement Audit**: "Run `/SFSpeckit-clarify` to execute the 10-point Salesforce gap analysis and ensure the specification is complete."
- **Technical Design**: "Once the spec is clarified, run `/SFSpeckit-plan` to create the technical implementation plan."

## Output

- Updated Metadata: [list affected files]
- Evidence Document: [path to evidence]
- Status Update: [final state]

## Verification Evidence

1. **Spectrum Engine Log**: ./SFSpeckit/bin/sfspeckit [cmd]
2. **Evidence File**: Traceability maintained in sfspeckit-data/

## Error Handling

- **Prerequisite Missing**: STOP and inform the user of the missing context.
- **CLI Failure**: Report the specific Spectrum Engine error code.

## Cross-Referenced Skills

- **sf-docs**: For looking up Salesforce documentation on specific features
- **sf-diagram-mermaid**: For generating ERD diagrams of the object map
