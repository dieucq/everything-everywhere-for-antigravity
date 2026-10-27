# Dual execution modes: Solo and Team

## Selection
Default to **Solo** for a bounded, reversible change with clear acceptance criteria. Choose **Team** when requirements are ambiguous, architecture or security is affected, a schema migration is proposed, or work spans independent modules. The user can explicitly override the selection. Do not imply that native multi-agent execution exists unless it has been tested in the active IDE.

## Solo
1. Read relevant code and project-specific rules.
2. State scope, acceptance criteria and expected changed files.
3. Make the smallest practical change on a feature branch.
4. Run focused tests and inspect the diff.
5. Report exact commands, evidence, outstanding risks and rollback steps.

## Team
1. Product analyst: clarify user stories, edge cases and acceptance criteria.
2. Architect: present design, trade-offs and migration risks.
3. Human approval: required before destructive work, changes to authentication, schema, breaking APIs or production systems.
4. Implementer(s): separate worktrees for truly independent tasks only; do not edit shared files in parallel.
5. Reviewer: verify specification compliance and code/security quality separately.
6. QA: run fresh checks, report failures and regression evidence.
7. Human release gate: approve deployment and irreversible operations.

If true subagents are unavailable, run these roles **sequentially** with separate artifacts and report that limitation.

## Cost and safety
- Do not load hundreds of skills into context. Choose only skills relevant to the current task.
- Never assert a skill was loaded solely because its name is in a rule file.
- Do not expose secrets or private company data to third-party services without permission.
- Never deploy, force-push, delete production data or mutate production infrastructure without explicit approval.
- Preserve architectural decisions in version-controlled docs; do not assume memory plugins are installed.
- Completion claims require fresh test or runtime evidence, not agent confidence.
