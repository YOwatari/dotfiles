# GitHub Workflow

Rules for GitHub Issue / PR integration. See `rules/jj-practice.md` for jj operation details.

## Starting Work from an Issue

1. Run `gh issue view <number>` to understand the Issue
2. Name the bookmark `issue-<number>-<short-description>` (e.g., `issue-123-add-redirect`)
3. Create a draft PR after implementation is complete

## PR Creation

- Always create as draft with `gh pr create --draft`
- Only the user marks PRs as ready (Claude must never run `gh pr ready`)

### Title

- Match the Issue title (adjust for brevity if needed)
- No prefix needed (use GitHub Labels for categorization)

### Body

```markdown
## Summary
- Summary of changes (1-3 bullet points)

## Test plan
- [ ] Test items

Closes #<Issue number>
```

- Use `Closes #XXX` to auto-close the Issue
- Use `Relates to #XXX` when related to multiple Issues without auto-close

## Linking PRs to Issues

- `Closes #XXX` in the PR body auto-links the Issue
- When auto-close is not desired, use `gh pr edit <number> --add-issue <issue-number>` to link via the Development field

## Responding to Review Comments

1. Fetch unresolved comments with `gh api repos/{owner}/{repo}/pulls/<number>/comments`
2. Present the response plan to the user before starting fixes
3. Separate commits by comment or by file
4. After pushing, reply to the review thread (only after user confirmation)

## Rebasing onto master

```bash
jj git fetch
jj rebase -d main
# Resolve conflicts if any
jj git push --bookmark <bookmark-name>
```

## Never Do

- Start implementing without reading the Issue
- Run `gh pr ready` (only the user does this)
- Address review comments without user approval
