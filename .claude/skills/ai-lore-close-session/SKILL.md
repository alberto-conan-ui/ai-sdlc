---
name: ai-lore-close-session
description: "Session close — write the journal, handover, surface any drift on the mounted track"
---

# close-session

`close-session` is the **session-closing bookend.** It leaves the session in a state the next session can pick up from. The session runs `close-session` on itself at the end of every session; the Human Lead does not invoke it.

## What close-session leaves behind

- **A journal entry for this session, if a track was mounted.** `journal/live/YYYY-MM-DD_NN.md`, with frontmatter (`date`, `session`, `track`, `focus`, `dials`, `posture`), a body covering the work done, and a **handover** section last — where the work stands, what the next session does first, what to watch.
- **An updated registry.** `status/status.index.md` reflects the journal trail, the open-tracks list, the per-track drift summary, and the relevant pointers. The mounted track's record is unmounted (`mounted_by` cleared); the track itself persists for the next session to mount.
- **An honest drift signal on the mounted track.** `git status` re-checked on both repos at the track's branches. If either is dirty, the unacknowledged changes are named — the Human Lead can [`ack`](./ack.md), [`save-point`](./save-point.md) (on master, with no children open), or close the session knowing work is uncommitted on this track. The session does not self-ack.
- **An empty-track prompt, if applicable.** If the mounted track is a child that has zero commits on its branch since creation, close-session asks the Human Lead whether to [`abandon`](./abandon.md) the track now or keep it for a later session. Abandon is never automatic.

Every Memory write goes through [`write-lore`](./write-lore.md). If insights from this session are immediately clear and well-placed, the session may also write them into the knowledge tree; if not, the journal carries them and they are placed deliberately later. Links in new files are verified to resolve.

## Trackless sessions leave no trace

A session that never mounted a track writes **no journal entry** and updates nothing in Memory at close. Trackless sessions are the ephemeral read-only mode for consulting the project; they leave the audit trail untouched. The session simply ends.

## No coordination with other sessions

Each session closes independently. If another session is running concurrently on a different track, this close-session does not wait for it and does not look at its state. The other session's drift, journal, and unmount are its own concern; consolidation across all tracks happens at [`save-point`](./save-point.md), not at close-session.

An engine binding may reinforce `close-session` with a SessionEnd hook so a session cannot close without it; the methodology does not depend on the reinforcement.
