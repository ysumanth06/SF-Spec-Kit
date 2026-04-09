---
name: sfspeckit-verify
description: "Developer Verification and Evidence Generation. Runs Apex and LWC tests, generates a formal Verification Evidence document in the sfspeckit-data folder, and includes coverage and performance metrics."
---

# /sfspeckit-verify — Story Verification Evidence Generation

## Overview

This skill generates a formal "Unit Test Evidence" document for a developer story. It runs automated tests, analyzes code coverage, identifies performance bottlenecks, and saves a signed verification report to the `sfspeckit-data` directory.

## Who Runs This

**Developer** — after completing `/SFSpeckit-implement` and before running `/SFSpeckit-pr`.

## Input

Path to the story file:
```
/sfspeckit-verify sfspeckit-data/specs/001-invoice-mgmt/task_story_01.md
```

## Prerequisites

- Story status is **IMPLEMENTED** (completed by /SFSpeckit-implement)
- Target org is Dev Sandbox (`--target-org dev`)
- Salesforce Code Analyzer plugin installed (for security snapshot)

## Steps

### Step 1: Identify Story Scope

1. Read the story file.
2. Identify all Apex classes, LWC components, and Triggers from the **SF Implementation Layers** table.
3. Identify relevant test classes (e.g., `MyClass_Test.cls`).

### Step 2: Push Current Changes

Ensure the story branch is up-to-date with your local changes.
```bash
git add .
git commit -m "chore: prepare for unit test verification"
```

### Step 3: Run Unit Tests & Security Scans

Run the integrated verification engine:
```bash
./SFSpeckit/bin/sfspeckit verify --id $STORY_ID --target-org dev
```

### Step 3.5: Runtime Telemetry Analysis (Log Observation)

**ENSURES SCALABILITY.** Don't just check IF it passed; check HOW it passed.

1. **Identify Slowest Test Methods**: From the JSON results in Step 3.
2. **Pull Debug Logs**:
   ```bash
   sf apex get log --log-id [LogId] --target-org dev
   ```
3. **Parse for Bottlenecks**:
   - **SOQL Count**: High number of queries (>60 per transaction).
   - **CPU Time**: Transactions taking >1000ms of CPU.
   - **DML Rows**: Large DML operations (>150 rows in unit tests).

Record these in the **Runtime Telemetry** section.

### Step 4: Run LWC Jest Tests (if applicable)

If the story has LWC layers:
```bash
npx lwc-jest -- --testPathPattern [componentName] --json --outputFile sfspeckit-data/logs/tests/jest-results.json
```

### Step 5: Review Generated Evidence

Check the auto-generated evidence:
- Location: `sfspeckit-data/specs/[feature-dir]/verification-evidence.md`
- Template:

```markdown
# Verification Evidence: Story $ID — $TITLE

**Date**: $DATE
**Developer**: $USER
**Status**: [PASS / FAIL]

## 1. Test Execution Summary

| Engine | Total Tests | Passed | Failed | Duration | Status |
|--------|-------------|--------|--------|----------|--------|
| Apex   | X           | X      | X      | X.XXs    | ✅/❌ |
| LWC    | X           | X      | X      | X.XXs    | ✅/❌ |

## 2. Code Coverage Heatmap

| Class / Component | Type | Covered (%) | Threshold | Status |
|-------------------|------|-------------|-----------|--------|
| $CLASS_NAME       | Apex | 94%         | 90%       | ✅      |
| $COMP_NAME        | LWC  | 92%         | 80%       | ✅      |

## 3. Runtime Telemetry (Observability)

| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Max SOQL | 42 | 60 | ✅ |
| Max CPU | 850ms | 1000ms | ⚠️ WARN |
| Max DML | 12 | 100 | ✅ |

### Bottleneck Analysis
- **$METHOD_NAME**: High CPU usage in `calculateTotal`. Consider caching.

## 4. Performance Metrics (Legacy)

List any test method taking longer than **1.0 second**:

| Test Method | Duration | Status |
|-------------|----------|--------|
| $METHOD_NAME | 1.45s    | ⚠️ SLOW |

## 5. Security Scanner Snapshot

Standard scan results (PMD/ESLint):
- **Severity 1 (Critical)**: 0
- **Severity 2 (High)**: 0
- **Severity 3 (Moderate)**: X

## 6. Bulk Verification (251+ Records)

- [ ] Bulk test scenario executed for $OBJECT_NAME
- [ ] No governor limit exceptions (SOQL/DML) detected
```

### Step 6: Update Story File

- Update **QA Results** or **State** section to reference the new evidence document.
- Set **State** to `VERIFIED` (Internal dev verification complete).

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
