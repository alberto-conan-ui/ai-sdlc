---
type: verb
name: release-track
title: release-track — clear a dead session's stale mount
family: tracks
track: any (recovery runs from wherever the live session is)
invoker: human-lead
writes:
  - track record (mounted_by cleared)
contracts:
  - golden-rule
updated: 2026-07-02
---

# release-track

Clear a stale `mounted_by` left by a session that died without closing. The recovery
verb: one field, surgically, **Human-Lead-invoked** — because "that session is dead"
is a judgement about the world outside the project, and only the Human Lead can make
it.

## When to invoke

- A crash, a killed terminal, a lost machine: the session never ran its closing
  bookend, the record still names it, and every mount attempt refuses with "already
  mounted."
- NOT to take a track from a session that might be alive — two sessions on one track
  corrupts the workspace guarantee that everything else stands on. When in doubt,
  the answer is no.

## What releasing means

Exactly one write: `mounted_by` → blank. Nothing else — the dead session's
uncommitted drift on the track's branches **stays**, honestly dirty, waiting for the
next mounting session to read (via orient's drift check) and for the Human Lead to
acknowledge or discard through the ack family. Releasing does not clean, does not
commit, does not judge the drift — untangling "what was that session doing" belongs
to whoever mounts next, with the journal's last entry as the map.

The active-mark in `status.stack.md` stays too — the *track* still points at the
focus; only the session evaporated. (Mount-state and active-mark move together only
when the track's life changes; a release changes the session, not the track.)

## The operation

1. **Verify the invoker** is the Human Lead, and the deadness: is the named session
   genuinely gone? (The session ID and the journal's last entry are the evidence to
   read back.)
2. **Confirm the verb** (golden rule).
3. **Clear the field**; `updated:` on the record.
4. **State the track's condition**: released, its drift intact and waiting, its
   focus still marked — mountable again.

## Refusals

- Not the Human Lead → refuse.
- The session may be alive → refuse; never steal a mount.
- Asked to also clean up the drift → refuse here; that is the next mounted
  session's work through the proper verbs (this verb stays one-field small on
  purpose — recovery tools that do more than they say are how recoveries go wrong).

## Related

[`mount-track`](./mount-track.verb.md) refuses stale mounts and points here ·
[`orient`](./orient.verb.md) surfaces the drift the dead session left ·
[`ack`](./ack.verb.md) acknowledges it once understood ·
[`abandon-track`](./abandon-track.verb.md) if the whole track turns out to be dead
with its session.
