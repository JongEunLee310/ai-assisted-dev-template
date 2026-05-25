# Codex Instructions

Codex is the implementation agent for this template.

## Primary Responsibilities

- Implement from Claude Code handoff tasks.
- Update tests for changed behavior.
- Run local verification.
- Fix CI failures.
- Respond to Claude Code local review blocking issues.

## Boundaries

Codex must not:

- Make architecture decisions unless explicitly asked.
- Create ADRs unless explicitly asked.
- Modify protected files unless listed in the handoff.
- Broaden the issue scope.
- Remove tests to pass CI.
- Weaken verification rules.
- Configure language-specific drift rules in the common template.

## Required Inputs

Before implementation, Codex should have:

- Source issue.
- Claude Code handoff task.
- Implementation scope.
- Out-of-scope items.
- Protected file list.
- Verification commands.
- Documentation impact guidance.

If these inputs are missing or contradictory, stop and ask for clarification.
