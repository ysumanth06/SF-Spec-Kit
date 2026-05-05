---
name: sfspeckit-analyze
description: "Pre-implementation analysis for developers. Identifies mother story context, component lineage from previous stories, and performs deep drift analysis against the target Salesforce org."
version: "1.0.0"
author: "Sumanth Yanamala"
license: "MIT"
---

# /sfspeckit-analyze — Pre-Implementation Analysis

## Overview

This skill is run by the Developer *before* starting implementation (`/sfspeckit-implement`). It analyzes the current feature's story lineage, maps components that will be touched, and performs a Deep Drift Analysis against the target Salesforce org to detect manual changes before development begins.

## Who Runs This

**Developer** — immediately before starting work on a new story.

## Input

Path to the story file:
```
/SFSpeckit-analyze sfspeckit-data/specs/001-invoice-mgmt/task_story_01.md
```

## Prerequisites

- Target org authenticated (`sf org login web --alias dev`)

## Steps

### Step 1: Mother Story & Lineage Check

1. Read the feature's `plan.md` and the provided story file.
2. Determine if this is the "Mother Story" (the first story in the feature, e.g., Story-000).
   - If YES: Note that no previous components exist for this feature.
   - If NO: Identify all prior completed stories in this feature. List the exact Salesforce components (Apex, Objects, LWCs) they created or modified.

### Step 2: Current Story Impact Assessment

1. Extract the components targeted by the *current* story (from the SF Implementation Layers table in the story file).
2. Compare them against the components listed in Step 1 to identify shared dependencies.

### Step 3: Deep Drift Analysis (CLI-Driven)

Check if any components within the story scope have been modified directly in the Salesforce org, bypassing source control.

1. **Target High-Risk Metadata**: Pay specific attention to:
   - Page Layouts (`Layout`)
   - Lightning Record Pages (`FlexiPage`)
   - Permission Sets (`PermissionSet`)
   - Apex Classes/Triggers (`ApexClass`, `ApexTrigger`)
   - Validation Rules (`ValidationRule`)
   - Custom Fields (`CustomField`)
2. **Run Drift Detection**:
   ```bash
   sf project retrieve preview --target-org dev
   ```
3. **Analyze Results**: Identify any "Remote Add" or "Remote Change" statuses for components that overlap with your story's scope.

### Step 4: Generate Pre-Flight Report

Summarize the findings:
- Is Mother Story: [Yes/No]
- Component Lineage: [List of existing components from prior stories]
- Current Story Scope: [List of components to touch]
- Drift Detected: [List of conflicting components, or "None"]

### Step 5: Next Steps

If Drift is detected:
- **STOP**. The developer must resolve the drift (e.g., retrieve the changes locally via `sf project retrieve start` and commit them) before proceeding.

If No Drift:
- Suggest: "Analysis complete and environment is clean. You may now run `/SFSpeckit-implement [story-file]` to begin development."

## Output

- Pre-Flight Readiness Report (Console output)
- Recommended next action
