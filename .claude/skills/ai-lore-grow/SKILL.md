---
name: ai-lore-grow
description: "Add a node to the status tree — level inferred from the attach point (focus / stage / phase)"
---

# grow

`grow` adds a node to the status tree. It is one of the three verbs that own the tree's **structure** — `grow` adds, [`advance`](./advance.md) moves a focus's status, [`archive`](./archive.md) finishes a focus. The status tree can be grown *only* through this verb; free-form structural editing is refused for every track (see [`status.md`](../status.md#the-tree-is-verb-only)). `grow` is full-track work — it is not available to light or trackless sessions.

`grow` exists because the tree's shape is load-bearing — three positional levels, depth-names-the-level, never skip or rename, every level a folder with a spec index. A verb with a fixed step-list guarantees those invariants on every add; a free-hand edit cannot, which is exactly how the action tree rotted.

## The level is inferred from the attach point

You name *where* the node attaches; `grow` infers *what* it is:

- attach at the status-tree root → a **focus** (L1)
- attach under a focus → a **stage** (L2)
- attach under a stage → a **phase** (L3)

There is no fourth level — attaching under a phase is refused. There is no skipping — you cannot ask for a phase directly under a focus. The level is a pure function of depth, so there is nothing to get wrong.

## The operation

1. **Ensure a mounted track.** Writing the tree is a write — if trackless, [`mount`](./mount.md) fires. The attach point must be within the mounted track's claim.
2. **Resolve the level** from the attach point (root → focus, focus → stage, stage → phase). Refuse if it would exceed three levels or skip one.
3. **Create the node's folder and a spec-compliant index** — the standard `*.index.md` three-section grammar, **pure wiring**, no narrative.
4. **Scaffold the body file** with the type's schema (focus → gate/vision, context, stack, active-child, claim; stage/phase → intent, gate, stack). The body is scaffolded empty; its prose is filled afterward through [`write-lore`](./write-lore.md).
5. **Wire the parent's index** — add the new node to the parent's Children section.
6. **For a focus, register it** — add a row to [`status.stack.md`](../status.md#statusstackmd--the-focus-registry) with status `draft` and a blank active-mark.

Every step is structural. `grow` never writes node *bodies* (that is `write-lore`) and never writes the Payload.

## Prerequisites

Read [`status.md`](../status.md) (the tree shape and the stack file) and [`memory.md`](../memory.md) (the node schema and tree discipline) before growing.
