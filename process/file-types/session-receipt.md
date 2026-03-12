# NN-description.receipt.md (Session Receipt)

**Type name:** session-receipt
**File:** `NN-description.receipt.md` (e.g., `01-map-all-routes.receipt.md`)
**Location:** `action-tree/<action>/phases/N-name/`
**Required:** Yes — one per prompt executed
**Created by:** Developer (produced at the end of each implementation session)
**Maintained by:** Read by Tech Lead to inform the next prompt
**Used by:** Developer (sole output)

---

## Purpose

Formal record of what a Developer session actually produced, paired with its implementation prompt by name. The receipt bridges consecutive prompts: the Tech Lead reads it before writing the next prompt, and the next prompt's preamble references it. This keeps the chain of implementation grounded in reality rather than plans.

The session receipt is the Developer's sole contribution to the recording system. The Developer is exempt from all other recording duties — no log entries, no KEY_INSIGHTS, no journal entries, no STATUS.md updates. This isolation is by design — it keeps the Developer focused on literal execution.

Sits flat in the phase folder alongside its paired prompt file.

---

## When to Write

At the end of every Developer session — no exceptions. If the Developer executed a prompt, it produces a receipt.

---

## Format

```markdown
# Session Receipt — NN-description

- **Role:** Developer
- **Prompt:** NN — <Short Description>
- **Status:** Complete / Partial / Blocked
- **Accomplished:** <what was done>
- **Files created/modified:** <paths>
- **State changes:** <structural changes the next prompt needs to know — new directories, changed exports, renamed files, altered type signatures>
- **Open issues:** <anything unexpected, flagged discrepancies, adaptations made>
```

---

## Naming

Mirrors its implementation prompt: if the prompt is `01-map-all-routes.md`, the receipt is `01-map-all-routes.receipt.md`.

---

## Notes

- **State changes** is the most important field for subsequent prompts: it tells the Tech Lead what actually changed in the codebase structure.
- **Open issues** captures anything the Developer adapted, flagged, or stopped on per the "If unexpected" rules.
- See [prompts.md](../prompts.md) for how receipts feed the just-in-time prompting loop. See [journaling.md](../journaling.md) for the recording system.
