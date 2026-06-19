---
name: ai-lore-spawn
description: "Create a child track from home — opens its record + branch; Human-Lead-managed, does not mount"
---

# spawn

`spawn` creates a new full (child) track. It is run from a session mounted on **home** — child tracks are always managed from the main track. `spawn` produces the track's **record and branch**; it does **not** attach a session. A *different* session mounts the track afterward via [`mount`](./mount.md), once the record exists.

This separates **creating** a track from **working** it. Earlier, `mount` did both — it conjured a child on the fly and attached in one step. v0.7 splits them: creation is a deliberate, home-managed act the Human Lead and the session settle together (name, claim, focus); mounting is a *separate* session entering the already-opened track. A track that exists with no session is the normal in-flight-idle state.

## The operation

1. **Run from home.** `spawn` refuses if the session is not mounted on home — child tracks are spawned from the main track only (topology is flat: home plus N siblings, no nesting, so there is no spawning from a child).
2. **Settle the track's shape with the Human Lead** — the session proposes, the Human Lead confirms:
   - a **unique name** (not colliding with any open track);
   - a **non-overlapping claim** (disjoint from every open track's claim, with the `*.index.md` / `status.index.md` carve-out);
   - an optional **focus** pointer.
3. **Write the record.** `tracks/<name>.track.md` is written through [`write-lore`](./write-lore.md), and the track is registered in the open-tracks list on `status.index.md`.
4. **Branch.** `track/<name>` is branched from trunk on both repos.

The track now exists, **unmounted**. A session mounts it with [`mount`](./mount.md); `spawn` never attaches a session itself.

## Human-Lead-managed

Spawning a track is the Human Lead's decision, taken on home — the session proposes name/claim/focus, the Human Lead confirms before the record is written. Like [`merge`](./merge.md) and [`abandon`](./abandon.md), the track lifecycle is Human-Lead-driven; a session never spawns a track on its own.

## Relationship to other verbs

`spawn` opens a child track (from home); [`mount`](./mount.md) attaches a session to it; [`merge`](./merge.md) and [`abandon`](./abandon.md) are the exits. Home is never spawned (it exists from `init`), merged, or abandoned. The full child lifecycle is **spawn → mount → … → merge/abandon**.

## Prerequisites

Read [`tracks.md`](../tracks.md) (the track primitive, types, and claims) and [`git.md`](../git.md) (branching both repos together) before spawning.
