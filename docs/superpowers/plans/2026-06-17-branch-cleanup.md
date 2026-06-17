# Branch Cleanup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** main/fastapi/spring-boot 브랜치를 각각 공통 하네스 템플릿, FastAPI 스타터, Spring Boot 스타터로 명확히 정리한다.

**Architecture:** 브랜치별 순서(main → fastapi → spring-boot)로 진행한다. 각 브랜치에 공통 변경(PR 템플릿, 누락 docs)을 적용한 뒤 브랜치별 고유 작업(앱 코드, CI)을 수행한다. `.claude/skills` 및 `.codex/skills` 벤더링을 제거하고 `skill-usage-policy.md`에 외부 스킬 정책을 명시한다.

**Tech Stack:** Bash, Git, uv/Python 3.12, Spring Initializr(curl), Java 17(로컬) / Java 21(CI), Gradle Wrapper

---

## Environment Notes

- uv 0.11.8 설치됨 — FastAPI 로컬 검증 가능
- Java 17 설치됨, Java 21 미설치 — Spring Boot `./gradlew build` 로컬 실행 불가, CI에서 검증
- Gradle 미설치 — Spring Initializr(curl)로 Gradle wrapper 포함 스타터 생성
- Spring Initializr (https://start.spring.io) 접근 가능 확인됨

---

## File Map

### main 브랜치 변경 파일

| 파일 | 작업 |
|------|------|
| `.github/workflows/ci.yml` | placeholder echo 제거 → 템플릿 자체검사로 교체 |
| `.github/pull_request_template.md` | Autonomy Check 섹션 추가 |
| `docs/harness/autonomy-levels.md` | 신규 생성 |
| `docs/harness/orchestration-state-policy.md` | 신규 생성 |
| `docs/harness/README.md` | 두 신규 문서 항목 추가 |
| `docs/harness/skill-usage-policy.md` | 외부 스킬 정책 보강 |

### fastapi 브랜치 변경 파일 (main 변경 포함)

| 파일 | 작업 |
|------|------|
| `README.md` | FastAPI 브랜치 정체성 섹션 추가 |
| `app/__init__.py` | 신규 생성 (빈 파일) |
| `app/main.py` | 신규 생성 — FastAPI 앱, GET /health |
| `tests/__init__.py` | 신규 생성 (빈 파일) |
| `tests/test_health.py` | 신규 생성 — /health 테스트 |
| `pyproject.toml` | 신규 생성 — 의존성 정의 |
| `.github/workflows/ci.yml` | 이미 완료됨, 검증만 |
| `.github/pull_request_template.md` | main과 동일 변경 |
| `docs/harness/autonomy-levels.md` | 신규 생성 |
| `docs/harness/orchestration-state-policy.md` | 신규 생성 |
| `docs/harness/README.md` | 두 신규 문서 항목 추가 |
| `docs/harness/skill-usage-policy.md` | 외부 스킬 정책 보강 |
| `.claude/skills/` | 디렉토리 삭제 |
| `.codex/skills/` | 디렉토리 삭제 |

### spring-boot 브랜치 변경 파일 (main 변경 포함)

| 파일 | 작업 |
|------|------|
| `README.md` | Spring Boot 브랜치 정체성 섹션 추가 |
| `gradlew` | Spring Initializr에서 생성 |
| `gradlew.bat` | Spring Initializr에서 생성 |
| `gradle/wrapper/gradle-wrapper.jar` | Spring Initializr에서 생성 |
| `gradle/wrapper/gradle-wrapper.properties` | Spring Initializr에서 생성 |
| `settings.gradle` | Spring Initializr에서 생성, 내용 검토 |
| `build.gradle` | Spring Initializr에서 생성, 내용 검토 |
| `src/main/java/com/example/template/TemplateApplication.java` | Spring Initializr에서 생성 |
| `src/main/java/com/example/template/HealthController.java` | 신규 생성 |
| `src/test/java/com/example/template/TemplateApplicationTests.java` | Spring Initializr에서 생성 |
| `src/test/java/com/example/template/HealthControllerTests.java` | 신규 생성 |
| `.github/pull_request_template.md` | main과 동일 변경 |
| `docs/harness/autonomy-levels.md` | 신규 생성 |
| `docs/harness/orchestration-state-policy.md` | 신규 생성 |
| `docs/harness/README.md` | 두 신규 문서 항목 추가 |
| `docs/harness/skill-usage-policy.md` | 외부 스킬 정책 보강 |
| `.claude/skills/` | 디렉토리 삭제 |
| `.codex/skills/` | 디렉토리 삭제 |

---

## Phase 1: main 브랜치

### Task 1: main — CI 자체검사로 교체

**Files:**
- Modify: `.github/workflows/ci.yml`

- [ ] **Step 1: main 브랜치로 전환**

```bash
git checkout main
```

Expected: `Switched to branch 'main'`

- [ ] **Step 2: 현재 CI 내용 확인**

```bash
cat .github/workflows/ci.yml
```

Expected: placeholder echo 구문 확인

- [ ] **Step 3: CI 파일 교체**

`.github/workflows/ci.yml` 전체를 아래 내용으로 교체한다:

```yaml
name: CI

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  verify:
    name: Template Self-Check
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Check required core files
        run: |
          test -f AGENTS.md
          test -f CLAUDE.md
          test -f .codex/instructions.md
          test -f .github/pull_request_template.md
          test -f docs/README.md
          test -f docs/harness/README.md
          test -f docs/knowledge/README.md
          test -f docs/decisions/README.md
          test -f docs/failures/README.md
          test -f docs/feedback/README.md
          test -f docs/archive/README.md

      - name: Check hook script syntax
        run: |
          find .claude/hooks -name "*.sh" -print -exec bash -n {} \;
```

- [ ] **Step 4: 로컬에서 훅 스크립트 구문 검사 실행**

```bash
find .claude/hooks -name "*.sh" -print -exec bash -n {} \;
```

Expected: 각 .sh 파일 경로가 출력되고 오류 없이 종료

- [ ] **Step 5: 필수 파일 존재 검사 실행**

```bash
test -f AGENTS.md && test -f CLAUDE.md && test -f .codex/instructions.md && \
test -f .github/pull_request_template.md && test -f docs/README.md && \
test -f docs/harness/README.md && test -f docs/knowledge/README.md && \
test -f docs/decisions/README.md && test -f docs/failures/README.md && \
test -f docs/feedback/README.md && test -f docs/archive/README.md && \
echo "All checks passed"
```

Expected: `All checks passed`

---

### Task 2: main — 누락 harness docs 추가

**Files:**
- Create: `docs/harness/autonomy-levels.md`
- Create: `docs/harness/orchestration-state-policy.md`
- Modify: `docs/harness/README.md`

- [ ] **Step 1: autonomy-levels.md 생성**

`docs/harness/autonomy-levels.md`:

```markdown
# Autonomy Levels

This document defines the autonomy levels available in the AI-assisted development workflow.

## Levels

### Level 0: Manual

All work is performed by a human. AI tools are not used.

### Level 1: AI-Assisted

Claude Code and Codex assist with planning, drafting, and implementation. Humans review and approve every step before it proceeds.

Use when: the team is learning the workflow, or the task is High or Critical risk.

### Level 2: Semi-Autonomous

Claude Code plans, Codex implements, and CI verifies. Humans review PRs before merge.

Use when: the task is Low or Medium risk, scope is clearly defined, and verification commands exist.

## Default Level

This template operates at Level 2 for Low and Medium risk tasks. High and Critical risk tasks require Level 1 (human gate before implementation begins).

## Related

- `task-classification-policy.md` — risk levels
- `human-gate-policy.md` — gate conditions
```

- [ ] **Step 2: orchestration-state-policy.md 생성**

`docs/harness/orchestration-state-policy.md`:

```markdown
# Orchestration State Policy

This document defines the workflow states from issue creation to merge.

## States

### Draft

The issue is created. Claude Code has not reviewed it yet.

Transition to: Review

### Review

Claude Code is analyzing the issue and assessing risk.

Transition to: Blocked (gate condition applies) or Ready (Low/Medium risk)

### Blocked

A human gate condition applies. Work cannot proceed until the human approves.

Transition to: Ready (after approval) or Cancelled (if rejected/deferred)

### Ready

Claude Code has created a Codex handoff task. Implementation can begin.

Transition to: In Progress

### In Progress

Codex is implementing.

Transition to: PR Open

### PR Open

A PR is open. CI runs. Claude Code runs a local review.

Transition to: PR Approved (CI passes, human approves) or PR Blocked (Claude review finds blocking issues)

### PR Blocked

Claude Code found blocking issues. Codex must respond.

Transition to: PR Open (after Codex addresses issues)

### PR Approved

The human has approved the PR.

Transition to: Merged

### Merged

Merged. Documentation impact assessed. ADRs, failure records, or knowledge updates created if needed.

### Cancelled

Work was rejected, deferred, or abandoned. Record reason in a failure record if worth remembering.

## Related

- `task-classification-policy.md`
- `human-gate-policy.md`
- `handoff-policy.md`
```

- [ ] **Step 3: harness/README.md에 두 문서 항목 추가**

`docs/harness/README.md` 의 `## Included Documents` 섹션에 두 줄 추가:

```
- `autonomy-levels.md`
- `orchestration-state-policy.md`
```

---

### Task 3: main — PR 템플릿 Autonomy Check 추가

**Files:**
- Modify: `.github/pull_request_template.md`

- [ ] **Step 1: 현재 PR 템플릿 내용 확인**

```bash
cat .github/pull_request_template.md
```

- [ ] **Step 2: Autonomy Check 섹션 추가**

파일 끝에 다음 섹션을 추가한다:

```markdown
## Autonomy Check

- [ ] Task risk level classified
- [ ] Human gate not required
- [ ] Human gate required and approved
- [ ] Scope remained within approved autonomy level
```

---

### Task 4: main — skill-usage-policy.md 보강 및 커밋

**Files:**
- Modify: `docs/harness/skill-usage-policy.md`

- [ ] **Step 1: skill-usage-policy.md 전체 교체**

```markdown
# Skill Usage Policy

External AI skills may be used when they match the task and have been installed intentionally.

## Strategy

This repository does not vendor external skills. Skills from `everything-claude-code` or other external sources must be installed manually by each team using this template.

The `.claude/skills/` and `.codex/skills/` directories must not exist in this repository. Skills are not committed here.

## Rules

- Install external skills manually into your local Claude Code environment.
- Review skill instructions before relying on them.
- Do not treat external skills as project policy unless documented here.
- Record durable workflow changes in `docs/harness/` or `docs/knowledge/`.

## Documenting Skill Use

If a skill meaningfully changes how this project's workflow operates, add a note to `docs/knowledge/workflow.md` describing the effect.

## Exclusions

This template does not bundle external skills or configure automatic skill installation.
```

- [ ] **Step 2: 변경 사항 확인**

```bash
git status
git diff
```

- [ ] **Step 3: 커밋**

```bash
git add .github/workflows/ci.yml .github/pull_request_template.md \
  docs/harness/autonomy-levels.md docs/harness/orchestration-state-policy.md \
  docs/harness/README.md docs/harness/skill-usage-policy.md
git commit -m "feat: CI 자체검사 추가, autonomy/orchestration 정책 문서 추가, PR 템플릿 Autonomy Check 추가"
```

---

## Phase 2: fastapi 브랜치

### Task 5: fastapi — README 업데이트

**Files:**
- Modify: `README.md`

- [ ] **Step 1: fastapi 브랜치로 전환**

```bash
git checkout fastapi
```

Expected: `Switched to branch 'fastapi'`

- [ ] **Step 2: 현재 README 확인**

```bash
head -10 README.md
```

- [ ] **Step 3: README 상단에 브랜치 정체성 섹션 추가**

README.md 맨 위(첫 줄 `# AI-Assisted Project Template` 직후)에 다음 내용을 추가한다:

```markdown
> **Branch:** `fastapi` — FastAPI-specific variant with a minimal runnable FastAPI starter.
> Common Harness Engineering files are included. See `main` branch for the framework-agnostic template.
```

- [ ] **Step 4: README 끝에 검증 명령어 섹션 추가**

README.md 끝에 다음을 추가한다:

```markdown
## FastAPI Starter

This branch includes a minimal runnable FastAPI application.

### Verification

```bash
uv sync
uv run ruff check .
uv run mypy .
uv run pytest
```
```

---

### Task 6: fastapi — FastAPI 스타터 앱 추가

**Files:**
- Create: `app/__init__.py`
- Create: `app/main.py`
- Create: `tests/__init__.py`
- Create: `tests/test_health.py`
- Create: `pyproject.toml`

- [ ] **Step 1: app/__init__.py 생성**

빈 파일 생성:

```bash
touch app/__init__.py
```

- [ ] **Step 2: app/main.py 생성**

```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}
```

- [ ] **Step 3: tests/__init__.py 생성**

빈 파일 생성:

```bash
touch tests/__init__.py
```

- [ ] **Step 4: tests/test_health.py 생성**

```python
from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_health_returns_200() -> None:
    response = client.get("/health")
    assert response.status_code == 200


def test_health_returns_status_ok() -> None:
    response = client.get("/health")
    assert response.json() == {"status": "ok"}
```

- [ ] **Step 5: pyproject.toml 생성**

```toml
[project]
name = "template"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "fastapi>=0.115.0",
    "uvicorn[standard]>=0.32.0",
]

[dependency-groups]
dev = [
    "pytest>=8.0.0",
    "httpx>=0.28.0",
    "ruff>=0.9.0",
    "mypy>=1.13.0",
]

[tool.ruff]
target-version = "py312"

[tool.mypy]
python_version = "3.12"
ignore_missing_imports = true
```

- [ ] **Step 6: 의존성 설치**

```bash
uv sync
```

Expected: `.venv` 생성, 의존성 설치 완료

- [ ] **Step 7: lint 실행**

```bash
uv run ruff check .
```

Expected: 오류 없음 (exit 0)

- [ ] **Step 8: mypy 실행**

```bash
uv run mypy .
```

Expected: `Success: no issues found`

- [ ] **Step 9: pytest 실행**

```bash
uv run pytest
```

Expected:
```
2 passed
```

---

### Task 7: fastapi — 벤더링된 skills 제거

**Files:**
- Delete: `.claude/skills/` 전체
- Delete: `.codex/skills/` 전체
- Modify: `docs/harness/skill-usage-policy.md`
- Modify: `docs/harness/README.md`

- [ ] **Step 1: 현재 skills 디렉토리 확인**

```bash
ls .claude/skills/ && ls .codex/skills/
```

- [ ] **Step 2: .claude/skills 삭제**

```bash
git rm -r .claude/skills/
```

Expected: 각 SKILL.md 파일 삭제 확인

- [ ] **Step 3: .codex/skills 삭제**

```bash
git rm -r .codex/skills/
```

---

### Task 8: fastapi — 공통 harness 변경 동기화 및 커밋

**Files:**
- Create: `docs/harness/autonomy-levels.md`
- Create: `docs/harness/orchestration-state-policy.md`
- Modify: `docs/harness/README.md`
- Modify: `docs/harness/skill-usage-policy.md`
- Modify: `.github/pull_request_template.md`

- [ ] **Step 1: autonomy-levels.md 생성**

Task 2 Step 1과 동일한 내용으로 생성한다.

```markdown
# Autonomy Levels

This document defines the autonomy levels available in the AI-assisted development workflow.

## Levels

### Level 0: Manual

All work is performed by a human. AI tools are not used.

### Level 1: AI-Assisted

Claude Code and Codex assist with planning, drafting, and implementation. Humans review and approve every step before it proceeds.

Use when: the team is learning the workflow, or the task is High or Critical risk.

### Level 2: Semi-Autonomous

Claude Code plans, Codex implements, and CI verifies. Humans review PRs before merge.

Use when: the task is Low or Medium risk, scope is clearly defined, and verification commands exist.

## Default Level

This template operates at Level 2 for Low and Medium risk tasks. High and Critical risk tasks require Level 1 (human gate before implementation begins).

## Related

- `task-classification-policy.md` — risk levels
- `human-gate-policy.md` — gate conditions
```

- [ ] **Step 2: orchestration-state-policy.md 생성**

Task 2 Step 2와 동일한 내용으로 생성한다.

```markdown
# Orchestration State Policy

This document defines the workflow states from issue creation to merge.

## States

### Draft

The issue is created. Claude Code has not reviewed it yet.

Transition to: Review

### Review

Claude Code is analyzing the issue and assessing risk.

Transition to: Blocked (gate condition applies) or Ready (Low/Medium risk)

### Blocked

A human gate condition applies. Work cannot proceed until the human approves.

Transition to: Ready (after approval) or Cancelled (if rejected/deferred)

### Ready

Claude Code has created a Codex handoff task. Implementation can begin.

Transition to: In Progress

### In Progress

Codex is implementing.

Transition to: PR Open

### PR Open

A PR is open. CI runs. Claude Code runs a local review.

Transition to: PR Approved (CI passes, human approves) or PR Blocked (Claude review finds blocking issues)

### PR Blocked

Claude Code found blocking issues. Codex must respond.

Transition to: PR Open (after Codex addresses issues)

### PR Approved

The human has approved the PR.

Transition to: Merged

### Merged

Merged. Documentation impact assessed. ADRs, failure records, or knowledge updates created if needed.

### Cancelled

Work was rejected, deferred, or abandoned. Record reason in a failure record if worth remembering.

## Related

- `task-classification-policy.md`
- `human-gate-policy.md`
- `handoff-policy.md`
```

- [ ] **Step 3: docs/harness/README.md 업데이트**

Task 2 Step 3과 동일하게 두 문서 항목 추가.

- [ ] **Step 4: skill-usage-policy.md 업데이트**

Task 4 Step 1과 동일한 내용으로 교체.

- [ ] **Step 5: PR 템플릿 Autonomy Check 추가**

Task 3 Step 2와 동일하게 추가.

- [ ] **Step 6: 변경 사항 확인**

```bash
git status
```

Expected: 신규 파일, 수정 파일, 삭제 파일 모두 표시

- [ ] **Step 7: 커밋**

```bash
git add .
git commit -m "feat: FastAPI 스타터 추가, 벤더링 skills 제거, autonomy/orchestration 정책 문서 추가"
```

---

## Phase 3: spring-boot 브랜치

### Task 9: spring-boot — README 업데이트

**Files:**
- Modify: `README.md`

- [ ] **Step 1: spring-boot 브랜치로 전환**

```bash
git checkout spring-boot
```

Expected: `Switched to branch 'spring-boot'`

- [ ] **Step 2: README 상단에 브랜치 정체성 섹션 추가**

README.md 맨 위(첫 줄 `# AI-Assisted Project Template` 직후)에 다음 내용을 추가한다:

```markdown
> **Branch:** `spring-boot` — Spring Boot-specific variant with a minimal runnable Spring Boot starter.
> Common Harness Engineering files are included. See `main` branch for the framework-agnostic template.
```

- [ ] **Step 3: README 끝에 검증 명령어 섹션 추가**

README.md 끝에 다음을 추가한다:

```markdown
## Spring Boot Starter

This branch includes a minimal runnable Spring Boot application.

### Verification

```bash
./gradlew build
```

Requires Java 21.
```

---

### Task 10: spring-boot — Spring Boot 스타터 생성

**Files:**
- Create: `gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties`
- Create: `settings.gradle`, `build.gradle`
- Create: `src/main/java/com/example/template/TemplateApplication.java`
- Create: `src/main/java/com/example/template/HealthController.java`
- Create: `src/test/java/com/example/template/TemplateApplicationTests.java`
- Create: `src/test/java/com/example/template/HealthControllerTests.java`

- [ ] **Step 1: Spring Initializr로 스타터 다운로드**

임시 디렉토리에 프로젝트 생성:

```bash
curl -s https://start.spring.io/starter.tgz \
  -d type=gradle-project \
  -d language=java \
  -d bootVersion=3.4.1 \
  -d groupId=com.example \
  -d artifactId=template \
  -d name=template \
  -d packageName=com.example.template \
  -d packaging=jar \
  -d javaVersion=21 \
  -d dependencies=web \
  | tar -xz -C /tmp
```

Expected: `/tmp/template/` 디렉토리 생성됨

- [ ] **Step 2: 생성된 파일 목록 확인**

```bash
find /tmp/template -not -path '*/.git/*' | sort
```

Expected: gradlew, gradlew.bat, gradle/wrapper/, settings.gradle, build.gradle, src/ 등 확인

- [ ] **Step 3: Gradle wrapper 파일 복사**

```bash
cp /tmp/template/gradlew .
cp /tmp/template/gradlew.bat .
mkdir -p gradle/wrapper
cp /tmp/template/gradle/wrapper/gradle-wrapper.jar gradle/wrapper/
cp /tmp/template/gradle/wrapper/gradle-wrapper.properties gradle/wrapper/
chmod +x gradlew
```

- [ ] **Step 4: build.gradle, settings.gradle 복사 및 검토**

```bash
cp /tmp/template/build.gradle .
cp /tmp/template/settings.gradle .
cat build.gradle
cat settings.gradle
```

Expected: spring-boot-starter-web 의존성, settings.gradle에 rootProject.name = 'template' 확인

- [ ] **Step 5: 메인 애플리케이션 파일 복사**

```bash
mkdir -p src/main/java/com/example/template
mkdir -p src/test/java/com/example/template
mkdir -p src/main/resources
cp /tmp/template/src/main/java/com/example/template/TemplateApplication.java \
   src/main/java/com/example/template/
cp /tmp/template/src/main/resources/application.properties \
   src/main/resources/ 2>/dev/null || true
```

- [ ] **Step 6: HealthController.java 생성**

`src/main/java/com/example/template/HealthController.java`:

```java
package com.example.template;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthController {

    @GetMapping("/health")
    public Map<String, String> health() {
        return Map.of("status", "ok");
    }
}
```

- [ ] **Step 7: TemplateApplicationTests.java 복사**

```bash
cp /tmp/template/src/test/java/com/example/template/TemplateApplicationTests.java \
   src/test/java/com/example/template/
```

- [ ] **Step 8: HealthControllerTests.java 생성**

`src/test/java/com/example/template/HealthControllerTests.java`:

```java
package com.example.template;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(HealthController.class)
class HealthControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void healthReturns200() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk());
    }

    @Test
    void healthReturnsStatusOk() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(jsonPath("$.status").value("ok"));
    }
}
```

- [ ] **Step 9: 로컬 빌드 시도 (Java 17, 실패 예상)**

```bash
java -version 2>&1
```

Java 17이 설치되어 있어 Spring Boot 3.x 프로젝트(Java 21 타겟) 로컬 빌드는 실패할 수 있다.

로컬 검증 불가 시: CI(Java 21)에서 검증한다. `./gradlew build`는 커밋 후 GitHub Actions에서 확인.

---

### Task 11: spring-boot — 벤더링된 skills 제거

**Files:**
- Delete: `.claude/skills/` 전체
- Delete: `.codex/skills/` 전체

- [ ] **Step 1: 현재 skills 디렉토리 확인**

```bash
ls .claude/skills/ && ls .codex/skills/
```

- [ ] **Step 2: .claude/skills 삭제**

```bash
git rm -r .claude/skills/
```

- [ ] **Step 3: .codex/skills 삭제**

```bash
git rm -r .codex/skills/
```

---

### Task 12: spring-boot — 공통 harness 변경 동기화 및 커밋

**Files:**
- Create: `docs/harness/autonomy-levels.md`
- Create: `docs/harness/orchestration-state-policy.md`
- Modify: `docs/harness/README.md`
- Modify: `docs/harness/skill-usage-policy.md`
- Modify: `.github/pull_request_template.md`

- [ ] **Step 1: autonomy-levels.md 생성**

Task 2 Step 1, Task 8 Step 1과 동일한 내용으로 생성.

- [ ] **Step 2: orchestration-state-policy.md 생성**

Task 2 Step 2, Task 8 Step 2와 동일한 내용으로 생성.

- [ ] **Step 3: docs/harness/README.md 업데이트**

두 신규 문서 항목 추가 (Task 2 Step 3 참고).

- [ ] **Step 4: skill-usage-policy.md 업데이트**

Task 4 Step 1과 동일한 내용으로 교체.

- [ ] **Step 5: PR 템플릿 Autonomy Check 추가**

Task 3 Step 2와 동일하게 추가.

- [ ] **Step 6: .gitignore에 gradlew.bat 관련 확인 (선택)**

```bash
cat .gitignore 2>/dev/null || echo "no .gitignore"
```

- [ ] **Step 7: 변경 사항 최종 확인**

```bash
git status
git diff --stat
```

- [ ] **Step 8: 커밋**

```bash
git add .
git commit -m "feat: Spring Boot 스타터 추가, 벤더링 skills 제거, autonomy/orchestration 정책 문서 추가"
```

---

## Self-Review

### Spec Coverage Check

| 요구사항 | 처리 태스크 |
|----------|------------|
| main CI → 자체검사 | Task 1 |
| 누락 harness docs (autonomy-levels, orchestration-state) | Task 2, 8, 12 |
| PR 템플릿 Autonomy Check | Task 3, 8 Step 5, 12 Step 5 |
| skill-usage-policy 보강 | Task 4, 8 Step 4, 12 Step 4 |
| fastapi README 브랜치 정체성 | Task 5 |
| fastapi 스타터 (app/, tests/, pyproject.toml) | Task 6 |
| fastapi .claude/skills 제거 | Task 7 |
| fastapi .codex/skills 제거 | Task 7 |
| spring-boot README 브랜치 정체성 | Task 9 |
| spring-boot 스타터 (Gradle wrapper, src/) | Task 10 |
| spring-boot HealthController + 테스트 | Task 10 Steps 6-8 |
| spring-boot .claude/skills 제거 | Task 11 |
| spring-boot .codex/skills 제거 | Task 11 |
| 전 브랜치 공통 harness 동기화 | Task 2/3/4 (main), 8 (fastapi), 12 (spring-boot) |
| main에 앱 코드 추가 금지 | 해당 없음 (미추가) |
| docs 디렉토리 README 전략 유지 | 변경 없음 (이미 존재) |

### Known Risks

- **spring-boot 로컬 빌드 불가**: Java 17 설치됨, Java 21 필요. CI에서 검증 필요.
- **Gradle wrapper JAR**: Spring Initializr 생성물이므로 정당한 파일이나, CI에서 처음 실행 시 다운로드 소요 가능.
- **fastapi mypy**: `ignore_missing_imports = true` 설정으로 서드파티 stubs 누락 무시.
