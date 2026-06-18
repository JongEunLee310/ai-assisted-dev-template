# Agent Instructions

These instructions apply to all AI coding agents working in this repository.

## Working Rules

- Read the relevant documentation before starting work.
- Stay within the issue scope and the explicit handoff scope.
- Distinguish facts, assumptions, and open questions.
- Do not weaken tests, CI, lint, typecheck, build checks, or verification rules.
- Do not remove tests to make CI pass.
- Do not modify protected files unless the issue or handoff explicitly allows it.
- Update documentation when project knowledge changes.
- Record important decisions in ADRs when they affect future work.
- Record important failures when an attempted approach should not be repeated.

## Protected Files

Protected files are files that require explicit permission before modification. Project-specific templates may expand this list.

- `AGENTS.md`
- `CLAUDE.md`
- `.codex/instructions.md`
- `.github/workflows/ci.yml`
- `docs/harness/`
- `docs/decisions/`
- `docs/failures/`

## Verification

Use the verification commands listed in the issue, handoff task, or project README. If verification cannot be run, explain why and state the residual risk.

## Codex Subagents

Codex may spawn the custom agents defined in `.codex/agents/` (`codebase_explorer`, `feature_worker`, `bugfix_worker`, `test_debugger`, `refactor_worker`, `pr_reviewer`) only when explicitly asked to in the session prompt. See `.codex/CODEX_ORCHESTRATION.md` for when each one applies and `.codex/CODEX_TASK_PACKET_TEMPLATE.md` for the task packet format.

## Done Definition

A Codex task is done only when all of the following are reported, not just implied:

- The requirement is met.
- The list of changed files is stated.
- The relevant test/verification commands were run, with results.
- Any verification that could not be run is named, with the reason and residual risk.
- Remaining risks are stated.
- Whether documentation, an ADR, or a failure record needs updating is stated.
