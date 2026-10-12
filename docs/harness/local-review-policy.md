# Local Review Policy

Claude Code review happens after PR creation.

The review is local by default, not a GitHub Actions job. This template does not configure Claude GitHub Action.

## Review Scope

Claude Code should review:

- PR diff.
- Related issue.
- Codex handoff task.
- CI result.
- Protected file changes.
- Documentation impact.
- ADR need.
- Failure Record need.
- Domain knowledge impact.

## Review Records

The review is written to a durable, versioned file:

`docs/reviews/pr-<number>.md`

This file is committed, not a throwaway under `tmp/`. The PR conversation remains the place to publish the review for discussion, and reusable findings should still be promoted into docs, ADRs, failure records, or the knowledge base.

## Review Format

리뷰 기록은 `local-review-template.md`의 골격을 그대로 사용해 작성한다. 템플릿은 아래 고정
7섹션을 실제 문서 형태로 구체화하고, 제목 줄 형식·발견 사항 표기·섹션별 서술 관례까지
정의한다. 임의로 섹션을 간소화하거나 자체 형식을 만들지 않는다.

Every review record uses the same section order and headers:

1. `## Review Summary`
2. `## Blocking`
3. `## Suggestions`
4. `## Questions`
5. `## CI Result`
6. `## Documentation Impact`
7. `## Final Recommendation`

Use the fixed headers even when a section is empty (state "None").

### Depth and Substance

The fixed headers are a skeleton; each section should carry real substance rather than a bare label. Scale the depth to the change — a small PR gets a short record, a substantial one a fuller record — while holding to these conventions:

- **Review Summary** — Explain in prose what the PR does and how: what existing code it reuses, what is newly added, the core mechanism, and the key boundary or design decision it turns on. A reader should grasp the change without opening the diff.
- **Numbered, self-contained findings** — Label findings so they can be referenced later: `B1`, `B2`, … under Blocking, `S1`, `S2`, … under Suggestions, and `Q1`, `Q2`, … under Questions. Write each as a **bold one-line title** followed by its rationale and an explicit severity/scope judgment (whether it blocks, whether it is acceptable within the current scope, or why a choice was unavoidable). Do not leave a finding as a bare observation.
- **Ground each judgment** — Tie findings back to their basis: the design decision, handoff task, issue, or spec section that supports the call, so the reasoning is auditable rather than opinion.
- **CI Result with concrete evidence** — State the actual command outputs and counts (tests passed, files typechecked, single migration head, and so on), not just "passed". Concrete numbers let a reader confirm the verification was real.
- **Final Recommendation with reasoning** — Give the merge-readiness judgment and why: scope held, regression risk, what the added tests cover. Restate the outcome (for example, Blocking none; Suggestions and Questions are follow-up) so the merge decision is unambiguous.
- **Honest severity** — Keep the Blocking / Suggestions / Questions split truthful. Blocking is a must-change-before-merge item; Suggestions are optional or follow-up; Questions need author or human input. Never inflate a follow-up into a blocker, and never bury a real blocker under Suggestions.

### Cross-Model Review

구현자의 자기 검증과 CI와 별개로, 구현에 관여하지 않은 다른 모델의 독립 리뷰를 로컬
리뷰에 추가한다. 상세는 `quality-process-policy.md`의 Cross-Model Review를 따른다.

## Handling Review Feedback

When Codex addresses review feedback, it does **not** open a new PR. It pushes the fix to the same feature branch, which updates the existing PR, and the follow-up is recorded as a new comment on the same PR. Do not fragment a single review cycle across multiple PRs.

## Approval

Claude Code must not approve PRs automatically. Human reviewers own final approval.
