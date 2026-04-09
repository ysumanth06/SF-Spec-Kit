# 🚀 SF Spec-Kit — Autonomous Enterprise SDLC for Salesforce

**Transforming Salesforce delivery into an evidence-based, autonomous engine driven by structured specifications.**

SF Spec-Kit (SFSpeckit) is a standalone, Spec-Driven Development (SDD) toolkit designed for enterprise teams. It replaces manual, fragmented development with an autonomous pipeline that enforces architectural principles, detects environment drift, and self-corrects code using any existing AI-agent skills in your workspace.

---

## 🎯 What Is This?

SFSpeckit is a methodology + toolkit that gives your Salesforce team:

- **17 Slash Commands**: A complete lifecycle from `/sfspeckit-specify` to `/sfspeckit-deploy`.
- **Autonomous Auto-Heal**: `/sfspeckit-implement` automatically fixes linting, logic, and test errors by orchestrating your team's specific Salesforce skills.
- **CLI-Driven Drift Detection**: `/sfspeckit-clarify` identifies manual org changes and multi-team conflicts before a plan is finalized.
- **Verification Evidence**: `/sfspeckit-verify` generates formal, audit-ready evidence (Coverage, Security, Performance) required for PR approval.
- **Enterprise Multi-Org Support**: Orchestrates deployments across Dev, QA, UAT, and Production with built-in dependency resolution.
- **Guardrail Enforcement**: Integrated security guardrails and escalation matrices for complex Salesforce implementations.

---

## 🛠️ Prerequisites & Dependencies

Before using SFSpeckit, ensure your environment meets the following requirements:

- **Salesforce CLI (sf v2)**: Required for metadata operations, testing, and org synchronization.
- **GitHub CLI (gh)**: Required for the `/sfspeckit-pr` skill to automate pull request creation and metadata checks.
- **Git**: Required for version control and the SDD branching strategy.
- **AI Agent Runtime**: A tool capable of executing Markdown-based skills (e.g., Antigravity, Cursor, Claude Code).
- **Salesforce Org Access**: At least one Developer sandbox (Shared Dev) and one Review sandbox (QA).

---

## 🚀 One-Command Install

SFSpeckit includes automated installers that link the toolkit to your preferred AI Agent environment in seconds.

### macOS / Linux
Run this from your project root after cloning the toolkit:
```bash
cd SF-Spec-Kit && chmod +x install.sh && ./install.sh --ide all
```

### Windows (PowerShell)
Run this from your project root after cloning the toolkit:
```powershell
cd SF-Spec-Kit; .\install.ps1 -IDE all
```

> [!TIP]
> **Automated Dependency Setup**: The installers now detect missing tools (`sf` and `gh`) and will offer to install them for you via **npm**, **Homebrew**, or **Winget** during the process.

> [!TIP]
> Use `--ide cursor` or `--ide antigravity` if you only want to set up for a specific tool.

---

## 🤖 For AI Agents (Auto-Setup)

If you are an AI assistant (Antigravity, Cursor, Claude Code, etc.) tasked with setting up this toolkit for the user, follow these steps:

1.  **Clone** the repository if not already present in the project root.
2.  **Execute** the automated installer in **silent mode** to bypass confirmation prompts and automatically provision dependencies:
    - **macOS/Linux**: `cd SF-Spec-Kit && chmod +x install.sh && ./install.sh --ide all --yes`
    - **Windows**: `cd SF-Spec-Kit; .\install.ps1 -IDE all -Yes`
3.  **Confirm** success to the user and suggest running `/sfspeckit-constitution`.

---

## 💻 Cross-IDE Compatibility

SFSpeckit is designed to be **IDE-agnostic**. The core logic lives in structured Markdown "skills" that can be interpreted by any modern AI coding assistant.

| Tool | How to Use |
|------|------------|
| **Antigravity** | SFSpeckit is natively compatible via the `.agents/skills` directory. |
| **Cursor** | Copy or symlink the skills into `.cursor/rules/` or `.cursor/skills/`. The `.md` format is automatically parsed as Rules. |
| **Claude Code** | Point Claude to the `SF-Spec-Kit` directory; it will read the instruction sets in each `SKILL.md` to execute the commands. |
| **Windsurf / Others** | Add the `SF-Spec-Kit` directory to your "Global Context" or "Memories" to enable the slash commands. |

> [!TIP]
> Since every skill is a self-contained Markdown file with YAML frontmatter, you can easily port them to any tool that supports "Custom Instructions" or "Agent Personas."

---

## 🔌 Custom Skill Integration

SFSpeckit acts as an orchestrator for whatever Salesforce skills your team already uses (e.g., `sf-apex`, `sf-lwc`, `sf-metadata`).

- **Plug-and-Play**: SFSpeckit automatically detects and adapts to the custom skills available in your workspace.
- **Adaptive Implementation**: During the `/sfspeckit-implement` phase, the agent invokes the appropriate domain skill (Apex, LWC, Flow) to build and validate code.
- **Extensible Quality Gates**: Teams can define their own criteria and scoring logic within their custom skills, which SFSpeckit will respect and surface during the PR process.

---

## 📋 Slash Commands

| Command | Who | Purpose |
|---------|-----|---------|
| `/sfspeckit-constitution` | TPO | Establish the 9 unbreakable Salesforce development principles. |
| `/sfspeckit-specify` | TPO + BPO | Create a functional feature specification from business requirements. |
| `/sfspeckit-clarify` | TPO + Arch | **[DRIFT ALERT]** Perform deep gap analysis and environment drift audit. |
| `/sfspeckit-plan` | Architect | Technical architecture, deployment order, and impact analysis. |
| `/sfspeckit-stories` | TPO + Arch | Break plan into detailed, Jira-ready developer story files. |
| `/sfspeckit-review` | TPO + Arch | Pre-Jira quality gate to validate dependency graphs and boundaries. |
| `/sfspeckit-implement` | Developer | **[AUTO-HEAL]** Build story by orchestrating domain-specific SF skills. |
| `/sfspeckit-verify` | Developer | Generate "Verification Evidence" (Coverage, Security, Performance). |
| `/sfspeckit-pr` | Developer | Prepares PR summary via `gh cli`, aggregating evidence from integrated skills. |
| `/sfspeckit-qa` | QA | Multi-persona UI validation and automated test script execution. |
| `/sfspeckit-ua-t` | BPO / QA | Business UAT scripts and formal sign-offs. |
| `/sfspeckit-regression` | QA | Full feature regression across all stories in a release branch. |
| `/sfspeckit-release-notes` | TPO | Aggregate stories, tests, and UAT into business-ready release notes. |
| `/sfspeckit-score` | Arch / QA | Real-time quality dashboard based on integrated skill feedback. |
| `/sfspeckit-change` | TPO | Impact analysis for mid-sprint requirement changes. |
| `/sfspeckit-hotfix` | Developer | Emergency production-to-dev sync and rapid fix workflow. |
| `/sfspeckit-deploy` | Architect | Multi-org environment promotion (Dev → QA → UAT → Prod). |

---

## 📘 Detailed Skill Deep Dives

### 1. `/sfspeckit-constitution`
**Purpose**: Establishes the foundational rules for the project.
**How to use**: Run this first. It creates `memory/constitution.md`. All other skills refer to this to ensure consistency (e.g., ensuring all Apex follows the same trigger framework).

### 2. `/sfspeckit-specify`
**Purpose**: Brainstorms and defines business requirements.
**How to use**: Describe a feature in plain English. The skill will generate a structured `spec.md` including User Stories, Platform Context, and Security Matrices.

### 3. `/sfspeckit-clarify`
**Purpose**: Identifies gaps and environment drift.
**How to use**: Run after generating a spec. It performs a CLI-driven audit of your target Salesforce org to ensure your metadata assumptions match reality.

### 4. `/sfspeckit-plan`
**Purpose**: Creates the technical blueprint.
**How to use**: Run once the spec is approved. It defines every class, trigger, and component needed, including their deployment order.

### 5. `/sfspeckit-stories`
**Purpose**: Splits the plan into work units.
**How to use**: Run after the plan is signed off. It generates individual `task_story_NN.md` files that developers can claim.

### 6. `/sfspeckit-review`
**Purpose**: Validates stories before implementation.
**How to use**: Run to check the dependency graph and ensure stories don't have overlapping file responsibilities.

### 7. `/sfspeckit-implement`
**Purpose**: The primary build engine.
**How to use**: Run on a specific story file. It orchestrates your workspace's domain skills to write code and recursively fix errors (**Auto-Heal**).

### 8. `/sfspeckit-verify`
**Purpose**: Generates proof of quality.
**How to use**: Run after implementation. It produces a `verification-evidence.md` file with coverage reports and performance metrics.

### 9. `/sfspeckit-pr`
**Purpose**: Prepares the Pull Request.
**How to use**: Run to get a detailed PR description via `gh cli` and a summary of evidence gathered by the integrated Salesforce skills.

### 10. `/sfspeckit-qa`
**Purpose**: Validates functionality in the org.
**How to use**: Run to execute persona-based tests and UI validation scripts.

### 11. `/sfspeckit-uat`
**Purpose**: Managed business sign-off.
**How to use**: Generates simple scripts for non-technical stakeholders to verify requirements.

### 12. `/sfspeckit-regression`
**Purpose**: Full-feature validation.
**How to use**: Run before merging the feature branch to ensure new changes didn't break previous stories.

### 13. `/sfspeckit-release-notes`
**Purpose**: Business-ready documentation.
**How to use**: Run at the end of a sprint to summarize what was built and its business value.

### 14. `/sfspeckit-score`
**Purpose**: Project health dashboard.
**How to use**: Run to see the current quality metrics gathered from your team's custom integrated skills.

### 15. `/sfspeckit-change`
**Purpose**: Manages requirement churn.
**How to use**: If the business changes their mind, run this to see which stories or specs need to be adjusted.

### 16. `/sfspeckit-hotfix`
**Purpose**: Emergency patch workflow.
**How to use**: Run when a production bug is found. It handles the rapid fix and deployment back-sync.

### 17. `/sfspeckit-deploy`
**Purpose**: Orchestrates environment promotion.
**How to use**: Run to push your feature from Dev to QA, UAT, or Production.

---

## 🛡️ The 9 Salesforce Constitution Articles

| Article | Principle | What It Enforces |
|---------|-----------|-----------------|
| I | Metadata-First | Create Objects/Fields before writing any logic. |
| II | Bulk Awareness | Mandatory bulkification (201+ record handling) for all logic. |
| III | Declarative-First | Flow over Apex decision mandate; justification required for code. |
| IV | Absolute Security | `with sharing`, `WITH USER_MODE`, and no hardcoded IDs. |
| V | PNB Test Pattern | Positive, Negative, and Bulk test scenarios for every class. |
| VI | Clean Layers | Separation of concerns (Service, Selector, Domain, TAF). |
| VII | Deployment Safety | Mandatory dry-runs and explicit metadata dependency ordering. |
| VIII | Platform Context | Prompt-ready documentation and architectural clarity. |
| IX | Modular Logic | Code separated into testable, reusable domain units. |

---

## 🏗️ The SFSpeckit Workflow

### Phase 1: The Blueprint (TPO & Architect)
1. **Constitution**: `/sfspeckit-constitution` sets the rules.
2. **Specification**: `/sfspeckit-specify` defines the "What".
3. **Clarification**: `/sfspeckit-clarify` performs a **Drift Audit** against the target org to find manual changes.
4. **Planning**: `/sfspeckit-plan` defines the "How" and deployment order.
5. **Stories**: `/sfspeckit-stories` generates the work units.

### Phase 2: Implementation (Developers)
1. **Claim**: Assign your name and `IMPLEMENTING` state to a `task_story_NN.md`.
2. **Scaffold**: Run the scaffold command to generate boilerplate metadata and classes from your story.
3. **Build**: `/sfspeckit-implement` writes the code by orchestrating your team's Salesforce skills. If issues are found, the agent **Auto-Heals** the code until it meets the integrated skill criteria.
4. **Verify**: `/sfspeckit-verify` generates the **Verification Evidence** document.

### Phase 3: Quality & Promotion (QA & Architect)
1. **QA**: `/sfspeckit-qa` tests the UI across different **User Personas** (Admin, Sales, Support).
2. **PR**: `/sfspeckit-pr` prepares the code for review, aggregating feedback and scores from your custom domain skills.
3. **UAT**: `/sfspeckit-uat` manages business sign-off.
4. **Deploy**: `/sfspeckit-deploy` promotes the feature to the next environment.

---

## 🔍 Environment Drift Detection

SFSpeckit treats the Salesforce Org as a live, changing environment. During `/sfspeckit-clarify`, the system automatically:
- **Inventory Audit**: Compares current Org metadata (objects, fields, triggers) against Git source.
- **Manual Change Detection**: Identifies fields or classes created directly in the UI without PRs.
- **Conflict Risk**: Warns designers if another project is modifying the same components.

> [!CAUTION]
> If significant drift is found, the system will prevent `/sfspeckit-plan` until the environment is synced or the plan is adjusted.

---

## 📁 Repository Structure

```
SFSpeckit/
├── .agents/
│   ├── skills/                             # 17 Autonomous AI Skills
│   │   ├── sfspeckit-implement/
│   │   ├── sfspeckit-verify/
│   │   └── ...
├── sfspeckit/
│   ├── memory/
│   │   └── constitution.md                 # Project "North Star"
│   └── specs/                              # Active Features
│       └── 001-invoice-mgmt/
│           ├── spec.md                     # Functional
│           ├── plan.md                     # Technical
│           ├── verification-evidence.md    # Automated Evidence
│           └── stories/                    # Work Units
└── force-app/                              # Salesforce Metadata
```

---

*Built with ❤️ for Salesforce teams moving at the speed of AI.*
