# mount

`mount` attaches a session to a track. A trackless session can read everything in the project but cannot write; mounting is how a session enters write-capable state.

## When mount fires

The Human Lead may invoke `mount` explicitly at any point — useful when the track is known up front, before any write is requested. The session also triggers mount implicitly the moment a trackless session is asked to write — directly via [`write-lore`](./write-lore.md), or indirectly through any verb that writes ([`plan`](./plan.md) / [`reshape`](./reshape.md) / [`execute`](./execute.md), [`redial`](./redial.md), [`ack`](./ack.md), [`save-point`](./save-point.md)).

The implicit flow has a **fast path**: if the only candidate is home and home is unmounted, the session auto-mounts home silently and proceeds with the write. No Human Lead prompt is needed. This preserves the single-session common case — a project with no parallelism behaves exactly as before.

If home is mounted by another session, or if unmounted child tracks are open, the session pauses and asks the Human Lead: mount an existing unmounted track, create a new child track, or stay trackless and skip the write.

## What mount does

Three outcomes, depending on the choice:

- **Auto-mount home.** Silent. The session reads `tracks/home.track.md`, takes its posture, dials, and focus pointer, and writes its session ID into the track's `mounted_by` field. If home has no `claim` set on its record and the active focus carries one, home's working claim is seeded from `focus.claim` at this moment. If home's claim is already set (from a previous session's polish), it is preserved — focus switch is the trigger that re-seeds, not plain mount. Home's branch is `trunk`; no branch operation is needed.
- **Mount an existing child.** The session reads `tracks/<name>.track.md`, takes its state, writes its session ID into `mounted_by`, and checks out `track/<name>` on both the lore repo and the Payload repo.
- **Create a new child.** The Human Lead provides a **unique name** (not colliding with any open track) and a **non-overlapping claim** (disjoint from every open track's claim, with the `*.index.md` and `status.index.md` carve-out). The focus pointer is optional; posture defaults to `execute`; dials default to the project's defaults. The session creates `tracks/<name>.track.md`, branches `track/<name>` from trunk on both repos, and mounts.

In all three cases, the open-tracks registry in `status.index.md` is updated to reflect the new mount.

## Walking the chain

Once mounted, if the track has a focus pointer, the session walks the focus chain from that pointer down through any action tree to the tip — the same chain walk [`orient`](./orient.md) does when there is only one open track at session open.

## What mount refuses

- **A track that is already mounted by another session.** Two sessions cannot share a track.
- **A new child track whose claim overlaps any open track's claim** (carve-outs excepted).
- **A new child track whose name is already in use** by another open track. Names become reusable once the colliding track is removed.
- **A mount request when the session already has a track.** Sessions hold at most one track at a time; close the session and reopen to switch.

## Relationship to other verbs

`mount` is the entry to writing. [`merge`](./merge.md) and [`abandon`](./abandon.md) are the exits — they dispose of a child track when its work lands on home or is discarded. Home is never merged or abandoned; it is permanent.

[`chat`](./chat.md) does not trigger mount: chat-while-trackless is the implicit no-op posture and requires no track.
