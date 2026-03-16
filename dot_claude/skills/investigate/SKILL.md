---
name: investigate
description: Investigate a technical topic and compile improvement proposals. Create GitHub Issues after approval. Use when the user says "investigate XXX", "look into this", or "propose improvements for".
---

# Investigate

Investigate a technical topic or codebase concern, compile structured proposals, and create GitHub Issues after user approval.

## Arguments

- `<topic>` (required): The technical topic or concern to investigate
- `--create-issue`: Proceed to Issue creation after investigation

## Workflow

### Phase 1: Scope Confirmation

1. Confirm the investigation scope with the user:
   - What do they want to learn or improve?
   - Depth: overview or detailed analysis?
   - Constraints: timeline, compatibility, dependencies

### Phase 2: Investigation

Use Agents for parallel investigation:

1. **Codebase analysis**: Identify related code, understand current implementation
2. **External references**: Consult documentation and best practices as needed
3. **Impact assessment**: Check change impact with `findReferences` etc.

### Phase 3: Investigation Report

Present findings in this structure:

```markdown
## Investigation Report: <topic>

### Current State
- <summary of current implementation/state>

### Issues / Improvement Opportunities
1. <issue>: <impact/risk>
2. ...

### Proposals
| # | Proposal | Benefit | Effort | Risk |
|---|----------|---------|--------|------|
| 1 | ... | ... | S/M/L | ... |

### Recommended Approach
- <most recommended path forward>

### Next Steps
- [ ] Create Issue(s)
- [ ] Draft implementation plan
```

### Phase 4: Issue Creation (after user approval)

1. Create Issue(s) with `gh issue create`
2. Assign appropriate labels and milestones
3. If the work should be split into multiple Issues, suggest that

## Principles

- **Always present findings and get user approval before taking further action**
- Issue creation requires explicit user approval
- Follow `rules/security.md` protocol for any security issues discovered
- Explicitly label speculation and hypotheses ("Hypothesis:", "Needs verification:")
