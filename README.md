# AI-Assisted Dev Template

> **Branch:** `main` — common Harness Engineering template. This branch is not an application starter.
> Framework-specific variants live in other branches: `fastapi`, `spring-boot`.

This repository provides reusable AI-assisted development workflow files for teams that use Claude Code and Codex together.

It is not an application project. It does not contain application code, framework-specific configuration, or runnable services.

## Core Model

Claude Code and Codex have separated responsibilities.

- **Claude Code** plans work, reviews design, creates Codex handoff tasks, reviews PRs locally, assesses documentation impact, and decides whether ADRs, failure records, or knowledge base updates are needed.
- **Codex** implements from Claude Code handoff tasks, updates tests, runs local verification, fixes CI failures, and responds to blocking issues from Claude Code local review.
- **GitHub Actions CI** acts as the feedback sensor in the PR workflow.
- **Humans** own final approval, merge, and risky decisions.

Claude Code review is local by default. This template does not configure a Claude GitHub Action. Anthropic API key is not required in CI. Local review records can be published to the PR conversation when appropriate.

## Included Practices

This template includes:

- ADRs for durable architectural and workflow decisions.
- Failure records for approaches that failed and should not be repeated blindly.
- Knowledge base documents for workflow and project-specific domain knowledge.
- Feedback loop records for PR, CI, and review learnings.
- Garbage collection policies for removing stale AI workflow artifacts and documentation.
- Directory README files to reduce documentation drift.
- Protected-file and documentation consistency hook placeholders.

## Intentional Exclusions

Code drift and structure drift rules are intentionally excluded from this common template.

Those rules depend on the target language and framework. FastAPI, Spring Boot, and other project-specific templates should define their own linting, architecture checks, directory rules, and framework conventions.

External Claude Skills are not vendored in this repository. Install them manually from `everything-claude-code` or another source. See `docs/harness/skill-usage-policy.md`.

## How To Use

1. Copy this template into a new project.
2. Customize `AGENTS.md`, `CLAUDE.md`, and `.codex/instructions.md` for the target project.
3. Fill in `docs/knowledge/domain-knowledge.md`.
4. Replace CI in `.github/workflows/ci.yml` with project-specific verification commands.
5. Configure branch protection and required checks in GitHub.
