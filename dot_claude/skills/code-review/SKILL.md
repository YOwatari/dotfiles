---
name: code-review
description: Autonomous code review for evaluating generated or modified code. Triggers when producing substantial code, completing features, or before finalizing changes. Uses confidence scoring to ensure actionable feedback.
---

# Code Review Skill

Structured review methodology with confidence-based filtering for actionable feedback.

## Trigger Conditions

**Required**: >50 lines generated/modified, feature completion, bug fixes, critical path changes (auth, payments, data)

**Skip**: Trivial changes (<10 lines with obvious correctness), documentation-only, formatting-only

## Review Process

### 1. Scope Assessment

Identify changed files, change type (feature/bugfix/refactor), and locate project guidelines (CLAUDE.md, README.md).

### 2. Multi-Perspective Analysis

**Always apply:**
- **Bugs**: Logic errors, null handling, edge cases, race conditions, silent failures
- **Security**: Input validation, auth gaps, injection risks, data exposure
- **Quality**: Separation of concerns, error handling, DRY, readability
- **History**: Breaking changes, regression risks, pattern consistency

**Conditional:**
- **Tests**: When test files changed—coverage of critical paths and edge cases
- **Contracts**: When APIs/types changed—type safety, backward compatibility, data model consistency

### 3. Confidence Scoring

Score each issue 0-100:

| Score | Meaning |
|-------|---------|
| 0 | False positive or pre-existing |
| 25 | Unverified, possibly false positive |
| 50 | Real but minor or rare |
| 75 | Verified, impacts functionality or in guidelines |
| 100 | Certain, frequent, evidence confirms |

**Report only issues ≥80.**

### False Positives to Exclude

- Pre-existing in unchanged code
- Caught by linters/CI (imports, types, formatting)
- Pedantic nitpicks
- General concerns not in project guidelines
- Silenced with ignore comments
- Intentional changes related to the task

## Issue Severity

| Level | Criteria | Action |
|-------|----------|--------|
| Critical | Runtime errors, security vulnerabilities, data loss | Must fix |
| Important | Edge case failures, missing validation, test gaps | Should fix |
| Minor | Style, docs, optimization opportunities | Consider |

## Output

Report issues with: file path, line numbers, description, evidence, severity, and fix guidance.

**Quality Gate**: Any Critical/High security issue = not ready.

## Principles

1. **Security first**: Block on critical security issues
2. **Quantify**: Numbers, not "some" or "many"
3. **Pragmatic**: Real issues over theoretical ones
4. **Scale**: >500 lines → prioritize architecture/security over style
5. **Actionable**: Every issue needs clear fix guidance
6. **Velocity**: Catch real bugs, don't block on minor style
