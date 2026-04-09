---
name: sfspeckit-qa
description: "QA story verification. Generates manual test scripts from acceptance criteria, runs automated Apex/Jest tests, creates a traceability matrix, and provides persona coverage analysis. Run by the QA tester."
---

# /sfspeckit-qa — QA Story Verification

## Overview

This skill helps QA testers verify a developer story by generating manual test scripts, running automated tests, and mapping results to acceptance criteria.

## Who Runs This

**QA Tester**. This skill focuses on the **TECHNICAL** QA. For business validation, use `/SFSpeckit-uat`.

## Input

Path to the story file:
```
/SFSpeckit-qa sfspeckit-data/specs/001-invoice-mgmt/task_story_01.md
```

## Prerequisites

- Story status is **REVIEW** or higher (code review completed)
- Story code is deployed to QA Sandbox (`--target-org qa`)
- QA tester authenticated to QA org

## Steps

### Step 1: Read Story Context

1. Read the story file
2. Extract:
   - Acceptance criteria (Given/When/Then)
   - **Security & Access Matrix** (the personas to be tested)
   - Test cases (Positive, Negative, Bulk)
   - Implementation layers (which Apex classes, LWC components, Flows)
   - Scoring gates

### Step 2: Analyze Persona Coverage Requirements

1. For each Profile or Permission Set listed in the story's **Security & Access Matrix**:
   - Identify which functional ACs it must be tested against.
   - Identify "Negative" personas (those who should NOT have access).
2. Ensure the generated test scripts (Step 3) explicitly set the persona context (e.g., "Log in as Sales Rep").

### Step 3: Generate Manual Test Scripts

Read `.agents/skills/SFSpeckit-qa/test-scripts-template.md` (or the project's `sfspeckit-data/templates/test-scripts-template.md` if customized) and generate test scripts for each acceptance criterion:

For each acceptance criterion:
1. Convert Given/When/Then into step-by-step clickpath instructions.
2. **Assign a Persona**: Explicitly state which Profile/Permission Set from the Security Matrix should be used for this specific test.
3. Create a table with columns: Step | Action | Expected Result | Pass/Fail | Notes.
4. Add preconditions (user permissions, test data requirements).
5. Add cleanup instructions.

### Step 4: Run Automated Apex Tests

Execute Apex tests for classes listed in the story:

```bash
sf apex run test \
  --class-names [TestClass1,TestClass2,...] \
  --code-coverage \
  --result-format json \
  --target-org qa \
  --wait 10
```

### Step 5: Run Jest Tests (if LWC)

If the story includes LWC components:

```bash
npx lwc-jest -- --testPathPattern [componentName] --json
```

### Step 6: Build Persona Coverage Matrix

Cross-reference every persona from the story's **Security & Access Matrix** with the tests performed:

| Persona | Object Access | Field Security | Result | Method |
|---------|---------------|----------------|--------|--------|
| [Name] | [✅/❌] | [✅/❌] | PASS/FAIL | Automated (runAs) |
| [Name] | [✅/❌] | [✅/❌] | PASS/FAIL | Manual (TC-XXX) |

Ensure every persona has at least one associated test result.

### Step 7: Build Traceability Matrix

Map every acceptance criterion to its test coverage:

| AC # | Description | Automated Test | Manual Script | Status |
|------|-------------|---------------|---------------|--------|
| AC-1 | [Brief] | TestClass.method ✅ | TC-001 ⏳ | Partial |

### Step 8: Prepare for UAT

**Next Step**: "Technical QA PASSED. Run `/SFSpeckit-uat` to begin the business sign-off process."

### Step 9: Write Test Scripts File

Save technical results (Persona Matrix, Traceability Matrix, Manual Scripts) to:
`sfspeckit-data/specs/NNN-feature-name/task_story_NN_test_scripts.md`

### Step 10: Update Story File

Update the story file's QA Results section:
- **Technical Tests**: X/Y passed
- **Persona Coverage**: X/Y confirmed
- **State** to `QA` (passed technical QA, ready for UAT)

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

- Manual test scripts require QA to EXECUTE them in the org and record Pass/Fail
- UAT scripts are for BPO reviewers in the UAT sandbox (separate phase)
- If automated tests fail, story should be returned to developer before manual testing
