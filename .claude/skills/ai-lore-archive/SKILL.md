---
name: ai-lore-archive
description: "Finish a focus — relocate its subtree to status/archive/; Human-Lead-invoked"
---

# archive

`archive` finishes a focus and relocates its subtree out of the active status tree. It is one of the three verbs that own the tree's structure — [`grow`](./grow.md) adds, [`advance`](./advance.md) moves status, `archive` finishes.

Archiving is the discipline pre-v0.7 lacked. A `done` focus that lingers in the active tree *is* the mess — the kind seen in the companion, where a shipped branch stayed marked `Active` long after it was finished. `archive` guarantees the invariant that makes the tree readable at a glance: **the active tree only ever holds live work.**

## The operation

1. **Ensure a mounted track.** The focus must be within the mounted track's claim, and must already be **`done`** — run [`advance`](./advance.md) to `done` first (a Human-Lead-confirmed move).
2. **Relocate the subtree.** Move the focus's whole folder — the focus, its stages, its phases — to `memory/status/archive/`, preserving its internal shape.
3. **Fix the indexes.** Remove the focus from the active root index's Children; add it under `archive/`'s index. Pure wiring, both ends.
4. **Settle the registry.** Drop the focus's row from [`status.stack.md`](../status.md#statusstackmd--the-focus-registry) — the live registry holds only un-archived focuses; the focus's record lives on under `archive/`.

## Human-Lead-invoked

`archive` is invoked by the Human Lead, not run by the session on its own — like [`merge`](./merge.md) and [`abandon`](./abandon.md), retiring work from the active surface is the Human Lead's act. The relocation is recoverable (git keeps the history), but the decision to file a focus away is the Human Lead's.

## Prerequisites

Read [`status.md`](../status.md) (the tree and the stack file) and [`memory.md`](../memory.md) (tree discipline) before archiving.
