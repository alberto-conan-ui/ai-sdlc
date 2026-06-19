---
name: ai-lore-advance
description: "Move a focus's lifecycle status (draft/paused/in progress/done) on the stack file"
---

# advance

`advance` moves a focus's lifecycle status. It is one of the three verbs that own the status tree's structure — [`grow`](./grow.md) adds, `advance` moves status, [`archive`](./archive.md) finishes.

The focus statuses are a fixed enum: **`draft` → `in progress` → `done`**, with **`paused`** as a side state. `advance` is the only way to change them, and it updates exactly one thing: the focus's row in [`status.stack.md`](../status.md#statusstackmd--the-focus-registry).

## The transitions

- **`draft` → `in progress`** — work starts.
- **`in progress` → `paused`** — set aside; `paused → in progress` to resume.
- **`in progress` → `done`** — **Human-Lead-only.** A session may advance a focus up to `in progress` (review is *not* a separate state — it lives inside `in progress`), but only the Human Lead calls a focus `done`. For a `build` focus the Human Lead checks the gate; for a `goal` focus the session delivers its opinionated critique and the Human Lead judges. This is where human accountability lives at the focus level.

## The operation

1. **Ensure a mounted track.** The focus must be within the mounted track's claim.
2. **Resolve the target status** from the enum; refuse anything outside the four words.
3. **If the move is `in progress` → `done`, confirm it is the Human Lead's call** — the session never self-declares done.
4. **Update the focus's row** in `status.stack.md`. Nothing else — the active-mark is [`mount`](./mount.md)'s job, the body is [`write-lore`](./write-lore.md)'s.

## Prerequisites

Read [`status.md`](../status.md) (the status enum and the stack file) before advancing.
