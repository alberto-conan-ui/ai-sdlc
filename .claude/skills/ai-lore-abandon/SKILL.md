---
name: ai-lore-abandon
description: "Discard a child track — auto-acks first, then removes branch and record"
---

# abandon

`abandon` discards a child track. Its work is not landed on home; the branch and the track record are removed. The Human Lead invokes it after deciding the track's work should not become part of the project's canonical history.

**Abandonment auto-acks first.** Any uncommitted work on the track's branch is committed before the branch is deleted. The commits remain in git's object store and could be cherry-picked back later if needed — abandonment removes the *reference*, not the underlying objects. Destruction is reversible by anyone who keeps a record of the commit hash.

## When the Human Lead invokes it

- An exploratory track turned out not to be worth landing.
- A track that became stale and is no longer in flight.
- A track whose work has been superseded by other work and should not merge.
- A track that is empty (no commits since creation) — abandonment is trivially safe in this case, but still Human-Lead-confirmed.

## What every abandon is

- **A confirmation prompt.** The session shows the track's name, branch, claim, and recent commits, and asks the Human Lead to confirm. Destruction is not silent.
- **An auto-ack of any uncommitted work** on the track's branch, on both repos. Whatever was dirty is committed first, so the work survives in the object store.
- **The branch is deleted on both repos.**
- **The track record is removed.** `tracks/<name>.track.md` is deleted; the name becomes available for reuse.
- **The registry is updated.** The open-tracks list in `status.index.md` drops the abandoned track.

## What abandon does not do

- **It does not delete the underlying commits.** Git's object store retains them until garbage collection. A commit hash from the abandoned branch can be cherry-picked or branched from at any time before GC. If the work might be valuable later, the Human Lead can also [`merge`](./merge.md) instead of abandoning, or branch from the commit to recover.
- **It does not touch other tracks.** Other open tracks continue as they were.

## Refusals

- **Home cannot be abandoned.** Home is permanent.
- **A track actively mounted by another session** is not abandoned out from under that session. The Human Lead closes that session first, or has it unmount.

## Independent from close-session

Abandon and [`close-session`](./close-session.md) are orthogonal. The auto-ack happens internally to abandon (so the commits survive in the object store before the branch is deleted); abandon does not run close-session and does not prompt about it. If the Human Lead abandons and then ends the session, close-session writes its journal entry afterwards and commits those writes itself in its own closing commit.

## Relationship to other verbs

`abandon` is the destructive exit from a child track. [`merge`](./merge.md) is the alternative — land the work instead of discarding. Both end a child track's lifecycle; [`mount`](./mount.md) is the entry.

## Prerequisites

Read [`tracks.md`](../tracks.md) (the track lifecycle) and [`git.md`](../git.md) (the auto-ack and branch deletion on both repos) before abandoning.
