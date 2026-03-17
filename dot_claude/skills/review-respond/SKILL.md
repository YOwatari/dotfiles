---
name: review-respond
description: Fetch PR review comments and propose/implement responses. Use when the user says "address review comments", "respond to PR #XXX review", or "handle review feedback".
---

# Review Respond

Fetch review comments on a PR, propose a response plan for unresolved comments, then implement fixes after user approval.

## Arguments

- `<pr-number>` (required): Pull Request number

## Workflow

### Phase 1: Collect Comments

1. Get PR repo info (`gh pr view <number> --json url,headRefName`)
2. Fetch review comments:
   ```bash
   gh api repos/{owner}/{repo}/pulls/<number>/reviews
   gh api repos/{owner}/{repo}/pulls/<number>/comments
   ```
3. Extract and categorize unresolved comments

### Phase 2: Present Response Plan

Present each comment to the user in this format:

```markdown
## Review Comment Response Plan

### 1. <comment summary> (@reviewer)
> <original comment quote>

**Target**: `path/to/file:line`
**Plan**: <proposed response, concisely>
**Effort**: S / M / L

### 2. ...
```

- Add rationale for comments deemed no-action-needed
- Offer multiple options for ambiguous comments

### Phase 3: Implement (after user approval)

1. Move to the PR's bookmark in `jj`
2. Separate commits by comment or by file
3. Include the addressed comment in each commit message
   - e.g., `fix: address review comment - validate input before processing`
4. Push with `jj git push --bookmark <bookmark-name>`

### Phase 4: Reply Drafts (optional)

After pushing, present draft reply text for each comment.
Never post replies on GitHub without explicit user confirmation.

## Principles

- **Present the full response plan before starting any fixes**
- Ask the user for clarification when reviewer intent is unclear
- Keep commit granularity traceable to individual comments
- Posting replies on GitHub requires explicit user approval
