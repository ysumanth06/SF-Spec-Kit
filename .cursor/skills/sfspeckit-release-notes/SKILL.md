---
name: sfspeckit-release-notes
description: "Automatically aggregate a feature's completed stories, test results, and UAT sign-offs into a formal, business-ready Release Notes document."
version: "1.1.0"
author: "Sumanth Yanamala"
license: "MIT"
---

# /sfspeckit-release-notes — Generate Feature Release Summary

## Overview

This skill generates a professional Release Notes artifact by aggregating all data from a feature's completed `task_story_NN.md` files, `verify.md` evidence documents, and UAT sign-offs. It provides an executive summary of "What was built," "How it was tested," and "Release Stats."

## Who Runs This

**TPO** or **Release Manager** — after all stories are marked `DONE`.

## Input

Path to the feature spec:
```
/SFSpeckit-release-notes sfspeckit-data/specs/001-invoice-mgmt/spec.md
```

## Prerequisites

- All stories in the feature directory must be in the `DONE` or `QA` state.
- Documentation directory exists: `sfspeckit-data/specs/NNN-feature-name/test-logs/`

## Steps

### Step 1: Inventory Feature Assets

1. Read the feature directory `sfspeckit-data/specs/NNN-feature-name/`.
2. Collect:
   - All `task_story_NN.md` files.
   - All `test-logs/story-NN-verify.md` evidence files.
   - The original `spec.md` for context.
   - The implementation `plan.md` for scoring gate thresholds.

### Step 2: Aggregate Statistics

Calculate the cumulative stats for the release:
- **Total Stories**: X
- **Development Hours**: Total (from story estimation tables).
- **Test Coverage**: Weighted average across all classes/components.
- **Scoring Quality**: Average scores for Apex, LWC, and Metadata.

### Step 3: Extract Feature Highlights

Generate a bulleted list of functional changes by reading the "Summary" section of each story file.

### Step 4: Generate Release Notes Document

Create `sfspeckit-data/specs/NNN-feature-name/RELEASE_NOTES.md` using the following structure:

```markdown
# 🚀 Release Notes: $FEATURE_NAME (NNN)

**Release Date**: $DATE
**Lead Developer**: $LIST
**TPO Approval**: [ ]

## 1. Executive Summary
Brief summary of the feature's business impact (extracted from spec.md).

## 2. Functional Highlights (What's New)
- **$STORY_TITLE**: $STORY_DESCRIPTION
- ... (repeat for all DONE stories)

## 3. Quality & Assurance Snapshot
| Metric | Result | Target | Status |
|--------|--------|--------|--------|
| Unit Test Coverage | XX% | 75% | ✅ |
| Avg. Apex Quality | 142/150 | 90 | ✅ |
| Avg. LWC Quality | 158/165 | 125 | ✅ |
| Code Analyzer v5   | 0 Critical | 0      | ✅      |

## 4. Technical Inventory
### New Objects/Fields
- [List from Story-000]

### New/Modified Code
- [Class List]
- [LWC List]

## 5. Verification & Testing
Detailed links to all unit test evidence documents:
- [Story-01 Verification Evidence](file:///path/to/verify.md)
- [Story-02 Verification Evidence](file:///path/to/verify.md)

## 6. Known Issues / Deferred Items
(Extracted from plan.md "Out of Scope" or recorded manual notes).
```

### Step 5: Present to User

Show the location of the `RELEASE_NOTES.md` and suggest: "Release notes generated. Review and commit to the main branch before final deployment."

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
