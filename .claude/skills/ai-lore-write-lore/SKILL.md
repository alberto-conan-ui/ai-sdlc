---
name: ai-lore-write-lore
description: "Write or update Memory — the sole path by which lore is written"
---

# write-lore

`write-lore` is the sole path for writing Memory. Every Memory write goes through it — including the writes other verbs make (`close-session` writes the journal and updates the registry, `init` and `upgrade` write the Memory skeleton and migration shapes, `mount` writes the registry and the new-child record). Routing every write through one verb is what gives it its guarantees: it owns *placement* (the right folder for each lore type), it owns *structure* (the schema'd frontmatter and body), it owns **claim enforcement** (refuses writes outside the mounted track's claim), and it carries the **three golden rules** and the **discard guard**.

A session that edits a Memory file directly has bypassed the verb — that is a defect.

## The status tree's structure is not write-lore's

`write-lore` fills the **bodies** of status-tree nodes — the gate text, the context prose, the stack notes — under schema and claim. It does **not** create, move, or restructure nodes: adding a focus/stage/phase, relocating a subtree, changing the tree's shape is the job of the status-tree verbs ([`grow`](./grow.md) / [`advance`](./advance.md) / [`archive`](./archive.md)), for every track. This split is deliberate — structure rots under free-hand editing, so it is locked behind verbs whose step-lists preserve the tree's invariants; body prose inside a correctly-placed node was never the problem, so it stays with `write-lore`. If a requested write would create or move a node, route it through `grow`/`archive` instead.

## What writes, by track type

`write-lore` honours the **track type** — there is no posture gate (v0.7 removed it). See [`tracks.md`](../tracks.md#track-types):

- **Trackless** — cannot write. A trackless session asked to write triggers the [`mount`](./mount.md) flow: home is auto-mounted if free, otherwise the Human Lead is prompted (or the session stays trackless and skips the write). If the only thing being written is a journal entry or a backlog item, the session is a **light track** and writes those directly — no mount.
- **Light** — may write **only** the journal and the [backlog](../status.md#backlog). Placement, schema, and the journal/backlog-only restriction all apply; the writes land as drift on trunk for a home session to acknowledge (a light track cannot `ack`). Any other target is refused.
- **Full** — may write anything within its claim, through `write-lore` (bodies) and the status-tree verbs (structure).

## Inputs

- **Target** — the Memory node or area being written. Named by the Human Lead, or inferred from the conversation. When inferred, state the target you resolved before writing.
- **Intent** — what the change is.

## The operation

1. **Resolve placement.** Route by lore type:
   - focus / stage / phase **body** → the node's file in the status tree (`status/<focus>/...`). The node's *structure* — its folder, index, and place in the tree — is created by [`grow`](./grow.md), not here (see below).
   - track → `tracks/`
   - insight → the knowledge tree at the correct branch (`reconciled` / `working` / `notepad`)
   - contract → `blueprint/contracts/`
   - process → `blueprint/processes/`
   - tooling entry → `blueprint/tooling/`
   - Payload-area description → `blueprint/mirror/<matching path>/`
   - session record → `journal/`
   - milestone → `save-points/`

   The Human Lead names *what*; you decide *where*. Never write the Payload.
2. **Check the claim.** The resolved path must be in the mounted track's claim, or be one of the shared carve-outs (`*.index.md` files, or `status.index.md`). A path outside the claim is refused — the Human Lead extends the claim, mounts a different track, or skips the write. See [`tracks.md`](../tracks.md#claims).
3. **Walk the focus chain.** Place the target in the chain and fix any ancestry reference the write disturbs. A write that leaves a stale reference above the target has not finished.
4. **Draft the write**, then check it against the golden rules.
5. **Run the discard guard.**
6. **Write** — including the schema frontmatter for the file's `type` (see [`memory.md`](../memory.md)).

## One operation, one guard

`write-lore` is a single operation, not a menu of sub-verbs. Filling a node body, writing a contract, recording a journal entry, a destructive rebuild of Memory content — each is `write-lore` aimed at a named target. (Creating or moving status-tree *nodes* is the exception, carved out to `grow`/`archive` above.)

The only branch is the **discard guard**, and its axis is mechanical: **does the write's own diff show existing content being removed with no equivalent landing elsewhere?**

- **No** — additive writes, and restructuring writes where content is relocated but still present, proceed ungated.
- **Yes** — stop. Show the Human Lead exactly what would be lost, and wait for explicit confirmation before writing.

A reshape that relocates content stays ungated. A rebuild that discards content trips the guard. Discarding Memory is the one write appending cannot undo — so it is the one write that is gated.

## The three golden rules

Check the drafted output against all three before the write lands. They are checks, not advice:

1. **Less is more.** Write the minimum that carries the meaning.
2. **Write to be reviewed.** The Human Lead reviews lore; write for that reader.
3. **Never duplicate.** Content that already exists in Memory or the Payload gets a reference, never a copy.

## Prerequisites

Read [`memory.md`](../memory.md) (the file schema, placement, tree discipline) and [`tracks.md`](../tracks.md) (claim enforcement) before writing.
