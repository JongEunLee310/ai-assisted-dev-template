# Design Record Policy

## Purpose

Defines when a design record must be written before a Codex handoff, and what it must contain. A design record captures the shape of a change — data model, API surface, and component responsibilities — so implementation does not silently invent an architecture.

## When a Design Record Is Required

Write a design record before handoff when the change introduces any of:

- A new domain or bounded context.
- A new table or persisted model.
- A new external dependency (third-party API, queue, storage, service).
- An architectural decision that affects how later work is structured.

## When It Can Be Skipped

Skip the design record for pure test changes, documentation-only changes, and contained bug fixes that do not alter the data model, API surface, or dependencies.

## Location and Naming

`docs/designs/<issue>-<slug>.md`

One file per issue. `<slug>` is a short kebab-case summary of the change.

## Content Rules

Keep the record at skeleton level. Describe structure, not implementation.

- **Models** — fields with type and constraints only.
- **APIs** — method, path, and request/response schema name only.
- **Services / repositories** — signature plus a one-line responsibility each.

Do not include SQL, query bodies, migrations, or business-logic code. If a detail belongs in implementation, it does not belong in the design record.

## Timing

The design record is written before the Codex handoff and referenced from the handoff task, so Codex implements against an agreed shape.

설계 문서의 데이터 계약 리터럴(enum 값·필드 형식·경계값·키 스킴)에는 출처를 명시하고,
출처를 댈 수 없는 값은 "가정"으로 표기한다. 상세는 `quality-process-policy.md`의 Design
Fact Grounding을 따른다.

## Related

- `handoff-policy.md` — design records are an input to the handoff.
- `quality-process-policy.md` — 리터럴 계약의 출처 명시와 셀프 검토 체크포인트.
- `docs/decisions/` — ADRs capture *why* a durable decision was made; design records capture *what shape* a specific change takes.
- `docs/designs/README.md` — directory conventions and skeleton template.
