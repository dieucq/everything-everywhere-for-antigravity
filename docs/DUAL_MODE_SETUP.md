# Dual-mode setup

This is a non-destructive upgrade. It supports both quick Solo coding and a staged Team workflow with specialist review.

## Run from a Windows clone of this repository

```powershell
.\scripts\install-to-antigravity-safe.ps1 -WhatIf
.\scripts\install-to-antigravity-safe.ps1 -PluginNames antigravity-kit-plugin,openspec-plugin
.\scripts\Test-AntigravityInstallation.ps1
```

**Important:** The target path `~/.gemini/config/plugins/` is inherited from this repository. Verify that your installed Antigravity version actually reads it. This script deploys plugin directories, not the root `skills/` directory. Copies are not evidence of registered or working skills.

## Verify inside IDE
1. Ask: "Which exact SKILL.md file did you read for systematic-debugging? Show its path."
2. Give a reproducible test failure; ask the agent to use that skill and show fresh command output.
3. Ask for a Solo vs Team recommendation for a cross-module feature; require risks, approval gates, and cost rationale.
4. If the IDE cannot actually launch subagents, require sequential role simulation rather than claims of parallel execution.

## Project profiles (recommended)
Keep project-specific technology stack, quality gates, test commands, sensitive-data boundaries and design conventions in each project's own AGENTS.md. Do not override local project choices with generic global rules.

## Release safety
Review diffs. Never permit unattended production migration, deletion, secret access or deployment. The installer makes backups unless `-NoBackup` is selected. `-WhatIf` shows planned operations without making changes.
