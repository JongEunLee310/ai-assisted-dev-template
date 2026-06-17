# AI-Assisted Project Template

> **Branch:** `fastapi` — FastAPI-specific variant with a minimal runnable FastAPI starter.
> Common Harness Engineering files are included. See `main` branch for the framework-agnostic template.

This repository is a reusable Harness Engineering based project template for teams that use Claude Code and Codex together.

It is not an application project. It provides the workflow, documentation structure, agent role boundaries, PR feedback loop, and governance files that future application templates can build on.

## Core Model

Claude Code and Codex have separated responsibilities.

- Claude Code plans work, reviews design, creates Codex handoff tasks, reviews PRs locally, assesses documentation impact, and decides whether ADRs, failure records, or knowledge base updates are needed.
- Codex implements from Claude Code handoff tasks, updates tests, runs local verification, fixes CI failures, and responds to blocking issues from Claude Code local review.
- GitHub Actions CI acts as the project-specific feedback sensor in the PR workflow.
- Humans own final approval, merge, and risky decisions.

Claude Code review is local by default. This template does not configure a Claude GitHub Action. Local review records can be published to the PR conversation when appropriate.

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

Those rules depend on the target language and framework. React, FastAPI, Spring Boot, and other project-specific templates should define their own linting, architecture checks, directory rules, and framework conventions.

## How To Use

1. Copy this template into a new project.
2. Customize `AGENTS.md`, `CLAUDE.md`, and `.codex/instructions.md` for the target project.
3. Fill in `docs/knowledge/domain-knowledge.md`.
4. Replace placeholder CI commands in `.github/workflows/ci.yml`.
5. Configure branch protection and required checks in GitHub.

## FastAPI Starter

This branch includes a minimal runnable FastAPI application.

### Verification

```bash
uv sync
uv run ruff check .
uv run mypy .
uv run pytest
```
