---
name: ai-lore-close-session
description: "Session close — write the journal, handover, surface any drift on the mounted track"
---

# close-session

`close-session` is the **session-closing bookend.** It leaves the session in a state the next session can pick up from. The session runs `close-session` on itself at the end of every session; the Human Lead does not invoke it.

## What close-session leaves behind

- **A journal entry for this session, if a track was mounted.** `journal/live/YYYY-MM-DD_NN.md`, with frontmatter (`date`, `session`, `track`, `focus`, `dials`, `posture`), a body covering the work done, and a **handover** section last — where the work stands, what the next session does first, what to watch.
- **An updated registry.** `status/status.index.md` reflects the journal trail, the open-tracks list, the per-track drift summary, and the relevant pointers. The mounted track's record is unmounted (`mounted_by` cleared); the track itself persists for the next session to mount.
- **A Human-Lead-confirmed closing commit.** The journal write, the status update, and any drift already on the working tree are committed together on the mounted track's branches — `trunk` on home, or `track/<name>` on a child — as one closing commit per dirty repo. The session drafts a closing message; the Human Lead confirms or edits before the commit lands. This is how close-session avoids leaving a trail of uncommitted journal writes behind a clean working tree.
- **An empty-track prompt, if applicable.** If the mounted track is a child that has zero commits on its branch since creation, close-session asks the Human Lead whether to [`abandon`](./abandon.md) the track now or keep it for a later session. Abandon is never automatic.

Every Memory write goes through [`write-lore`](./write-lore.md). If insights from this session are immediately clear and well-placed, the session may also write them into the knowledge tree; if not, the journal carries them and they are placed deliberately later. Links in new files are verified to resolve.

## The session never self-acks

The closing commit is **Human-Lead-confirmed**, not session-autonomous. close-session drafts the closing message and presents it; the Human Lead confirms or edits before the commit lands. The "session never self-acks" rule holds because the Human Lead remains the acknowledgement gate — the same gate as [`ack`](./ack.md) and [`save-point`](./save-point.md). What changes is the timing: the closing commit is the bookend's own move, not a separate [`ack`](./ack.md) invocation chained afterward.

This decouples close-session from ack. [`ack`](./ack.md) and [`ack-and-continue`](./ack-and-continue.md) are independent verbs the Human Lead invokes mid-stream; close-session is the bookend that wraps up at session end. Neither prompts about the other.

## Trackless sessions leave no trace

A session that never mounted a track writes **no journal entry** and updates nothing in Memory at close. No closing commit fires either — there is no branch to commit on and nothing was written. Trackless sessions are the ephemeral read-only mode for consulting the project; they leave the audit trail untouched. The session simply ends.

## No coordination with other sessions

Each session closes independently. If another session is running concurrently on a different track, this close-session does not wait for it and does not look at its state. The other session's drift, journal, and unmount are its own concern; consolidation across all tracks happens at [`save-point`](./save-point.md), not at close-session.

An engine binding may reinforce `close-session` with a session-end hook so a session cannot close without it. The reinforcement is advisory in practice — by the time a session-end hook fires, the session is already closing and may not get a turn to act on the hook's instruction. The methodology does not depend on the reinforcement; close-session is intrinsic behaviour the session performs on itself before the user signals exit.
