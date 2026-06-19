# mount

`mount` attaches a session to a **full track**. A trackless session can read everything in the project but cannot write; mounting is how a session enters full write-capable state. (Light tracks are not mounted — they write the journal/backlog directly; see [`tracks.md`](../tracks.md#track-types).)

## When mount fires

The Human Lead may invoke `mount` explicitly at any point — useful when the track is known up front, before any write is requested. The session also triggers mount implicitly the moment a trackless session is asked to make a **full-track write** — directly via [`write-lore`](./write-lore.md) against a Payload or general-Memory target, or indirectly through any verb that writes ([`grow`](./grow.md) / [`advance`](./advance.md) / [`archive`](./archive.md), [`ack`](./ack.md), [`save-point`](./save-point.md)). A write confined to the journal or backlog does not mount — it is light-track work.

The implicit flow has a **fast path**: if the only candidate is home and home is unmounted, the session auto-mounts home silently and proceeds with the write. No Human Lead prompt is needed. This preserves the single-session common case — a project with no parallelism behaves exactly as before.

If home is mounted by another session, or if unmounted child tracks are open, the session pauses and asks the Human Lead: mount an existing unmounted track, or stay trackless and skip the write. **`mount` does not create child tracks** — a child must already have been opened with [`spawn`](./spawn.md) from home. If no suitable track exists, the answer is to spawn one first (from a home session), then mount it.

## What mount does

`mount` **attaches** a session to an **already-existing** track — it never creates one. Two outcomes, depending on the choice:

- **Auto-mount home.** Silent. The session reads `tracks/home.track.md`, takes its claim and focus pointer, and writes its session ID into the track's `mounted_by` field. If home has no `claim` set on its record and the active focus carries one, home's working claim is seeded from `focus.claim` at this moment. If home's claim is already set (from a previous session's polish), it is preserved — focus switch is the trigger that re-seeds, not plain mount. Home's branch is `trunk`; no branch operation is needed.
- **Mount an existing child.** The session reads `tracks/<name>.track.md` (opened earlier by [`spawn`](./spawn.md)), takes its claim and focus, writes its session ID into `mounted_by`, and checks out `track/<name>` on both the lore repo and the Payload repo.

In all three cases, the open-tracks registry in `status.index.md` is updated to reflect the new mount. If the mounted track has a focus pointer, `mount` also writes the track's name into that focus's **active-mark** in [`status.stack.md`](../status.md#statusstackmd--the-focus-registry) — the active relationship is set here, not by hand. Unmounting (at close, merge, or abandon) clears it.

## Walking the chain

Once mounted, if the track has a focus pointer, the session walks the focus chain from that focus down through its stages and phases to the tip — the same chain walk [`orient`](./orient.md) does when there is only one open track at session open.

## What mount refuses

- **A track that is already mounted by another session.** Two sessions cannot share a track.
- **A request to mount a child that does not exist.** `mount` attaches to an existing record only; the child must first be opened with [`spawn`](./spawn.md) from home. (Name-uniqueness and claim-disjointness are checked by `spawn` at creation, not here.)
- **A mount request when the session already has a track.** Sessions hold at most one track at a time; close the session and reopen to switch.

## Relationship to other verbs

`mount` is the entry to full-track writing. [`merge`](./merge.md) and [`abandon`](./abandon.md) are the exits — they dispose of a child track when its work lands on home or is discarded. Home is never merged or abandoned; it is permanent.

A session that only needs to read (trackless) or to jot the journal/backlog (light track) never mounts — mounting is for full-track work alone.

## Prerequisites

Read [`tracks.md`](../tracks.md) (the track primitive, claims, the mount flow) and [`git.md`](../git.md) (checking out a track's branch on both repos) before mounting.
