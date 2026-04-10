---
name: sfspeckit-uat
description: "Generate and manage Business UAT scripts and sign-offs for developer stories. Run by the BPO or QA lead for business validation."
version: "1.1.0"
author: "Sumanth Yanamala"
license: "MIT"
---

# /sfspeckit-uat — Business UAT Generation

## Overview

This skill generates business-facing User Acceptance Testing (UAT) scripts from developer stories. It converts technical acceptance criteria into a business-language walkthrough for Business Process Owners (BPO) to verify and sign off.

## Who Runs This

**BPO (Business Process Owner)** or **QA Lead** — after a story has successfully passed technical verification (`/SFSpeckit-qa`).

## Input

Path to the story file:
```
/SFSpeckit-uat sfspeckit-data/specs/001-invoice-mgmt/task_story_01.md
```

## Prerequisites

- Story status is **QA** (technical verification passed)
- Story code is deployed to UAT Sandbox (if applicable) or QA Sandbox
- Constitution exists: `sfspeckit-data/memory/constitution.md`

## Steps

### Step 1: Read Story Context

1. Read the story file provided as input
2. Read the feature spec (`spec.md`) in the same directory
3. Extract:
   - User Stories (As a... I want to... So that...)
   - Acceptance Criteria (Given/When/Then)
   - Feature Context (Process flow, constraints)

### Step 2: Generate Business Walkthrough

Read `.agents/skills/SFSpeckit-uat/uat-script-template.md` and generate a script that translates technical ACs into business steps.

**Guidelines for Business Language:**
- **NO technical jargon**: Avoid "Apex", "Trigger", "SOQL", "LWC", "DML".
- **Action-Oriented**: Use "Log in as...", "Navigate to...", "Click...", "Verify that...".
- **Business Outcomes**: Focus on what the user sees and achieves, not how it happens.

### Step 3: Create UAT Script File

Save the generated script to:
`sfspeckit-data/specs/NNN-feature-name/uat_story_NN.md`

### Step 4: Present to BPO

Show the generated UAT script to the BPO. Highlight:
- The specific business process being tested
- The data needed for testing
- How to record Pass/Fail

### Step 5: Manage Sign-Off (Interactive)

If the BPO provides feedback or sign-off after executing the script:
1. Update the `uat_story_NN.md` file with the BPO's name, date, and verdict.
2. If verdict is **PASS**:
   - Update the story file (`task_story_NN.md`) status to **READY FOR PROD** or **DONE**.
3. If verdict is **FAIL**:
   - Record the observation in the story file
   - Set story status back to **IMPLEMENTING** (for rework)

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

## Error Handling

- **Story not ready**: If story status is not QA/REVIEW, warn the user that UAT might be premature.
- **Missing Spec**: If `spec.md` is missing, use the story ACs only but warn that context might be limited.

## Notes

- This skill focuses on the **BUSINESS** validation. For technical QA, use `/SFSpeckit-qa`.
- UAT should ideally be performed in a separate UAT Sandbox with production-like data.
