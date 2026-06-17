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

Use the verification commands listed in the issue, handoff task, or project README.

Default commands for this template:

- `uv run ruff check .` — lint
- `uv run mypy .` — type check
- `uv run pytest` — tests

If verification cannot be run, explain why and state the residual risk.
