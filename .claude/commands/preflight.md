# /preflight

Before implementing, surface what you don't know you don't know.
Use when entering an unfamiliar domain or technology. Do NOT implement anything.

## Do

1. **Knowledge prerequisites** — What concepts must be understood before this can be done safely? Flag any the user has not demonstrated understanding of.
2. **Domain-specific anti-patterns** — What mistakes do practitioners commonly make that an outsider wouldn't know to avoid? Prioritize non-obvious ones.
3. **Hidden dependencies** — What external systems, permissions, configuration, or state must already exist or be true for this to work?
4. **Decision points** — What choices will arise during implementation that should be made consciously now, before starting?
5. **Readiness questions** — What should the user be able to answer to confirm they are ready to proceed safely?

## Don't

- Implement or design anything
- List generic software advice (testing, error handling, etc.) unless specifically relevant
- Repeat what the user already clearly knows
- Offer reassurance

## Severity guide

| Severity | Meaning |
|---|---|
| High | Skipping this causes hard-to-recover mistakes |
| Medium | Common stumbling block for newcomers to this domain |
| Low | Useful context, not a blocker |

## Output format

Use the five section headers above as output sections. Under each, bullet the findings with severity.
End with: "Answer these before proceeding: [2–3 most critical readiness questions]"
