---
type: verb
name: ack
title: ack — acknowledge accumulated work
family: acknowledgement
track: full
invoker: human-lead
writes:
  - commits on the mounted track's branches, both repos, payload-first
  - next-save-point accumulator (one row per ack)
contracts:
  - golden-rule
  - ack-pairing
updated: 2026-07-02
---

# ack

The Human Lead acknowledges accumulated work: the dirty tree on the mounted track's
branches becomes a reviewable commit — **both repos as one unit, recorded as one row
in the next-save-point accumulator**. The deliberate pause-point verb; the message
ceremony is the point.

## When to invoke

- After reviewing a batch of accumulated changes — Memory, Payload, or both.
- Before switching context or stopping, when the work is not milestone-level
  (that is [`save-point`](./save-point.verb.md)).
- When further work would compound the drift past reviewable size.
- NOT mid-execution between chunks — that is
  [`ack-and-continue`](./ack-and-continue.verb.md), same commit shape, no ceremony.

## What an ack is

**The pairing discipline (the ack-pairing contract, mechanically):**

1. **Payload commits first** (if dirty), on the track's branch.
2. **The accumulator row is appended** to the open next-save-point entry: date, verb
   (`ack`), track, branch, the payload commit's hash, one-line summary. If only the
   lore repo was dirty, the payload-hash column records `—` (lore-only ack).
3. **The lore repo commits second**, carrying the row. The row's lore-side commit is
   **self-identifying** — the commit that added row N *is* ack N's lore half; no
   hash needs storing for it.

That ordering is why any consumer (a companion app, a future session) can resolve
every cross-repo pair mechanically from one file — no timestamp heuristics, ever.

**Branches.** The commit lands on the mounted track's branches — home's branch for
home (named `trunk` in the methodology's role-language; the *actual* name lives on
home's track record — `main` in most real projects; the record is authoritative),
`track/<name>` for a child. Both repos, same branch name.

**The message.** Grouped by area (focus, status, journal, blueprint, Payload),
specific enough that the acknowledgement is reviewable later — a vague ack defeats
the verb. The session drafts; the Human Lead confirms or edits before anything
lands. **Sessions never self-ack** — acknowledgement is the Human Lead's act; the
git operation is just the mechanism.

Independent of [`close-session`](./close-session.verb.md) — neither runs nor prompts
about the other.

## The operation

1. **Verify the invoker** is the Human Lead; mounted full track required (light
   tracks are forbidden to commit — their drift is home's to acknowledge).
2. **Confirm the verb** (golden rule).
3. **Draft the message** from the actual diff, area-grouped; the Human Lead
   confirms.
4. **Commit payload-first**, append the accumulator row, commit lore. Verify both
   trees clean.
5. **State the pair**: payload hash, lore hash, the row as written.

## Refusals

- Not the Human Lead → refuse; sessions never self-ack.
- Trackless or light → refuse; nothing to commit on / forbidden to commit.
- Clean trees → nothing to acknowledge; say so.

## Related

[`ack-and-continue`](./ack-and-continue.verb.md) the light sibling ·
[`save-point`](./save-point.verb.md) seals the accumulator ·
[`close-session`](./close-session.verb.md) commits its own closing state ·
[`merge-track`](./merge-track.verb.md) / [`abandon-track`](./abandon-track.verb.md)
append their own rows.
