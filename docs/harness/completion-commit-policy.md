# Completion, Commit, and CI Response Policy

## Purpose

Defines what happens the moment Claude Code judges a unit of work complete: how it is classified, committed, pushed, opened as a PR, and how CI failures are handled afterward.

## When Claude Code Judges Work Complete

This applies to work Claude Code itself produced (for example, documentation, plans, policy updates) as well as work completed through a Codex handoff. It does not change who is allowed to implement: Codex remains the default implementer per `agent-role-policy.md`.

## Step 1: Classify

Before committing, classify the change using two labels:

- **Commit type** — one of `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, matching the Conventional Commits style already used in this repository's history.
- **Risk level** — Low, Medium, High, or Critical, per `task-classification-policy.md`.

If a single unit of work mixes unrelated commit types (e.g., a doc update bundled with an unrelated code fix), split it into separate commits, one per type. Do not bundle unrelated changes into one commit to save time.

## Step 2: Commit

- Commit message language: Korean.
- Format: `type: 본문` (matches the user's global commit convention).
- One commit per classified unit of work from Step 1.
- Never bundle changes that touch protected files with changes that do not, even if both are low risk.

## Step 3: Push and Open a PR

- `main`, `fastapi`, and `spring-boot` are protected: direct push is rejected by repository rules. Push to a feature branch (e.g., `docs/<topic>`, `feat/<topic>`, `fix/<topic>`) and open a PR with `gh pr create` targeting the correct base branch.
- **Be careful with the base branch when stacking PRs.** If a PR's base is an intermediate feature branch rather than the intended long-lived branch, it merges into that intermediate branch and its changes may never reach the long-lived branch. Set each PR's base to the intended long-lived branch, or retarget a follow-up PR's base once the preceding PR has merged.
- **Labels are required.** Attach labels at creation with `gh pr create --label`. Inherit the labels of the issue(s) the PR resolves; if there is no source issue, label by area and change type (at minimum the commit type, e.g., `docs`).
- PR body should summarize what changed and reference the source issue or handoff task if one exists.
- **Closing keyword is required.** For every issue the PR resolves, include a `Closes #N` line in the PR body. Multiple issues use one `Closes #N` per line.
- **PR Summary issue grouping.** Group summary bullets by issue. A single-issue PR omits per-bullet issue tags (the title already carries the issue number); a multi-issue PR groups bullets under a bold per-issue header.
- Claude Code does not approve or merge the PR it opens. Human approval is still required per `local-review-policy.md`.

### PR Body Format

Every PR body uses the same sections in the same order so PRs read consistently no matter who or what opens them. Keep it lean — prose over checklist — and scale each section to the change.

1. **Title** — `type: <title>`, using the same Conventional Commit type as the commit(s).
2. **`## Summary`** — one to three sentences on what the PR does and why, not a bare label.
3. **`## Changes`** — the concrete changes as bullets, grouped by issue per the grouping rule above.
4. **`## Verification`** — the local verification result (this branch's lint/typecheck/test/build commands and their outcome) and CI status.
5. **`## Related`** — `Closes #N` for every issue the PR resolves (one per line), plus links to any parallel or stacked PRs.
6. **Closing line** — `Final merge authority rests with the human.`

This is the same structure as `.github/pull_request_template.md`. Governance gates (protected-file changes, risk level, documentation impact, human gate) stay enforced by their own policies; surface them inside `## Summary` or `## Changes` when they apply rather than as a separate checklist.

## Step 4: CI Failure Response

When CI fails on a PR:

1. **Claude Code investigates first.** Read the CI failure log, the PR diff, the related Codex handoff (if any), and `.codex/instructions.md`. Identify the root cause — do not guess or paper over symptoms.
2. **Claude Code documents the cause**, either in a new or updated Codex handoff task, or inline using `.codex/prompts/fix-ci-failure.md`, stating: what failed, why, and the expected fix direction.
3. **Codex implements the fix.** Claude Code does not edit implementation code to satisfy CI directly — that responsibility stays with Codex per `agent-role-policy.md`, unless the human has explicitly asked Claude Code to implement.
4. **Re-verify.** After Codex pushes a fix, re-check CI. Repeat from step 1 if it fails again. Do not weaken tests, lint, typecheck, or build rules to make CI pass.
5. **Record repeat failures.** If the same root cause recurs across PRs, create a failure record per `docs/failures/`.

## Related

- `task-classification-policy.md` — risk classification used in Step 1.
- `handoff-policy.md` — handoff structure used when Codex must fix CI failures.
- `feedback-loop-policy.md` — the broader issue-to-merge loop this policy fits into.
- `agent-role-policy.md` — why Claude Code does not implement fixes by default.
