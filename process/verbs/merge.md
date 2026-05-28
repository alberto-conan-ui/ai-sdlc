# merge

`merge` lands a child track's work onto home. The Human Lead invokes it after reviewing the work on the child branch.

**The session never self-merges.** Landing work on home is an acknowledgement that the work is canonical — the same kind of acknowledgement [`ack`](./ack.md) and [`save-point`](./save-point.md) are. A session running on a child track may complete its work, ack its branch, and close, but the merge step is the Human Lead's call.

## When the Human Lead invokes it

- After reviewing a child track's accumulated work — its commits on `track/<name>`, the focus state, the journal entries from sessions that mounted it.
- Once the child track's work is ready to be part of the project's canonical history.
- The child track has typically been unmounted (no session) when merged; merging out from under an actively mounted session is possible but unusual — the Human Lead would normally close that session or have it ack and unmount first.

## What every merge is

- **A git merge on both repos.** The child track's branch (`track/<name>`) is merged into trunk, on the lore repo and the Payload repo in parallel — the same one-unit pattern as [`ack`](./ack.md) and [`save-point`](./save-point.md). Conflicts — typically in `*.index.md` files and `status.index.md` (the shared write surfaces) — are resolved before the merge commits.
- **The track record is removed.** `tracks/<name>.track.md` is deleted; its name becomes available for reuse.
- **The branch is deleted on both repos** after the merge lands.
- **The registry is updated.** The open-tracks list in `status.index.md` drops the child.

## What merge does not do

- **It does not take a save-point.** Merge lands the work; save-points are a separate consolidation step, home-only, and require every other child track to be closed first. If the merge completes a milestone worth a save-point, the Human Lead invokes [`save-point`](./save-point.md) afterward — on home, with no children open.
- **It does not import the child's working state into home.** The child's posture, dials, and focus pointer were its own; landing the branch does not change home's record. Home's posture, dials, and focus are unchanged.

## Refusals

- **Home cannot be merged.** Home sits on trunk; there is no branch to land.

## Independent from close-session

Merge and [`close-session`](./close-session.md) are orthogonal. Merge lands the work; it does not run close-session and does not prompt about it. If the Human Lead merges and then ends the session, close-session writes its journal entry afterwards and commits those writes itself in its own closing commit.

## Relationship to other verbs

`merge` is the canonical exit from a child track — the work landed on home. [`abandon`](./abandon.md) is the alternative exit — the work discarded. [`mount`](./mount.md) is the entry. [`save-point`](./save-point.md) is the further step after merge when the landed work is milestone-worthy.
