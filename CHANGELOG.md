# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.1] - 2026-04-10

### Added
- **Skill Metadata**: Enforced project metadata standard (Version, Author, License) across all 17 skill modules for improved traceability.
- **Spectrum Engine (v1.1.1)**: Enhanced CLI orchestration with robust command handlers for `score` and `pr`.

### Changed
- **Unified Code Analyzer v5**: Migrated all security and linting gates from legacy `sfdx-scanner` to **Salesforce Code Analyzer v5**. This covers `/sfspeckit-implement`, `/sfspeckit-pr`, and `/sfspeckit-verify`.
- **Simplification**: Refined documentation structure to emphasize autonomous execution over manual CLI use.

## [1.1.0] - 2026-04-09

### Added
- **Spectrum Engine (CLI)**: Introduced a unified Bash wrapper (`./SFSpeckit/bin/sfspeckit`) to orchestrate the full SDLC with hybrid (Human/JSON) output support.
- **Salesforce Code Analyzer (Scanner) Integration**: Implemented mandatory security gates in `/sfspeckit-implement`. The engine now requires **Zero Severity 1 (Critical)** violations for Apex and LWC before proceeding.
- **Autonomous Auto-Heal Loop**: Introduced a 3-retry agentic loop (Analyze > Refactor > Re-score) to automatically resolve linting and logic errors during implementation.
- **Agentskills.io Compliance**: Standardized all 17 skills to meet agentskills.io structural requirements. Added `validate-skills` to the CLI for autonomous audit trails.
- **5-Phase Lifecycle**: Formalized the **Test** phase as a distinct pillar in the SDD strategy (Spec > Plan > Build > Test > Deploy).
- **Environmental Discovery**: Added autonomous `sf` CLI scanning to `/sfspeckit-constitution`. The skill now auto-detects packages, integration endpoints, and metadata maturity.
- **Visual SDD Lifecycle**: Added Mermaid diagram to README for architectural clarity.
- **Execution Log**: Added "First 5 Minutes" simulation log to README.
- **MIT License**: Added official license file and documentation.
- **Governance**: Added `SECURITY.md` and `CHANGELOG.md`.

### Changed
- **Rebranding**: Transitioned project identity to **SFSpeckit** (The Spec-Driven Engine).
- **Skill Migration**: All skills updated to use the centralized Spectrum Engine for lower hallucination and higher stability.
- **Security Posture**: Added mandatory prompts and risk warnings when static analysis tools are missing.
- Refactored Slash Commands table with **[DISCOVERY]**, **[AUTO-HEAL]**, and **[DRIFT ALERT]** badges.
- Improved skill orchestration between Antigravity and Cursor environments.

## [1.0.0] - 2026-04-05

### Added
- **Stable 17-Skill Lifecycle**: Full suite from specification to multi-org deployment.
- **Autonomous Auto-Heal**: Implemented self-correction loops in `/sfspeckit-implement`.
- **Verification Evidence**: Integrated formal coverage and security matrix generation.
- **Cross-IDE Installer**: Robust setup scripts for macOS and Windows.

## [0.5.0] - 2026-03-25

### Added
- **UAT & QA Suite**: Added `/sfspeckit-uat` and `/sfspeckit-qa` for multi-persona validation.
- **PR Automation**: Integration with `gh` CLI for automated pull request preparation.
- **Release Automation**: Added `/sfspeckit-release-notes` for business-ready summaries.

## [0.1.0] - 2026-03-20

### Added
- **Core Foundation**: Initial set of skills focusing on Spec-Driven Development: `/sfspeckit-specify`, `/sfspeckit-plan`, and `/sfspeckit-implement`.
- **The 9 Articles**: Establishment of the fundamental Salesforce project principles.

---

[1.1.1]: https://github.com/sumanthyanamala/SF-Spec-Kit/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/sumanthyanamala/SF-Spec-Kit/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/sumanthyanamala/SF-Spec-Kit/compare/v0.5.0...v1.0.0
[0.5.0]: https://github.com/sumanthyanamala/SF-Spec-Kit/compare/v0.1.0...v0.5.0
[0.1.0]: https://github.com/sumanthyanamala/SF-Spec-Kit/releases/tag/v0.1.0
