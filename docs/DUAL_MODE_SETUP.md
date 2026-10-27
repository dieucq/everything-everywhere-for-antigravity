# Antigravity IDE dual-mode setup (Windows)

Observed machine baseline (27 Oct 2026): `~/.gemini/config/plugins/` contained six plugin folders; `~/.gemini/config/skills/` and `~/.gemini/config/rules/` did not exist. Antigravity showed a project-level `AGENTS.md` rule, not a global one.

## Official skill locations

- Antigravity IDE global: `~/.gemini/config/skills/<skill>/SKILL.md`
- Project-specific: `<workspace>/.agents/skills/<skill>/SKILL.md`
- The plugin folders already present on the machine are *not* proof that root repository skills are registered in the IDE.
- Rule files in config/rules may have metadata requirements. A root project AGENTS.md is not the same as a global rule.

Source: https://www.antigravity.google/docs/skills?tab=ide

## Recommended: minimal selected skills

From the checked-out repository in Windows PowerShell:

```powershell
.\scripts\install-selected-skills.ps1 -WhatIf
.\scripts\install-selected-skills.ps1
```

This copies eight default engineering skills from repository `skills/`. It does NOT touch plugins, project rules, or other skills. Review and approve the dry-run first. The script backs up any existing same-named destination folders. Avoid installing every skill at once.

To choose a smaller set:

```powershell
.\scripts\install-selected-skills.ps1 -Names brainstorming,systematic-debugging,verification-before-completion -WhatIf
```

## Existing plugin diagnostics (optional)

```powershell
.\scripts\Test-AntigravityInstallation.ps1
```

A missing `plugin.json` alone does not prove a folder is broken: it could be a standalone skill. Do not use this diagnostic to remove existing folders. The legacy plugin installer and `install-to-antigravity-safe.ps1` are not the preferred IDE installation path for standalone skills.

## IDE smoke test

1. Restart/reload the IDE if needed, inspect Customizations.
2. Ask it to explicitly invoke `/systematic-debugging` or to explain which full `SKILL.md` it opened.
3. Offer a reproducible bug in a disposable test project; require real test output.
4. Give a cross-module feature; ask it to select Solo or Team, identify approval gates and explain whether native subagents are available.
5. Report paths and actual results; never claim success from directory existence alone.

## Safety

Do not alter OpenSpec project rules, production systems, credentials or the existing six plugin folders during this migration. Never merge a PR before reviewing the diff.
