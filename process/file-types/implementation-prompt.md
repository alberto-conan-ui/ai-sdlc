# NN-description.md (Implementation Prompt)

**Type name:** implementation-prompt
**File:** `NN-description.md` (e.g., `01-map-all-routes.md`)
**Location:** `action-tree/<action>/phases/N-name/`
**Required:** Yes — one per prompt in the plan
**Created by:** Tech Lead (writes just-in-time, not all upfront)
**Maintained by:** Tech Lead; the Developer executes it

---

## Purpose

A detailed, self-contained instruction for one bounded piece of implementation work. The Developer receives this prompt and executes it literally — no improvisation, no broader context. Each prompt has a clear goal, specific steps, explicit rules for handling unexpected situations, and verification criteria.

Sits flat in the phase folder alongside phase.md and prompt-plan.md.

---

## Format

```markdown
# Prompt NN — <Short Description>

> Phase: N — <Name>
> Prereqs: Prompt NN-1 complete (or "None")

## Goal

<One paragraph: what this prompt achieves.>

## Steps

<Numbered, specific steps. File paths, code to change, commands to run.>

## If unexpected

<Per-prompt rules for handling discrepancies. What to adapt, what to flag, what to STOP on.>
- <condition> → adapt silently, note in receipt
- <condition> → STOP, report back
- <condition> → adapt if intent is clear, flag in receipt

## Verify

<Exact commands. Expected output. What success looks like.>

## Done when

- [ ] <criterion>
- [ ] <criterion>
```

---

## Naming

`NN-kebab-case-description.md` — the number is the sequence position from the prompt plan, the description is a short imperative phrase.

Examples: `01-test-infrastructure.md`, `02-implement-refresh-endpoint.md`, `03-update-client-sdk.md`.

---

## Notes

- Write prompts just-in-time: the Tech Lead writes prompt N+1 only after reviewing prompt N's receipt. This lets each prompt incorporate what the previous one actually produced.
- The "If unexpected" section is critical — it prevents the Developer from improvising when reality doesn't match the plan.
- See [prompts.md](../prompts.md) for the full prompting philosophy and guidelines.
