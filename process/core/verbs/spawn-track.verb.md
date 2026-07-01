---
type: verb
name: spawn-track
title: spawn-track — open a child workspace
family: tracks
track: full
invoker: human-lead
writes:
  - tracks/<name>.track.md (new record)
  - tracks index
  - git branches track/<name> on both repos
contracts:
  - golden-rule
updated: 2026-07-02
---

# spawn-track

Create a **child track** from home: record + branches, deliberately, before any
session mounts it. **Human-Lead-managed** — parallelism is a project decision, not a
session convenience.

## When to invoke

- Contention requires it: a second stream of work wants to proceed while home is
  busy, on a disjoint area.
- NOT to attach the current session (that is
  [`mount-track`](./mount-track.verb.md) — a different act, usually a different
  session) and NOT for a quick journal/backlog/notepad jot (a light track needs no
  spawn, no record, no branch).

## What a track is

A persistent workspace: **branch + claim + focus pointer**, outliving the sessions
that mount it. Home always exists on the trunk branch; children branch from home and
end by [`merge-track`](./merge-track.verb.md) or
[`abandon-track`](./abandon-track.verb.md). Topology is **flat** — home plus N
siblings; no child of a child, no spawning from a child.

The record, `tracks/<name>.track.md`:

| Frontmatter | Meaning |
|---|---|
| `type: track`, `name` | unique among open tracks (reusable after removal) |
| `branch` | `track/<name>`, identical on both repos |
| `claim` | path prefixes this track may write — **strictly disjoint** from every other open track's, checked at spawn |
| `focus` (optional) | the focus this workspace works |
| `mounted_by` (blank at spawn) | set by `mount-track` |

**Claims are the safety.** Disjoint by prefix across all open tracks, with the
shared carve-outs (`*.index.md` files, the status registry, the next-save-point
accumulator — merge-time conflicts there are the accepted cost of parallelism).
While a child claims an area, home may not write it.

## The operation

1. **Verify the invoker** is the Human Lead, and the session is home-mounted.
2. **Confirm the verb** (golden rule).
3. **Settle the design**: name, claim (verify disjointness against every open
   track), focus pointer if any.
4. **Branch both repos**: `track/<name>` on the Payload repo and the lore repo, from
   the current trunk state.
5. **Write the record** and wire the tracks index.
6. **State the child's shape** — it exists unmounted; a session attaches via
   `mount-track`.

## Refusals

- Invoked from a child track → refuse; children are spawned from home only.
- Claim overlaps an open track → refuse; recut the claims with the Human Lead.
- Name collides with an open track → refuse.

## Related

[`mount-track`](./mount-track.verb.md) attaches ·
[`merge-track`](./merge-track.verb.md) / [`abandon-track`](./abandon-track.verb.md)
end it · [`update-track`](./update-track.verb.md) reshapes the claim mid-life ·
[`save-point`](./save-point.verb.md) refuses while children are open.
