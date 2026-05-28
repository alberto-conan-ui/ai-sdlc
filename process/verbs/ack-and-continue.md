# ack-and-continue

`ack-and-continue` is the lightweight commit primitive — used mid-execution when the work has reached a clean chunk and the session should keep going. Same commit shape as [`ack`](./ack.md); minimal message ceremony; no pause for review.

**The session never self-acks.** Even the light version requires the Human Lead's confirmation of the commit message; only they can give the acknowledgement.

## When the Human Lead invokes it

- During an execution run, after a logical chunk of work has landed (a verb file written, a section completed, a step in a multi-step gate done).
- When the next step is to keep going, not to pause for review.
- When the drift is small enough that a quick message captures it cleanly — no grouping ceremony needed.

If the Human Lead wants to pause and inspect before continuing, [`ack`](./ack.md) is the right verb. If the work is milestone-worthy, [`save-point`](./save-point.md) is.

## What every ack-and-continue is

A commit on the mounted track's branches — `trunk` on master, or `track/<name>` on a child track — in each dirty repo, with a brief Human-Lead-confirmed message. Both repos commit together as one unit; if only one repo is dirty, only that repo commits.

The session drafts a short message — one to two lines, focused on what just landed — and the Human Lead confirms or edits before the commit lands. The grouping-by-area drafting that [`ack`](./ack.md) does is skipped: ack-and-continue is for the case where the chunk is small enough that a single-line description suffices.

After the commit lands, the session resumes immediately. No journal write, no posture change, no close-session interaction.

## Trackless sessions cannot ack-and-continue

Same rule as [`ack`](./ack.md) — there is no branch for a trackless session to commit on.

## Independent from close-session

`ack-and-continue` and [`close-session`](./close-session.md) are orthogonal. The verb has no awareness of session ending; close-session has no awareness of prior ack-and-continue commits. close-session's own commit captures whatever drift exists at session end.

## Relationship to other verbs

- [`ack`](./ack.md) — the deliberate pause-point sibling. Same commit shape; message grouped by area; used when the next step is review, not continuation.
- [`save-point`](./save-point.md) — master-only milestone primitive; the heavier consolidation step.
