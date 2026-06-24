# AI 개발 보조 템플릿

> **브랜치:** `spring-boot` — 최소 실행 가능한 Spring Boot 스타터가 포함된 Spring Boot 변형.
> 공통 Harness Engineering 파일이 포함된다. 프레임워크 무관 템플릿은 `main` 브랜치를 참고한다.

이 저장소는 Claude Code와 Codex를 함께 사용하는 팀을 위한 재사용 가능한 Harness Engineering 기반 프로젝트 템플릿이다.

## 핵심 모델

Claude Code와 Codex는 역할이 분리되어 있다.

- **Claude Code** — 작업 계획 수립, 설계 검토, Codex 핸드오프 태스크 생성, 로컬 PR 리뷰, 문서화 영향 평가, ADR/실패 기록/지식베이스 업데이트 필요 여부 판단.
- **Codex** — Claude Code가 기본 샌드박스(`read-only`/`workspace-write`)에서 `codex exec`로 자동 트리거하는 구현 실행(수동 폴백), 테스트 업데이트, 로컬 검증, CI 실패 수정, 로컬 리뷰 블로킹 이슈 대응. `docs/decisions/ADR-003-allow-claude-code-to-invoke-codex-exec.md` 참고.
- **GitHub Actions CI** — PR 워크플로우의 피드백 센서 역할.
- **사람** — 최종 승인, merge, 위험 결정의 책임자.

Claude Code 리뷰는 기본적으로 로컬에서 수행한다. 이 템플릿은 Claude GitHub Action을 설정하지 않는다. CI에 Anthropic API 키가 필요하지 않다. 적절한 경우 로컬 리뷰 기록을 PR 대화에 게시할 수 있다.

## 에이전트 자율성

에이전트 행동 범위는 `docs/harness/autonomy-levels.md`에 정의된 레벨로 제어한다.

- **Level 0: Manual** — 사람이 모든 작업을 수행한다.
- **Level 1: AI-Assisted** — Claude Code와 Codex가 계획·작성·구현을 보조하고 사람이 매 단계 검토·승인한다.
- **Level 2: Semi-Autonomous** — Claude Code가 계획하고 Codex가 `codex exec`로 구현하며 CI가 검증한다. 사람은 PR을 검토·merge한다.
- 기본 동작은 Low/Medium 위험 작업에 **Level 2**, High/Critical 위험 작업은 **Level 1**(구현 전 휴먼 게이트)이다.

## Spring Boot 스타터

이 브랜치는 최소 실행 가능한 Spring Boot 애플리케이션을 포함한다.

- Java 21, Spring Boot 3.5.0, Gradle wrapper
- `GET /health`는 `{"status": "ok"}`를 반환한다.

### 검증

```bash
./gradlew build
```

Java 21이 필요하다.

## 포함된 관행

이 템플릿은 다음을 포함한다:

- 지속적인 아키텍처 및 워크플로우 결정을 위한 ADR.
- 반복하지 말아야 할 접근 방식에 대한 실패 기록.
- 워크플로우 및 프로젝트별 도메인 지식을 위한 지식베이스 문서.
- PR, CI, 리뷰 학습을 위한 피드백 루프 기록.
- 오래된 AI 워크플로우 아티팩트 및 문서 제거를 위한 가비지 컬렉션 정책.
- 문서 드리프트 감소를 위한 디렉토리 README 파일.
- 보호 파일 검사 및 문서 일관성 검사 훅 (`.claude/hooks/`).
- 에이전트 자율성 레벨 정의 (`docs/harness/autonomy-levels.md`).

## 의도적 제외 항목

코드 드리프트 및 구조 드리프트 규칙은 공통 harness 레이어에서 의도적으로 제외한다.

Spring Boot 특화 드리프트 규칙은 프로젝트별로 추가해야 한다.

외부 Claude Skills는 이 저장소에 포함되지 않는다. `everything-claude-code` 또는 다른 소스에서 수동으로 설치한다. `docs/harness/skill-usage-policy.md` 참고.

## 사용 방법

1. 이 템플릿을 새 프로젝트에 복사한다.
2. 대상 프로젝트에 맞게 `AGENTS.md`, `CLAUDE.md`, `.codex/instructions.md`를 커스터마이즈한다.
3. `docs/knowledge/domain-knowledge.md`를 작성한다.
4. `.github/workflows/ci.yml`의 CI를 프로젝트별 검증 명령으로 교체하거나 확장한다.
5. GitHub에서 브랜치 보호 및 필수 체크를 설정한다.

## 적용 프로젝트에 맞게 문서 정리

`docs/`에는 재사용 가능한 하니스 골격과, 이 템플릿 자체를 만들고 도그푸딩하며 남긴 기록이 섞여 있다. 실제 프로젝트에 적용할 때는 **적용 프로젝트와 무관한 템플릿 기록을 삭제하고** 골격만 남긴다.

**유지 (재사용 골격)**

- `docs/harness/` — Harness Engineering 핵심 정책 전체.
- `docs/decisions/ADR-000-template.md`, `docs/failures/FAILURE-000-template.md` — ADR·실패 기록 템플릿.
- `docs/decisions/ADR-001-separate-claude-code-and-codex-roles.md` — 역할 분리 등 워크플로우 거버넌스 ADR.
- `docs/feedback/loop-template.md`, `docs/feedback/retrospective-template.md`, `docs/dogfooding/001-rollback-plan-template.md` — 빈 템플릿.
- `docs/knowledge/workflow.md`, `docs/knowledge/glossary.md` — 워크플로우·용어집.
- 각 디렉토리의 `README.md`.

**비우고 채움**

- `docs/knowledge/domain-knowledge.md` — 적용 프로젝트의 도메인 규칙으로 교체.

**삭제 (이 템플릿 자체 기록)**

- `docs/feedback/dogfooding-plan.md`, `docs/feedback/dogfooding-handoffs/`, `docs/feedback/dogfooding-*-version-endpoint.md` — 도그푸딩 계획·핸드오프·실행 기록.
- `docs/decisions/ADR-002-*`, `docs/decisions/ADR-003-*`, `docs/failures/FAILURE-001-*` — 이 템플릿의 `codex exec` 운영 결정·실패 기록 (적용 프로젝트에서 동일 결정을 유지하면 남겨도 무방).
- `docs/knowledge/template-usage.md` — 이 템플릿 사용법 문서.
- `docs/archive/`, `docs/designs/`, `docs/reviews/` — 템플릿 작업 중 누적된 보관·설계·리뷰 기록.

## 디렉토리 구조

```
docs/
  harness/        — Harness Engineering 핵심 정책 (자율성 레벨 포함)
  decisions/      — ADR (아키텍처 결정 기록)
  failures/       — 실패 기록
  feedback/       — 피드백 루프 기록
  knowledge/      — 워크플로우 및 도메인 지식
  designs/        — 설계 기록
  dogfooding/     — 도그푸딩 실행 기록
  reviews/        — 로컬 PR 리뷰 기록
  archive/        — 보관된 문서
```
