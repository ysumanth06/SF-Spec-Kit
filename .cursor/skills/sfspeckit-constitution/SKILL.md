---
name: sfspeckit-constitution
description: "Establish Salesforce project principles. Creates the project constitution with 9 Salesforce-specific articles. Run once per project by the TPO."
---

# /sfspeckit-constitution — Establish Project Principles

## Overview

This skill creates the project constitution — the immutable principles governing all Salesforce development. Run this **once per project** before any feature work begins. The constitution is referenced by every subsequent SFSpeckit skill.

## Who Runs This

**TPO** (Technical Product Owner) — ideally with Architect input.

## Prerequisites

- Salesforce DX project initialized (`sfdx-project.json` exists)
- `sfspeckit-data/` directory exists (created automatically)

## Steps

### Step 1: Read the Constitution Template

Read the constitution template from `sfspeckit-data/templates/constitution-template.md`. This contains 9 Salesforce-specific articles:

1. **Article I: Metadata-First** — Features start with object/field definitions
2. **Article II: Governor-Limit Awareness** — Bulkification, 251-record testing
3. **Article III: Declarative-First** — Flow before Apex decision mandate
4. **Article IV: Security-by-Default** — `with sharing`, `WITH USER_MODE`, no hardcoded IDs
5. **Article V: PNB Test-First** — Positive/Negative/Bulk pattern, Test Data Factory
6. **Article VI: Separation of Concerns** — TAF, Service/Selector/Domain layers
7. **Article VII: Deployment Safety** — Dry-run first, deploy order, Permission Sets
8. **Article VIII: Agent Architecture** — Topic/action patterns, deactivate-before-modify
9. **Article IX: Cross-Skill Orchestration** — Skill dependency ordering, scoring gates

### Step 2: Check for Existing Constitution

Check if `sfspeckit-data/memory/constitution.md` already exists.
- If yes: ask the user if they want to update or replace it.
- If no: proceed with creation.

### Step 2.5: Environmental Discovery (CLI-Driven)

**CRITICAL: Align principles with reality.** Inform the user: "> [!WARNING] Starting Environmental Discovery. Large orgs may take 1-2 minutes to scan."

1. **Run Discovery Commands**:
   ```bash
   sf package installed list --json
   sf org list metadata --metadata-type NamedCredential --json
   sf org list metadata --metadata-type ExternalService --json
   sf org list metadata --metadata-type ApexClass --json
   sf org list metadata --metadata-type Flow --json
   sf org display --json
   ```
2. **Analyze Results**:
   - **Packages**: Identify key frameworks (fflib, TAF) or industry clouds (CPQ, FSC).
   - **Integrations**: Map modern (External Service) vs. legacy endpoints.
   - **Maturity (Article III)**: Calculate ratio of Active Flows vs. Apex Classes. If Flows > Apex, set "Flow-centric" posture. If Apex > Flows, set "Technical Debt reduction" posture.
   - **Org Limits**: Check AI/Agent limits if Agentforce is in scope.

### Step 3: Gather Project-Specific Context

Ask the user the following contextual questions to customize the constitution:

1. **Project name**: What is this project called?
2. **Team size**: How many developers will work on this project?
3. **Org type**: Production, Sandbox, or Scratch Org development?
4. **Installed packages**: [PRESENT DISCOVERED LIST] Are there any other packages or frameworks to account for?
5. **Integration Landscape**: [PRESENT DISCOVERED ENDPOINTS] Any internal/external systems missing from this list?
6. **Maturity Assessment**: [PRESENT FLOW VS APEX RATIO] Should Article III be strengthened to prioritize Flow for new work?
7. **Custom additions**: Any project-specific principles to add?
8. **Article overrides**: Any articles to relax or strengthen?
9. **Scoring thresholds**: Accept default scoring gates or customize?

### Step 4: Generate the Constitution

Using the template and the user's answers:

1. Copy `sfspeckit-data/templates/constitution-template.md` to `sfspeckit-data/memory/constitution.md`
2. Replace `$PROJECT_NAME` with the project name
3. Replace `$DATE` with today's date
4. Replace `$AUTHOR` with the user's name or "TPO"
5. Apply any article overrides or additions from Step 3
6. Update scoring thresholds if customized

### Step 5: Confirm with the User

Present the generated constitution to the user for review. Highlight:
- Any articles that were customized
- Any custom additions
- Scoring gate thresholds

Ask: "Does this constitution look correct? Any changes needed?"

### Step 6: Finalize

Once confirmed:
- Save `sfspeckit-data/memory/constitution.md`
- Inform the user: "Constitution established. All SFSpeckit skills will reference this document."
- Suggest next step: "Run `/SFSpeckit-specify <feature description>` to create your first specification."

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

## Notes

- The constitution is referenced by ALL other SFSpeckit skills
- It should rarely change — use the Amendment Process (documented in the constitution) for modifications
- The constitution is GUIDED (recommended with exception paths), not absolute
