---
name: fix-ci
description: Analyze and fix GitHub Actions CI errors. Use when the user says "CI is failing", "fix the GitHub Actions error", or "fix CI on PR #XXX".
---

# Fix CI

Fetch GitHub Actions CI error logs, identify the root cause, and apply fixes.

## Arguments

- `<pr-number or actions-url>` (required): PR number with failing checks, or a GitHub Actions run URL

## Workflow

### Phase 1: Fetch Error Logs

For a PR number:
```bash
gh pr checks <number>
gh run view <run-id> --log-failed
```

For an Actions URL:
```bash
gh run view <run-id> --log-failed
```

1. Identify the failed job and step
2. Extract the relevant portion of the error log

### Phase 2: Root Cause Analysis

Classify the error:

| Category | Examples | Response Pattern |
|----------|----------|-----------------|
| Compile error | Type errors, missing imports | Fix the code |
| Test failure | Assertion failure | Fix the test or implementation |
| Lint/Format | golangci-lint, prettier | Run the formatter |
| Dependencies | go.sum mismatch, lockfile | Run dependency update commands |
| Environment/Config | CI config mistake, permissions | Consult the user |
| Flaky | Timeout, external dependency | Report to the user |

### Phase 3: Fix

1. Report the cause and proposed fix to the user
2. Code-related errors: create a fix commit
3. Environment/Flaky errors: propose a plan (do not auto-fix)
4. Push and re-trigger CI

### Phase 4: Verify

1. Check CI results with `gh pr checks <number>`
2. If still failing, loop back to Phase 1 (max 3 iterations)
3. After 3 attempts without resolution, report status and ask the user for direction

## Principles

- **Never auto-fix environment/config errors — consult the user**
- Do not enter retry loops for flaky tests (report the cause instead)
- Changes to CI config files (`.github/workflows/`) require user approval
- Prefix fix commit messages with `fix(ci):`
