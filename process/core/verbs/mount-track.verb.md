---
type: verb
name: mount-track
title: mount-track — attach a session to a workspace
family: tracks
track: n/a (this verb creates the session's track state)
writes:
  - track record (mounted_by, claim seeding)
  - status.stack.md (active-mark)
  - git checkout of the track's branches (children)
contracts:
  - golden-rule
updated: 2026-07-02
---

# mount-track

Attach a session to an **existing full track** — the entry to write-capable state. A
trackless session reads everything and writes nothing; mounting is what changes
that.

## When to invoke

- Explicitly, when the Human Lead knows the track up front.
- Implicitly, the moment a trackless session is asked to make a full-track write —
  every writing verb routes here when unmounted. The **fast path**: if the only
  candidate is home and home is free, auto-mount silently and proceed; the
  single-session project never feels the machinery.
- NOT for journal/backlog/notepad-only writes — that is light-track work, unmounted
  by design.

## What mounting means

- **One session per track; one track per session.** No sharing, no swapping — to
  switch tracks, close the session and reopen.
- **Attach, never create.** The track must exist —
  home always does; a child must have been [`spawn-track`](./spawn-track.verb.md)ed.
- **Home**: no checkout needed (home is trunk). Its claim seeds from the active
  focus's `claim` on first mount; an already-set claim is preserved (focus switch
  re-seeds, not plain mount).
- **Child**: check out `track/<name>` on **both** repos — the two-repo pairing holds
  at the branch level; a payload on the child branch with lore on trunk is a torn
  state.
- **Registration**: session ID into the record's `mounted_by`; the track's name into
  the focus's **active-mark** in `status.stack.md` (active is derived from tracks —
  set here, cleared at unmount/merge/abandon).
- Then **walk the chain**: from the track's focus down through stages and phases to
  the tip — the same walk orient does. A mounted session is expert on its focus, not
  just permitted to write it. If the focus is `draft`, first work moves it to
  `in progress` (the no-ceremony start).

## The operation

1. **Confirm the verb** (golden rule) — silent on the auto-mount fast path, which is
   its one sanctioned elision (the write that triggered it carries the
   confirmation).
2. **Resolve the candidate**: named track, or home (fast path), or ask the Human
   Lead when home is taken and children exist.
3. **Verify mountable**: exists, and `mounted_by` is blank (a dead session's stale
   mount is [`release-track`](./release-track.verb.md)'s business — never steal).
4. **Check out branches** (child), **register** (`mounted_by`, active-mark, claim
   seeding), **walk the chain**.
5. **State the mount**: track, claim, focus, chain tip.

## Refusals

- Track already mounted → refuse; point at `release-track` if the holder is dead.
- Track does not exist → refuse; `spawn-track` from home first.
- Session already mounted → refuse; one track per session, close to switch.

## Related

[`spawn-track`](./spawn-track.verb.md) creates ·
[`release-track`](./release-track.verb.md) recovers stale mounts ·
[`update-track`](./update-track.verb.md) polishes the claim ·
[`orient`](./orient.verb.md) runs the same chain walk at session open ·
[`close-session`](./close-session.verb.md) unmounts.
