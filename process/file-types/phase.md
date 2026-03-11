# phase.md

**Type name:** phase
**File:** `phase.md`
**Location:** `action-tree/<action>/phases/N-name/phase.md`
**Required:** Yes — one per phase
**Created by:** Tech Lead
**Maintained by:** Tech Lead updates as understanding evolves; Human Lead approves

---

## Purpose

The phase design document. Defines what this phase achieves, the concrete steps to get there, how to validate success, and the done criteria. Self-contained — a new reader should understand this phase without reading other files.

Sits flat in the phase folder alongside prompt-plan.md and the numbered prompt files.

---

## Format

```markdown
# Phase N — <Name>

> Action: <action path>
> Status: Planning | Implementing | Complete
> Revision: v1

## Problem / Goal

<What this phase achieves and why it matters now.
Self-contained — a new reader should understand this without reading other files.
Reference the action this phase serves.>

## Steps

<Numbered concrete steps. File paths, code references, specific changes.>

## Test Cases / Validation

<How we know it's correct. Specific inputs and expected outputs where possible.>

## Done Criteria

Technical completion:
- [ ] <criterion>
- [ ] <criterion>
- [ ] Tests pass
- [ ] Type-checker clean

Action evaluation:
- [ ] Human Lead confirms this phase moves toward the action's gatekeep
```

---

## Notes

- Phase status indicators: `Planning`, `Implementing`, `Complete`.
- The revision field tracks significant rewrites — bump it when the phase scope changes meaningfully.
- See [prompts.md](../prompts.md) for how phases relate to the just-in-time prompting model.
