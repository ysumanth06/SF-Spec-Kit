# 🚀 SF Spec-Kit — Autonomous Enterprise SDLC for Salesforce

**Transforming Salesforce delivery into an evidence-based, autonomous engine driven by structured specifications.**

---

## 🏗️ Spec-Driven Development (SDD) for AI

SFSpeckit is built on the philosophy of **Spec-Driven Development (SDD)**. In the era of AI-agentic coding, jumping directly into implementation is the fastest way to hit context limits, create hallucinations, and accumulate technical debt.

### The SDD Strategy:
`Spec >>> Plan >>> Build >>> Deploy`

1.  **Spec**: Define the *What* (Functional requirements, user stories, security matrix).
2.  **Plan**: Define the *How* (Metadata, class structures, deployment order, impact analysis).
3.  **Build**: Execute the *Task* (Autonomous implementation with auto-heal loops).
4.  **Deploy**: Promote the *Evidence* (Automated promotion across environments).

### Why SDD for AI?
- **🧠 Context Isolation**: By separating planning from building, the AI focuses on one logical layer at a time, drastically reducing hallucinations.
- **⚡ Token Efficiency**: Agents only need the specific "Work Unit" (Story + Plan) instead of the entire codebase, ensuring faster and cheaper iterations.
- **🛡️ Evidence-Based Quality**: Every build is measured against the Spec and the Constitution, providing a deterministic audit trail before any code is merged.
- **🔄 Auto-Heal**: If a build fails, the AI refers back to the Plan to self-correct, rather than guessing the intended logic.

---

## 🎯 What Is This?

SFSpeckit is a methodology + toolkit that gives your Salesforce team:

- **17 Slash Commands**: A complete lifecycle from `/sfspeckit-specify` to `/sfspeckit-deploy`.
- **Autonomous Auto-Heal**: `/sfspeckit-implement` automatically fixes linting, logic, and test errors by orchestrating your team's specific Salesforce skills.
- **CLI-Driven Drift Detection**: `/sfspeckit-clarify` identifies manual org changes and multi-team conflicts before a plan is finalized.
- **Verification Evidence**: `/sfspeckit-verify` generates formal, audit-ready evidence (Coverage, Security, Performance) required for PR approval.
- **Enterprise Multi-Org Support**: Orchestrates deployments across Dev, QA, UAT, and Production with built-in dependency resolution.

---

## 🛠️ Prerequisites & Dependencies

Before using SFSpeckit, ensure your environment meets the following requirements:

- **Salesforce CLI (sf v2)**: Required for metadata operations.
- **GitHub CLI (gh)**: Required for the `/sfspeckit-pr` skill.
- **Git**: Required for version control.
- **AI Agent Runtime**: Antigravity, Cursor, or Claude Code.

---

## 🚀 One-Command Install

SFSpeckit includes automated installers that link the toolkit to your preferred AI Agent environment in seconds.

### macOS / Linux
```bash
cd SF-Spec-Kit && chmod +x install.sh && ./install.sh --ide all
```

### Windows (PowerShell)
```powershell
cd SF-Spec-Kit; .\install.ps1 -IDE all
```

> [!TIP]
> **Automated Dependency Setup**: The installers detect missing tools (`sf`, `gh`) and offer to install them via **npm**, **Homebrew**, or **Winget** automatically.

---

## 🤖 For AI Agents (Auto-Setup)

If you are an AI assistant tasked with setting up this toolkit:
1.  **Clone** this repo to the project root.
2.  **Run** the installer in silent mode:
    - **Mac**: `./install.sh --ide all --yes`
    - **Windows**: `.\install.ps1 -IDE all -Yes`

---

## 💻 Cross-IDE Compatibility

SFSpeckit is **IDE-agnostic**. The core logic lives in structured Markdown "skills" that can be interpreted by any assistant.

| Tool | How to Use |
|------|------------|
| **Antigravity** | Natively compatible via `.agents/skills`. |
| **Cursor** | Copy/link skills into `.cursor/rules/`. |
| **Claude Code** | Point Claude to the `SF-Spec-Kit` directory. |

---

## 📋 Slash Commands

| Command | Who | Purpose |
|---------|-----|---------|
| `/sfspeckit-constitution` | TPO | Establish project "North Star" principles. |
| `/sfspeckit-specify` | TPO | Create functional feature specs. |
| `/sfspeckit-clarify` | Arch | **[DRIFT ALERT]** Deep gap analysis and drift audit. |
| `/sfspeckit-plan` | Arch | Technical blueprint and deployment order. |
| `/sfspeckit-stories` | Arch | Break plan into Jira-ready developer stories. |
| `/sfspeckit-implement` | Dev | **[AUTO-HEAL]** Build story by orchestrating SF skills. |
| `/sfspeckit-verify` | Dev | Generate "Verification Evidence" (Coverage, Security, Perf). |
| `/sfspeckit-pr` | Dev | Prepares PR summary via `gh cli`. |
| `/sfspeckit-qa` | QA | Multi-persona UI validation. |
| `/sfspeckit-uat` | BPO | Business UAT scripts and sign-offs. |
| `/sfspeckit-regression` | QA | Full feature regression before release. |
| `/sfspeckit-release-notes`| TPO | Business-ready delivery summary. |
| `/sfspeckit-score` | QA | Real-time project health dashboard. |
| `/sfspeckit-change` | TPO | Impact analysis for mid-sprint changes. |
| `/sfspeckit-hotfix` | Dev | Emergency production patch workflow. |
| `/sfspeckit-deploy` | Arch | Multi-org environment promotion. |

---

## 🛡️ The 9 Salesforce Constitution Articles

| Article | Principle | What It Enforces |
|---------|-----------|-----------------|
| I | Metadata-First | Objects/Fields before logic. |
| II | Bulk Awareness | Mandatory 201+ record handling. |
| III | Declarative-First | Flow over Apex decision mandate. |
| IV | Absolute Security | `with sharing` & `WITH USER_MODE`. |
| V | PNB Test Pattern | Positive, Negative, Bulk test scenarios. |
| VI | Clean Layers | Logic separation (Service, Selector, Domain). |
| VII | Deployment Safety | Mandatory dry-runs and syncs. |
| VIII | Platform Context | Prompt-ready architectural clarity. |
| IX | Modular Logic | Reusable, testable domain units. |

---

## 📁 Repository Structure

```
SFSpeckit/
├── .cursor/
│   └── skills/                             # AI Skills (Cursor Optimized)
│       ├── sfspeckit-implement/
│       └── ...
├── .agents/                                # AI Skills (Agentic Optimized)
│   └── skills/                             # Linked via Installer
├── sfspeckit/                              # Project Memory & Docs
│   ├── memory/
│   │   └── constitution.md                 # Project "North Star"
│   └── specs/                              # Feature Specifications
│       └── 001-feature-name/
│           ├── spec.md                     # Functional Spec
│           ├── plan.md                     # Technical Plan
│           ├── verification-evidence.md    # Automated Evidence
│           └── stories/                    # Developer Work Units
└── force-app/                              # Salesforce Metadata
```

---

*Built with ❤️ for Salesforce teams moving at the speed of AI.*
