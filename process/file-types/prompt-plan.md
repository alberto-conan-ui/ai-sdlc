# prompt-plan.md

**Type name:** prompt-plan
**File:** `prompt-plan.md`
**Location:** `action-tree/<action>/phases/N-name/prompt-plan.md`
**Required:** No — optional for simple actions with 1-2 prompts
**Created by:** Tech Lead
**Maintained by:** Tech Lead updates as the sequence evolves
**Used by:** Tech Lead (produces before writing the first detailed prompt)

---

## Purpose

Sequences the implementation prompts for a phase before any detailed prompt is written. A high-level plan that answers: how many prompts, in what order, with what dependencies and risks. The Tech Lead produces this before writing the first detailed prompt.

Sits flat in the phase folder alongside phase.md.

---

## Format

```markdown
# Prompt Plan — Phase N

| # | Goal | Dependencies | Risk |
|---|---|---|---|
| 01 | <bounded goal in one line> | None | Low / Medium / High — <reason if not Low> |
| 02 | <bounded goal> | 01 complete | <risk> |
| 03 | <bounded goal> | 02 complete | <risk> |
```

---

## Notes

- For simple actions with 1-2 prompts, the plan is optional — just write the prompt directly.
- Each row represents one implementation prompt (`NN-description.md`).
- See [prompts.md](../prompts.md) for the full just-in-time prompting model.
