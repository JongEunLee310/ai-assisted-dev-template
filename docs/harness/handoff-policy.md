# Handoff Policy

Claude Code hands implementation work to Codex using `.codex/task-template.md`.

When the change introduces a new domain, table, external dependency, or architectural decision, a design record must exist before handoff, per `design-record-policy.md`. Reference it from the handoff task.

## Required Fields

- Source Issue
- Task Summary
- Goal
- Background
- Implementation Scope
- Out of Scope
- Protected Files
- Requirements
- Test Requirements
- Verification Commands
- Documentation Impact
- ADR Need
- Failure Record Need
- Risk Level
- Expected Output
- Rules

## Stop Conditions

Claude Code should stop instead of handing off when:

- The issue goal is unclear.
- Required decisions are architectural and unresolved.
- A design record is required per `design-record-policy.md` but has not been written.
- Protected file changes are needed but not approved.
- Verification expectations are missing.
- Risk is high and human approval is needed.
- The requested change conflicts with existing policy.

## Handoff Quality

A good handoff is narrow, testable, and explicit about what Codex must not change.
