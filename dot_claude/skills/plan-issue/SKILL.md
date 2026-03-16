---
name: plan-issue
description: Create an implementation plan from a GitHub Issue and start work. Runs the full Issue-driven development workflow end-to-end. Use when the user says "work on Issue #XXX", "plan #XXX", or "implement this Issue".
---

# Plan Issue

Run the full workflow from a GitHub Issue: investigate, plan, and start implementation.

## Arguments

- `<issue-number>` (required): GitHub Issue number (e.g., `123`, `#123`)
- `--start`: After plan approval, proceed to set up the work environment (create bookmark, begin implementation)

## Workflow

### Phase 1: Understand the Issue

1. Fetch Issue content with `gh issue view <number>`
2. Check labels, milestone, and related Issues
3. Extract requirements, constraints, and acceptance criteria

### Phase 2: Codebase Investigation

1. Identify code related to the Issue (use Agents for parallel investigation)
   - Files and functions to be changed
   - Dependent code affected (`findReferences`)
   - Existing test coverage and scope
2. Report findings to the user concisely

### Phase 3: Implementation Plan

Create and present the plan in this structure:

```markdown
# Implementation Plan: <Issue title>

## Context
- Issue: #<number>
- Goal: <one line>

## Tasks
- [ ] Task 1: <specific change>
  - File: `path/to/file`
  - Change summary: ...
- [ ] Task 2: ...

## Risks / Open Questions
- <risks or unknowns>

## Test Strategy
- <testing approach>
```

### Phase 4: Start Work (`--start` or after user approval)

1. Create bookmark: `issue-<number>-<short-description>`
2. Begin TDD implementation starting from Task 1
3. Commit per task (`jj describe` then `jj new`)

## Principles

- **Get user approval before moving from plan to implementation** (always confirm at Phase 3)
- If investigation reveals significant deviation from the Issue's assumptions, suggest commenting on the Issue
- Plan granularity should map to commits (1 Task ≈ 1 commit)
- Follow `rules/github-workflow.md` for naming and PR creation
- Follow `rules/testing.md` for TDD principles
