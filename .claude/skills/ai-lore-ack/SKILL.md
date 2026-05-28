---
name: ai-lore-ack
description: "Commit both repos on the mounted track's branches at a deliberate pause point — acknowledge accumulated work"
---

# ack

`ack` is how the Human Lead acknowledges accumulated work — a deliberate pause point where the working tree on the mounted track's branches becomes a reviewable commit. Same commit shape as [`save-point`](./save-point.md); no ledger entry, no blueprint check, no archive offer.

**The session never self-acks.** Acknowledgement is the Human Lead's confirmation that accumulated work has been reviewed; only they can give it.

## When the Human Lead invokes it

- After reviewing a batch of accumulated changes — Memory writes, Payload edits, or both — and wanting to mark a pause point in the working stream.
- Before switching context, mounting a different focus, or stopping work for a while, if the work is not yet milestone-level (which would be [`save-point`](./save-point.md)).
- Whenever the working tree is large enough that further work would compound the drift to an unreviewable size.

## What every ack is

A commit on the mounted track's branches — `trunk` on home, or `track/<name>` on a child track — in each dirty repo, with a Human-Lead-confirmed message capturing what is being acknowledged. Both repos commit together as one unit of acknowledgement; if only one repo is dirty, only that repo commits, but the unit is still "this ack on this track."

A vague ack defeats the purpose — the message is what makes the acknowledgement reviewable later. The session helps draft a specific message grouped by area (focus, journal, blueprint, KT, AT, Payload); the Human Lead confirms or edits before the commit lands.

Ack is a **deliberate** acknowledgement — the message ceremony is the point. For mid-execution commits that don't need that ceremony — chunking during an execution run where the work is small and the next step is to keep going — use [`ack-and-continue`](./ack-and-continue.md) instead.

## Trackless sessions cannot ack

`ack` requires a mounted track — there is no branch for a trackless session to commit on. A trackless session that has been asked to acknowledge has nothing to acknowledge; the dirty state lives on a track, not on the session.

## Independent from close-session

`ack` and [`close-session`](./close-session.md) are orthogonal. ack does not run close-session and does not prompt about it. close-session does not run ack and does not prompt about it. They are different operations:

- **ack** acknowledges accumulated work mid-stream — the session continues afterward.
- **close-session** is the session-ending bookend — it writes the journal and commits the closing state itself, separately from any ack the session may have done earlier.

Their writes never trail each other: if a session ends with a clean ack-then-close-session sequence, close-session's own commit captures the journal and any new drift; if the session ends without a prior ack, close-session still captures everything dirty. The previous coupling — ack offering close-session as a prompt — has been removed because most acks have nothing to do with closing.

## Relationship to other verbs

- [`ack-and-continue`](./ack-and-continue.md) — the lighter sibling. Same commit shape; minimal message ceremony; used for mid-execution chunking when no pause is intended.
- [`save-point`](./save-point.md) — the heavier cousin. Home-only consolidation primitive; adds the ledger entry, blueprint-contract check, and archive offer on top of the ack's commit shape; refuses if any child track is open. A save-point on a dirty tree includes the implicit ack — the commit it produces *is* the acknowledgement of the working state.
