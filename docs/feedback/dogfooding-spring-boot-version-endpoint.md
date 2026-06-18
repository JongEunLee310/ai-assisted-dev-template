# Dogfooding Result — Spring Boot Version Endpoint

## Target

`spring-boot` branch

## Task

Add `GET /version`.

## Result

- PR: #15 (https://github.com/JongEunLee310/ai-assisted-dev-template/pull/15)
- CI: pass (`Verify Spring Boot Template`)
- Claude local review: posted on the PR (no blocking issues)
- Merge: not merged — kept open intentionally for dogfooding inspection; the throwaway `dogfood/spring-boot-version-endpoint` branch will be deleted locally and remotely afterward

## What Worked

- Issue → Codex handoff → manual Codex implementation → PR → CI → Claude local review pipeline completed end to end without scope drift.
- Codex extended the existing `HealthController.java` instead of adding a new controller — an explicitly allowed alternative in the handoff — and changed only `HealthController.java`, `HealthControllerTests.java`, `README.md`. No `build.gradle` or CI changes.
- `./gradlew clean build` passed on the first attempt, both in CI and when re-run locally (forced clean build, not cache) by Claude Code during review.

## What Failed

- Same nested-`codex exec` sandbox crash (exit 133) encountered on the `fastapi` run forced a switch to manual Codex execution here too — this was a harness-level issue, not specific to the Spring Boot branch. See `FAILURE-001-nested-codex-exec-sandbox-conflict.md` and `ADR-002-use-manual-codex-execution-instead-of-nested-codex-exec.md` (landed on `main`).

## Template Improvements Needed

- None specific to the `spring-boot` branch — the handoff template and `./gradlew build` verification worked as written.

## Decision

- [x] Keep template as-is
- [ ] Update AGENTS.md
- [ ] Update Codex handoff template
- [ ] Update CI
- [x] Update documentation (already done on `main`: `ADR-002`, `FAILURE-001`, manual-Codex-execution note in `handoff-policy.md` / `human-gate-policy.md` / `autonomy-levels.md` / `template-usage.md`)
