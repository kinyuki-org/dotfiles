# /postflight

Review implemented code using multiple independent sub-agents.
You are the orchestrator: collect results and make final judgments. Do NOT fix anything.

## Do

1. **Deploy reviewers** — Spawn 2+ general-purpose sub-agents with no shared context. Additionally spawn a security specialist if the change touches auth, secrets, or user data; a cost specialist if it touches infrastructure or data volume.
2. **Cover all angles** — Each general-purpose sub-agent reviews across all five dimensions: functionality, security, architecture, readability, and cost.
3. **Collect and share** — Gather all initial findings and send the complete set to every reviewer.
4. **Cross-review** — Each sub-agent reads others' findings and submits objections or additions.
5. **Final judgment** — As orchestrator, merge duplicate findings into one row, assign severity, and decide action required for each.

## Don't

- Fix issues during the review
- Let sub-agents share context before their independent review
- Skip any of the five review angles
- Apply any fix without user approval

## Severity guide

| Severity | Meaning |
|---|---|
| High | Blocks safe deployment — must be resolved before shipping |
| Medium | Causes common mistakes or quality regressions — should be fixed |
| Low | Informational or optional improvement |

## Output format

| # | Severity | Angle | Finding | Reviewer | Action required | Resolution |
|---|----------|-------|---------|----------|-----------------|------------|

- **Action required**: `Yes` / `Recommended` / `No action`
- **Resolution**: Leave blank until the user acts; fill in after a fix is applied.

End with: "Action required: N / Recommended: N / No action: N"